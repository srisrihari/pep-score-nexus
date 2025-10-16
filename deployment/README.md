# 🚀 PEP Score Nexus - Production Deployment Guide

## 📋 Production URLs
- **Frontend**: https://uat.pep.vijaybhoomi.edu.in
- **Backend API**: https://api.uat.pep.vijaybhoomi.edu.in

## 🛠️ Prerequisites
- Node.js 18+
- npm 9+
- Supabase project (URL, Service Role key)
- SSL certificates for production domains

## 1️⃣ Environment Configuration

### Backend Production Environment
```bash
cd backend
cp deployment/backend.env.example .env.production
```

**Required Environment Variables:**
```bash
# Supabase Configuration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
SUPABASE_ANON_KEY=your-anon-key

# Application Configuration
PORT=3001
NODE_ENV=production
JWT_SECRET=your-jwt-secret-here

# Production URLs
FRONTEND_URL=https://uat.pep.vijaybhoomi.edu.in
CORS_ORIGIN=https://uat.pep.vijaybhoomi.edu.in

# Microsoft SSO (if using)
MICROSOFT_CLIENT_ID=your-client-id
MICROSOFT_CLIENT_SECRET=your-client-secret
MICROSOFT_AUTHORITY=https://login.microsoftonline.com/your-tenant-id/v2.0
MICROSOFT_REDIRECT_URI=https://api.uat.pep.vijaybhoomi.edu.in/api/v1/auth/microsoft-direct/callback
```

### Frontend Production Environment
```bash
cd frontend
cp deployment/frontend.env.example .env.production
```

**Required Environment Variables:**
```bash
# Backend API Configuration
VITE_API_BASE_URL=https://api.uat.pep.vijaybhoomi.edu.in

# Application Configuration
VITE_APP_NAME=PEP Score Nexus
VITE_APP_VERSION=1.0.0
VITE_NODE_ENV=production

# Microsoft SSO (if using)
VITE_MICROSOFT_CLIENT_ID=your-client-id
VITE_MICROSOFT_AUTHORITY=https://login.microsoftonline.com/your-tenant-id/v2.0
VITE_MICROSOFT_REDIRECT_URI=https://uat.pep.vijaybhoomi.edu.in/auth/sso-callback
VITE_MICROSOFT_POST_LOGOUT_REDIRECT_URI=https://uat.pep.vijaybhoomi.edu.in
```

## 2️⃣ Database Migration (Required)

⚠️ **Critical**: Apply the HPS improvements migration in Supabase:

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Copy and paste the contents of `database/migrations/add_hps_auto_recalculation_triggers.sql`
4. Execute the SQL to create HPS management tables and triggers

## 3️⃣ Backend Deployment

### Option A: PM2 (Recommended for Production)
```bash
# Install PM2 globally
npm install -g pm2

# Start backend with PM2
cd backend
pm2 start src/server.js --name "pep-backend" --env production

# Save PM2 configuration
pm2 save
pm2 startup
```

### Option B: Docker
```dockerfile
# Create Dockerfile in backend/
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3001
CMD ["npm", "start"]
```

### Option C: systemd (Linux servers)
Create `/etc/systemd/system/pep-backend.service`:
```ini
[Unit]
Description=PEP Score Nexus Backend
After=network.target

[Service]
Type=simple
User=pep-user
WorkingDirectory=/home/pep-user/pep-score-nexus/backend
Environment=NODE_ENV=production
ExecStart=/usr/bin/node src/server.js
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

## 4️⃣ Frontend Deployment

### Option A: Static Hosting (nginx/Apache)
```bash
cd frontend
npm run build

# Deploy dist/ folder to your web server
# Configure nginx to serve the static files
```

### Option B: Docker
```dockerfile
# Create Dockerfile in frontend/
FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### nginx Configuration Example
```nginx
server {
    listen 80;
    server_name uat.pep.vijaybhoomi.edu.in;

    root /var/www/html;
    index index.html;

    # Enable gzip compression
    gzip on;
    gzip_types text/css application/javascript text/javascript application/json;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;

    # Handle client-side routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy (if backend is on same server)
    location /api/ {
        proxy_pass https://api.uat.pep.vijaybhoomi.edu.in;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 5️⃣ SSL Certificate Setup

### Using Let's Encrypt (certbot)
```bash
# Install certbot
sudo apt install certbot python3-certbot-nginx

# Generate certificates
sudo certbot --nginx -d uat.pep.vijaybhoomi.edu.in -d api.uat.pep.vijaybhoomi.edu.in

# Auto-renewal (add to crontab)
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 6️⃣ Health Check & Monitoring

### Backend Health Check
```bash
curl https://api.uat.pep.vijaybhoomi.edu.in/health
```

### Frontend Health Check
```bash
curl https://uat.pep.vijaybhoomi.edu.in
```

## 7️⃣ Troubleshooting

### Common Issues

**401 Unauthorized in frontend:**
- Ensure `VITE_API_BASE_URL` points to correct backend URL
- Check that backend CORS allows frontend origin
- Verify JWT tokens are being sent properly

**HPS scores not updating:**
- Ensure database migration was applied
- Check that HPS background service is running
- Verify microcompetency scores are being saved

**Database connection issues:**
- Verify Supabase credentials in `.env.production`
- Check network connectivity to Supabase
- Ensure database user has proper permissions

## 8️⃣ Post-Deployment Checklist

- [ ] Backend health check passes
- [ ] Frontend loads without errors
- [ ] User authentication works
- [ ] HPS scores display correctly in admin panel
- [ ] Database triggers are working (test by adding a microcompetency score)
- [ ] SSL certificates are valid
- [ ] All environment variables are set correctly
- [ ] Monitoring/alerts are configured

## 🔒 Security Considerations

1. **Environment Variables**: Never commit `.env.production` files
2. **JWT Secrets**: Use strong, unique secrets for production
3. **Database Credentials**: Store securely, rotate regularly
4. **SSL/TLS**: Always use HTTPS in production
5. **CORS**: Restrict to specific production domains only

## 📞 Support

For deployment issues:
1. Check server logs: `pm2 logs pep-backend`
2. Verify environment variables are loaded
3. Test API endpoints manually with curl
4. Check database connectivity

---

**🎉 Deployment Complete!** Your PEP Score Nexus application is now running in production at:
- **Frontend**: https://uat.pep.vijaybhoomi.edu.in
- **Backend API**: https://api.uat.pep.vijaybhoomi.edu.in

