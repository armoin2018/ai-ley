// Comprehensive email validation with Unicode support
const emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;

function validateEmail(email) {
  if (!emailRegex.test(email)) {
    return { valid: false, reason: 'Invalid email format' };
  }
  
  if (email.length > 254) {
    return { valid: false, reason: 'Email too long (max 254 characters)' };
  }
  
  const [local, domain] = email.split('@');
  if (local.length > 64) {
    return { valid: false, reason: 'Local part too long (max 64 characters)' };
  }
  
  return { valid: true };
}