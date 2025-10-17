const validateParams = (requiredParams) => {
    return (req, res, next) => {
        const missingParams = requiredParams.filter(param => {
            return !(param in req.params) || !req.params[param];
        });

        if (missingParams.length > 0) {
            return res.status(400).json({
                success: false,
                error: `Missing required parameters: ${missingParams.join(', ')}`
            });
        }

        next();
    };
};

const validateBody = (requiredFields) => {
    return (req, res, next) => {
        const missingFields = requiredFields.filter(field => {
            return !(field in req.body) || req.body[field] === undefined;
        });

        if (missingFields.length > 0) {
            return res.status(400).json({
                success: false,
                error: `Missing required fields: ${missingFields.join(', ')}`
            });
        }

        next();
    };
};

const validateQuery = (requiredParams) => {
    return (req, res, next) => {
        const missingParams = requiredParams.filter(param => {
            return !(param in req.query) || !req.query[param];
        });

        if (missingParams.length > 0) {
            return res.status(400).json({
                success: false,
                error: `Missing required query parameters: ${missingParams.join(', ')}`
            });
        }

        next();
    };
};

const validateUUID = (params) => {
    return (req, res, next) => {
        const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
        
        const invalidParams = params.filter(param => {
            const value = req.params[param];
            return value && !uuidRegex.test(value);
        });

        if (invalidParams.length > 0) {
            return res.status(400).json({
                success: false,
                error: `Invalid UUID format for parameters: ${invalidParams.join(', ')}`
            });
        }

        next();
    };
};

const validateNumeric = (fields) => {
    return (req, res, next) => {
        const invalidFields = fields.filter(field => {
            const value = req.body[field];
            return value !== undefined && (isNaN(value) || !isFinite(value));
        });

        if (invalidFields.length > 0) {
            return res.status(400).json({
                success: false,
                error: `Invalid numeric values for fields: ${invalidFields.join(', ')}`
            });
        }

        next();
    };
};

const validateDateRange = (startField, endField) => {
    return (req, res, next) => {
        const start = new Date(req.body[startField]);
        const end = new Date(req.body[endField]);

        if (isNaN(start.getTime())) {
            return res.status(400).json({
                success: false,
                error: `Invalid date format for ${startField}`
            });
        }

        if (isNaN(end.getTime())) {
            return res.status(400).json({
                success: false,
                error: `Invalid date format for ${endField}`
            });
        }

        if (start > end) {
            return res.status(400).json({
                success: false,
                error: `${startField} must be before ${endField}`
            });
        }

        next();
    };
};

module.exports = {
    validateParams,
    validateBody,
    validateQuery,
    validateUUID,
    validateNumeric,
    validateDateRange
};
