const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');
const XLSX = require('xlsx');
const { supabase, query } = require('../config/supabase');
const { normalizeGender } = require('../utils/genderNormalizer');

// Configure multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = path.join(__dirname, '../../uploads');
    
    // Create uploads directory if it doesn't exist
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    // Generate unique filename
    const uniqueName = `${uuidv4()}-${Date.now()}${path.extname(file.originalname)}`;
    cb(null, uniqueName);
  }
});

// File filter for allowed file types
const fileFilter = (req, file, cb) => {
  const allowedTypes = [
    'application/pdf',
    'application/msword',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'application/vnd.ms-powerpoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'text/plain',
    'image/jpeg',
    'image/png',
    'image/gif'
  ];

  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error('Invalid file type. Only PDF, Word, PowerPoint, Excel, text, and image files are allowed.'), false);
  }
};

// Configure multer
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 10 * 1024 * 1024, // 10MB limit
    files: 5 // Maximum 5 files per upload
  }
});

// Upload single file
const uploadSingleFile = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'No file uploaded',
        timestamp: new Date().toISOString()
      });
    }

    const fileInfo = {
      id: uuidv4(),
      originalName: req.file.originalname,
      filename: req.file.filename,
      mimetype: req.file.mimetype,
      size: req.file.size,
      uploadedBy: req.user.userId,
      uploadedAt: new Date().toISOString(),
      url: `/api/v1/uploads/files/${req.file.filename}`
    };

    res.status(200).json({
      success: true,
      message: 'File uploaded successfully',
      data: fileInfo,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error uploading file:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to upload file',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Upload multiple files
const uploadMultipleFiles = async (req, res) => {
  try {
    if (!req.files || req.files.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No files uploaded',
        timestamp: new Date().toISOString()
      });
    }

    const filesInfo = req.files.map(file => ({
      id: uuidv4(),
      originalName: file.originalname,
      filename: file.filename,
      mimetype: file.mimetype,
      size: file.size,
      uploadedBy: req.user.userId,
      uploadedAt: new Date().toISOString(),
      url: `/api/v1/uploads/files/${file.filename}`
    }));

    res.status(200).json({
      success: true,
      message: `${req.files.length} files uploaded successfully`,
      data: filesInfo,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error uploading files:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to upload files',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Serve uploaded files
const serveFile = async (req, res) => {
  try {
    const { filename } = req.params;
    const filePath = path.join(__dirname, '../../uploads', filename);

    // Check if file exists
    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        success: false,
        message: 'File not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get file stats
    const stats = fs.statSync(filePath);
    const fileSize = stats.size;

    // Set appropriate headers
    res.setHeader('Content-Length', fileSize);
    res.setHeader('Content-Disposition', `inline; filename="${filename}"`);

    // Determine content type based on file extension
    const ext = path.extname(filename).toLowerCase();
    const contentTypes = {
      '.pdf': 'application/pdf',
      '.doc': 'application/msword',
      '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      '.ppt': 'application/vnd.ms-powerpoint',
      '.pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      '.txt': 'text/plain',
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif'
    };

    res.setHeader('Content-Type', contentTypes[ext] || 'application/octet-stream');

    // Stream the file
    const fileStream = fs.createReadStream(filePath);
    fileStream.pipe(res);

  } catch (error) {
    console.error('Error serving file:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to serve file',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Delete uploaded file
const deleteFile = async (req, res) => {
  try {
    const { filename } = req.params;
    const filePath = path.join(__dirname, '../../uploads', filename);

    // Check if file exists
    if (!fs.existsSync(filePath)) {
      return res.status(404).json({
        success: false,
        message: 'File not found',
        timestamp: new Date().toISOString()
      });
    }

    // Delete the file
    fs.unlinkSync(filePath);

    res.status(200).json({
      success: true,
      message: 'File deleted successfully',
      data: { filename },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error deleting file:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete file',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Preview Excel data before import (Step 1)
const previewExcelData = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'No file uploaded',
        timestamp: new Date().toISOString()
      });
    }

    const { importType } = req.body;
    if (!importType) {
      return res.status(400).json({
        success: false,
        message: 'Import type is required',
        timestamp: new Date().toISOString()
      });
    }

    // Validate file type
    const allowedExcelTypes = [
      'application/vnd.ms-excel',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    ];

    if (!allowedExcelTypes.includes(req.file.mimetype)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid file type. Only Excel files (.xls, .xlsx) are allowed.',
        timestamp: new Date().toISOString()
      });
    }

    // Read Excel file
    const workbook = XLSX.readFile(req.file.path);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(worksheet);

    let previewResults = {
      totalRows: data.length,
      validRows: 0,
      invalidRows: 0,
      errors: [],
      students: []
    };

    // Process data based on import type - for now just students
    if (importType === 'students') {
      previewResults = await previewStudentData(data);
    } else {
      return res.status(400).json({
        success: false,
        message: 'Only student import is supported in preview mode',
        timestamp: new Date().toISOString()
      });
    }

    // Store file temporarily with unique identifier
    const tempId = require('crypto').randomBytes(16).toString('hex');
    const tempPath = `${req.file.path}_${tempId}`;
    fs.renameSync(req.file.path, tempPath);

    res.status(200).json({
      success: true,
      message: 'Excel preview generated successfully',
      data: {
        ...previewResults,
        tempFileId: tempId
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Excel preview error:', error);

    // Clean up file if it exists
    if (req.file && fs.existsSync(req.file.path)) {
      fs.unlinkSync(req.file.path);
    }

    res.status(500).json({
      success: false,
      message: 'Failed to preview Excel data',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Import Excel data with batch assignment (Step 2)
const importExcelData = async (req, res) => {
  try {
    const { tempFileId, batchAssignment } = req.body;
    
    if (!tempFileId) {
      return res.status(400).json({
        success: false,
        message: 'Temporary file ID is required',
        timestamp: new Date().toISOString()
      });
    }

    if (!batchAssignment) {
      return res.status(400).json({
        success: false,
        message: 'Batch assignment data is required',
        timestamp: new Date().toISOString()
      });
    }

    // Find the temporary file
    const uploadsDir = process.env.UPLOADS_DIR || './uploads';
    const tempFiles = fs.readdirSync(uploadsDir).filter(file => file.includes(`_${tempFileId}`));
    
    if (tempFiles.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Temporary file not found or expired',
        timestamp: new Date().toISOString()
      });
    }

    const tempFilePath = `${uploadsDir}/${tempFiles[0]}`;

    // Read Excel file
    const workbook = XLSX.readFile(tempFilePath);
    const sheetName = workbook.SheetNames[0];
    const worksheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(worksheet);

    let importResults = {
      totalRows: data.length,
      successCount: 0,
      errorCount: 0,
      errors: []
    };

    // Process student data with batch assignment
    importResults = await importStudentDataWithAssignment(data, batchAssignment);

    // Clean up temporary file
    fs.unlinkSync(tempFilePath);

    res.status(200).json({
      success: true,
      message: `Student import completed. ${importResults.successCount} students imported successfully.`,
      data: importResults,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Excel import error:', error);

    res.status(500).json({
      success: false,
      message: 'Failed to import Excel data',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Helper function to preview student data
const previewStudentData = async (data) => {
  let validRows = 0;
  let invalidRows = 0;
  let errors = [];
  let students = [];

  // Utility: normalize headers to snake_case lowercase keys
  const normalizeRow = (row) => {
    const map = {};
    Object.keys(row || {}).forEach((key) => {
      const normalized = String(key)
        .trim()
        .toLowerCase()
        .replace(/\s+/g, '_')
        .replace(/[^a-z0-9_]/g, '');
      map[normalized] = row[key];
    });
    return map;
  };

  for (let i = 0; i < data.length; i++) {
    try {
      const raw = data[i];
      const row = normalizeRow(raw);

      const name = row.name || row.full_name || row.student_name;
      const email = row.email;
      const registrationNo = row.registration_no || row.registration || row.reg_no;
      const phone = row.phone || row.mobile || null;
      
      // Normalize gender value
      let gender;
      try {
        gender = normalizeGender(row.gender);
      } catch (error) {
        throw new Error(`Invalid gender value: ${row.gender}`);
      }

      // Validate required fields for preview (only basic fields)
      if (!name || !email || !registrationNo) {
        errors.push(`Row ${i + 1}: Missing required fields (name, email, registration_no)`);
        invalidRows++;
        continue;
      }

      // Validate email format
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(email)) {
        errors.push(`Row ${i + 1}: Invalid email format (${email})`);
        invalidRows++;
        continue;
      }

      // Check for duplicates within the file
      const isDuplicate = students.some(s => 
        s.email === email || s.registration_no === registrationNo
      );
      
      if (isDuplicate) {
        errors.push(`Row ${i + 1}: Duplicate email or registration number in file`);
        invalidRows++;
        continue;
      }

      students.push({
        rowNumber: i + 1,
        name: name.trim(),
        email: email.trim(),
        registration_no: registrationNo.trim(),
        phone: phone ? phone.trim() : null,
        gender
      });

      validRows++;

    } catch (error) {
      errors.push(`Row ${i + 1}: ${error.message}`);
      invalidRows++;
    }
  }

  return {
    totalRows: data.length,
    validRows,
    invalidRows,
    errors,
    students
  };
};

// Helper function to import student data with batch assignment
const importStudentDataWithAssignment = async (data, batchAssignment) => {
  let successCount = 0;
  let errorCount = 0;
  let errors = [];

  console.log('🔧 Importing students with batch assignment:', batchAssignment);

  // Utility: normalize headers to snake_case lowercase keys
  const normalizeRow = (row) => {
    const map = {};
    Object.keys(row || {}).forEach((key) => {
      const normalized = String(key)
        .trim()
        .toLowerCase()
        .replace(/\s+/g, '_')
        .replace(/[^a-z0-9_]/g, '');
      map[normalized] = row[key];
    });
    return map;
  };

  // Get current term id once
  const currentTermResult = await query(
    supabase
      .from('terms')
      .select('id')
      .eq('is_current', true)
      .limit(1)
  );
  const currentTermId = currentTermResult.rows && currentTermResult.rows[0] ? currentTermResult.rows[0].id : null;

  // Get batch and section IDs from assignment
  const { batchId, sectionId, course } = batchAssignment;

  for (let i = 0; i < data.length; i++) {
    try {
      const raw = data[i];
      const row = normalizeRow(raw);

      const name = row.name || row.full_name || row.student_name;
      const email = row.email;
      const registrationNo = row.registration_no || row.registration || row.reg_no;
      const phone = row.phone || row.mobile || null;
      
      // Normalize gender value
      let gender;
      try {
        gender = normalizeGender(row.gender);
      } catch (error) {
        throw new Error(`Invalid gender value: ${row.gender}`);
      }

      // Validate required fields
      if (!name || !email || !registrationNo) {
        errors.push(`Row ${i + 1}: Missing required fields (name, email, registration_no)`);
        errorCount++;
        continue;
      }

      // Check existing user by email or username (registration no)
      const existingUserResult = await query(
        supabase
          .from('users')
          .select('id')
          .or(`email.eq.${email},username.eq.${registrationNo}`)
          .limit(1)
      );

      let userId;
      if (existingUserResult.rows && existingUserResult.rows.length > 0) {
        userId = existingUserResult.rows[0].id;
      } else {
        // Create new user with password = registration_no
        const createUserResult = await query(
          supabase
            .from('users')
            .insert({
              username: registrationNo,
              email,
              password: registrationNo, // Password defaults to registration number
              role: 'student',
              status: 'active'
            })
            .select('id')
        );

        if (!createUserResult.rows || createUserResult.rows.length === 0) {
          throw new Error('Failed to create user');
        }
        userId = createUserResult.rows[0].id;
      }

      // Check for existing student with same registration number
      const existingStudentResult = await query(
        supabase
          .from('students')
          .select('id')
          .eq('registration_no', registrationNo)
          .limit(1)
      );
      
      if (existingStudentResult.rows && existingStudentResult.rows.length > 0) {
        errors.push(`Row ${i + 1}: Student with registration number ${registrationNo} already exists`);
        errorCount++;
        continue;
      }

      // Create student with assigned batch/section/course
      const createStudentResult = await query(
        supabase
          .from('students')
          .insert({
            user_id: userId,
            registration_no: registrationNo,
            name,
            course: course || 'General',
            batch_id: batchId,
            section_id: sectionId,
            gender,
            phone,
            status: 'Active',
            current_term_id: currentTermId || null
          })
          .select('id')
      );

      if (!createStudentResult.rows || createStudentResult.rows.length === 0) {
        throw new Error('Failed to create student');
      }

      successCount++;

    } catch (error) {
      console.error(`❌ Error importing student row ${i + 1}:`, error);
      errors.push(`Row ${i + 1}: ${error.message}`);
      errorCount++;
    }
  }

  return {
    totalRows: data.length,
    successCount,
    errorCount,
    errors
  };
};

// Helper function to import student data
const importStudentData = async (data) => {
  let successCount = 0;
  let errorCount = 0;
  let errors = [];

  // Utility: normalize headers to snake_case lowercase keys
  const normalizeRow = (row) => {
    const map = {};
    Object.keys(row || {}).forEach((key) => {
      const normalized = String(key)
        .trim()
        .toLowerCase()
        .replace(/\s+/g, '_')
        .replace(/[^a-z0-9_]/g, '');
      map[normalized] = row[key];
    });
    return map;
  };

  // Get current term id once
  const currentTermResult = await query(
    supabase
      .from('terms')
      .select('id')
      .eq('is_current', true)
      .limit(1)
  );
  const currentTermId = currentTermResult.rows && currentTermResult.rows[0] ? currentTermResult.rows[0].id : null;

  for (let i = 0; i < data.length; i++) {
    try {
      const raw = data[i];
      const row = normalizeRow(raw);

      const name = row.name || row.full_name || row.student_name;
      const email = row.email;
      const registrationNo = row.registration_no || row.registration || row.reg_no;
      const providedPassword = row.password || null;
      const course = row.course || 'General';
      const batchName = row.batch || row.batch_name;
      const sectionName = row.section || row.section_name;
      // Normalize gender value
      let gender;
      try {
        gender = normalizeGender(row.gender);
      } catch (error) {
        throw new Error(`Row ${i + 1}: ${error.message}`);
      }
      const phone = row.phone || row.mobile || null;

      // Validate required fields
      if (!name || !email || !registrationNo) {
        errors.push(`Row ${i + 1}: Missing required fields (name, email, registration_no)`);
        errorCount++;
        continue;
      }

      // Check existing user by email or username (registration no)
      const existingUserResult = await query(
        supabase
          .from('users')
          .select('id')
          .or(`email.eq.${email},username.eq.${registrationNo}`)
          .limit(1)
      );

      let userId;
      if (existingUserResult.rows && existingUserResult.rows.length > 0) {
        userId = existingUserResult.rows[0].id;
      } else {
        // Create user with a temporary password if not provided in sheet
        // Prefer provided password; else default to registration number for initial login
        const tempPassword = providedPassword || String(registrationNo);
        const bcrypt = require('bcryptjs');
        const hashedPassword = await bcrypt.hash(tempPassword, 12);

        const createUserResult = await query(
          supabase
            .from('users')
            .insert({
              // Use registration number as username for student login
              username: String(registrationNo),
              email,
              password_hash: hashedPassword,
              role: 'student',
              status: 'active'
            })
            .select('id')
        );

        if (!createUserResult.rows || createUserResult.rows.length === 0) {
          throw new Error('Failed to create user');
        }
        userId = createUserResult.rows[0].id;
      }

      // Resolve batch and section by name if provided
      let batchId = null;
      if (batchName) {
        const batchRes = await query(
          supabase
            .from('batches')
            .select('id,name')
            .ilike('name', batchName)
            .limit(1)
        );
        if (batchRes.rows && batchRes.rows[0]) batchId = batchRes.rows[0].id;
      }

      let sectionId = null;
      if (sectionName) {
        const sectionRes = await query(
          supabase
            .from('sections')
            .select('id,name')
            .ilike('name', sectionName)
            .limit(1)
        );
        if (sectionRes.rows && sectionRes.rows[0]) sectionId = sectionRes.rows[0].id;
      }

      // Prevent duplicate student by registration_no
      const existingStudentResult = await query(
        supabase
          .from('students')
          .select('id')
          .eq('registration_no', registrationNo)
          .limit(1)
      );
      if (existingStudentResult.rows && existingStudentResult.rows.length > 0) {
        // Skip duplicates
        errors.push(`Row ${i + 1}: Duplicate registration_no (${registrationNo}) - skipped`);
        errorCount++;
        continue;
      }

      // Create student
      const createStudentResult = await query(
        supabase
          .from('students')
          .insert({
            user_id: userId,
            registration_no: registrationNo,
            name,
            course,
            batch_id: batchId,
            section_id: sectionId,
            gender,
            phone,
            status: 'Active',
            current_term_id: currentTermId || null
          })
          .select('id')
      );

      if (!createStudentResult.rows || createStudentResult.rows.length === 0) {
        throw new Error('Failed to create student');
      }

      successCount++;

    } catch (error) {
      errors.push(`Row ${i + 1}: ${error.message}`);
      errorCount++;
    }
  }

  return {
    totalRows: data.length,
    successCount,
    errorCount,
    errors
  };
};

// Helper function to import score data
const importScoreData = async (data) => {
  // Simplified implementation
  return {
    totalRows: data.length,
    successCount: data.length,
    errorCount: 0,
    errors: []
  };
};

// Helper function to import attendance data
const importAttendanceData = async (data) => {
  // Simplified implementation
  return {
    totalRows: data.length,
    successCount: data.length,
    errorCount: 0,
    errors: []
  };
};

module.exports = {
  upload,
  uploadSingleFile,
  uploadMultipleFiles,
  serveFile,
  deleteFile,
  previewExcelData,
  importExcelData
};
