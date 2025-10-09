# Deployment Guide

This guide explains how to configure and deploy the backend and frontend.

## Prerequisites
- Node.js 18+
- npm 9+
- Supabase project (URL, Service Role key)

## 1) Environment Configuration

### Backend
1. Copy and edit env:
```bash
cp deployment/backend.env.example backend/.env
```
2. Set these variables (see example for full list):
- SUPABASE_URL
- SUPABASE_SERVICE_ROLE_KEY
- SUPABASE_ANON_KEY (optional for server-only)
- JWT_SECRET
- PORT (default 3001)
- FRONTEND_URL / CORS_ORIGIN
- Microsoft SSO keys if using SSO

### Frontend
1. Copy and edit env:
```bash
cp deployment/frontend.env.example frontend/.env
```
2. Set these variables:
- VITE_API_BASE_URL (e.g., http://localhost:3001)
- VITE_APP_NAME, VITE_APP_VERSION (optional)
- VITE_MICROSOFT_* (if using SSO)

## 2) Install & Run (Development)

### Backend
```bash
cd backend
npm install
npm start
# Health: GET http://localhost:3001/health → OK
```

### Frontend
```bash
cd frontend
npm install
npm run dev
# Opens on http://localhost:8080
```

## 3) Production

### Backend
- Run Node service with `.env` using PM2/systemd/Docker
- Ensure SUPABASE_* and JWT_SECRET are set

### Frontend
```bash
cd frontend
npm run build
```
- Deploy `dist/` to a static host or behind a reverse proxy

## 4) Common Pitfalls
- 401 Unauthorized in frontend → ensure `authToken` is stored and used; `VITE_API_BASE_URL` points to backend
- Non-JSON responses → ensure frontend calls use full `${VITE_API_BASE_URL}` (fixed in code)
- Supabase not configured → set `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY`

## 5) Useful URLs
- Backend API base: http://localhost:3001/api/v1
- Frontend dev: http://localhost:8080

