// ✅ Named exports for utilities
// utils/validation.js
export function validateEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

export function validatePassword(password) {
  return password.length >= 8 && /[A-Za-z]/.test(password) && /\d/.test(password);
}

export const ValidationError = class extends Error {
  constructor(message, field) {
    super(message);
    this.name = 'ValidationError';
    this.field = field;
  }
};

// ✅ Default export for main class/function
// services/user.service.js
export default class UserService {
  // Class implementation
}

// ✅ Re-exports for clean API
// services/index.js
export { default as UserService } from './user.service.js';
export { default as AuthService } from './auth.service.js';
export { default as EmailService } from './email.service.js';

// ✅ Import patterns
// app.js
import express from 'express';
import { UserService, AuthService } from './services/index.js';
import { validateEmail, validatePassword } from './utils/validation.js';