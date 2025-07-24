---
layout: docs
title: Security Best Practices
---

# Security Best Practices

Secure your ACE-Flow applications with comprehensive security measures, authentication hardening, and compliance frameworks.

## Overview

Security in ACE-Flow applications involves multiple layers:
- Authentication and authorization
- Data protection and encryption
- API security measures
- Infrastructure security
- Compliance and audit trails

## Authentication Hardening

### Multi-Factor Authentication (MFA)

Implement robust MFA for user accounts:

```typescript
// amplify/auth/resource.ts
export const auth = defineAuth({
  loginWith: {
    email: true,
    username: false
  },
  multifactor: {
    mode: 'REQUIRED',
    totp: true,
    sms: true
  },
  passwordPolicy: {
    minLength: 12,
    requireUppercase: true,
    requireLowercase: true,
    requireNumbers: true,
    requireSymbols: true
  },
  accountRecovery: 'EMAIL_ONLY'
});
```

### Advanced Password Policies

Implement sophisticated password validation:

```typescript
// utils/password-validator.ts
export class PasswordValidator {
  private readonly minLength = 12;
  private readonly maxLength = 128;
  private readonly commonPasswords = new Set([
    'password123', 'admin123', '123456789'
    // Load from common passwords database
  ]);
  
  validate(password: string): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    
    // Length check
    if (password.length < this.minLength) {
      errors.push(`Password must be at least ${this.minLength} characters`);
    }
    
    if (password.length > this.maxLength) {
      errors.push(`Password must be no more than ${this.maxLength} characters`);
    }
    
    // Complexity checks
    if (!/[A-Z]/.test(password)) {
      errors.push('Password must contain uppercase letters');
    }
    
    if (!/[a-z]/.test(password)) {
      errors.push('Password must contain lowercase letters');
    }
    
    if (!/\d/.test(password)) {
      errors.push('Password must contain numbers');
    }
    
    if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) {
      errors.push('Password must contain special characters');
    }
    
    // Common password check
    if (this.commonPasswords.has(password.toLowerCase())) {
      errors.push('Password is too common');
    }
    
    // Sequential character check
    if (this.hasSequentialChars(password)) {
      errors.push('Password cannot contain sequential characters');
    }
    
    return {
      valid: errors.length === 0,
      errors
    };
  }
  
  private hasSequentialChars(password: string): boolean {
    for (let i = 0; i < password.length - 2; i++) {
      const char1 = password.charCodeAt(i);
      const char2 = password.charCodeAt(i + 1);
      const char3 = password.charCodeAt(i + 2);
      
      if (char2 === char1 + 1 && char3 === char2 + 1) {
        return true;
      }
    }
    return false;
  }
}
```

### Session Management

Implement secure session handling:

```typescript
// utils/session-manager.ts
export class SessionManager {
  private readonly maxSessionAge = 24 * 60 * 60 * 1000; // 24 hours
  private readonly inactivityTimeout = 30 * 60 * 1000; // 30 minutes
  
  async createSession(userId: string, userAgent: string, ipAddress: string) {
    const sessionId = this.generateSecureId();
    const session = {
      id: sessionId,
      userId,
      userAgent,
      ipAddress,
      createdAt: new Date(),
      lastActivity: new Date(),
      isActive: true
    };
    
    await this.storeSession(session);
    return sessionId;
  }
  
  async validateSession(sessionId: string, ipAddress: string, userAgent: string) {
    const session = await this.getSession(sessionId);
    
    if (!session || !session.isActive) {
      throw new Error('Invalid session');
    }
    
    // Check session age
    if (Date.now() - session.createdAt.getTime() > this.maxSessionAge) {
      await this.invalidateSession(sessionId);
      throw new Error('Session expired');
    }
    
    // Check inactivity
    if (Date.now() - session.lastActivity.getTime() > this.inactivityTimeout) {
      await this.invalidateSession(sessionId);
      throw new Error('Session timed out due to inactivity');
    }
    
    // Verify IP and user agent (optional strict mode)
    if (process.env.STRICT_SESSION_VALIDATION === 'true') {
      if (session.ipAddress !== ipAddress || session.userAgent !== userAgent) {
        await this.invalidateSession(sessionId);
        throw new Error('Session security violation');
      }
    }
    
    // Update last activity
    await this.updateLastActivity(sessionId);
    
    return session;
  }
  
  private generateSecureId(): string {
    const crypto = require('crypto');
    return crypto.randomBytes(32).toString('hex');
  }
}
```

## Data Protection Strategies

### Encryption at Rest

Implement comprehensive data encryption:

```typescript
// utils/encryption.ts
import * as crypto from 'crypto';

export class DataEncryption {
  private readonly algorithm = 'aes-256-gcm';
  private readonly keyLength = 32;
  
  encrypt(data: string, key: Buffer): { encrypted: string; iv: string; tag: string } {
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipher(this.algorithm, key, { iv });
    
    let encrypted = cipher.update(data, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    
    const tag = cipher.getAuthTag();
    
    return {
      encrypted,
      iv: iv.toString('hex'),
      tag: tag.toString('hex')
    };
  }
  
  decrypt(encrypted: string, key: Buffer, iv: string, tag: string): string {
    const decipher = crypto.createDecipher(this.algorithm, key, {
      iv: Buffer.from(iv, 'hex')
    });
    
    decipher.setAuthTag(Buffer.from(tag, 'hex'));
    
    let decrypted = decipher.update(encrypted, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    
    return decrypted;
  }
  
  generateKey(): Buffer {
    return crypto.randomBytes(this.keyLength);
  }
}

// Field-level encryption for sensitive data
export const encryptSensitiveFields = (data: any, sensitiveFields: string[]) => {
  const encryption = new DataEncryption();
  const key = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex');
  
  const encrypted = { ...data };
  
  sensitiveFields.forEach(field => {
    if (encrypted[field]) {
      const result = encryption.encrypt(encrypted[field], key);
      encrypted[field] = JSON.stringify(result);
      encrypted[`${field}_encrypted`] = true;
    }
  });
  
  return encrypted;
};
```

### PII Data Handling

Implement secure handling of personally identifiable information:

```typescript
// utils/pii-handler.ts
export class PIIHandler {
  private readonly sensitiveFields = [
    'email', 'phone', 'ssn', 'creditCard', 'address'
  ];
  
  async sanitizeForLogging(data: any): Promise<any> {
    const sanitized = { ...data };
    
    this.sensitiveFields.forEach(field => {
      if (sanitized[field]) {
        sanitized[field] = this.maskField(sanitized[field], field);
      }
    });
    
    return sanitized;
  }
  
  private maskField(value: string, fieldType: string): string {
    switch (fieldType) {
      case 'email':
        const [local, domain] = value.split('@');
        return `${local.substring(0, 2)}***@${domain}`;
      
      case 'phone':
        return `***-***-${value.slice(-4)}`;
      
      case 'ssn':
        return `***-**-${value.slice(-4)}`;
      
      case 'creditCard':
        return `****-****-****-${value.slice(-4)}`;
      
      default:
        return '***';
    }
  }
  
  async redactSensitiveData(data: any): Promise<any> {
    const redacted = { ...data };
    
    this.sensitiveFields.forEach(field => {
      if (redacted[field]) {
        redacted[field] = '[REDACTED]';
      }
    });
    
    return redacted;
  }
}
```

## API Security Measures

### Request Rate Limiting

Implement sophisticated rate limiting:

```typescript
// middleware/rate-limiter.ts
import { RateLimiterRedis } from 'rate-limiter-flexible';

export class APIRateLimiter {
  private limiters = new Map<string, RateLimiterRedis>();
  
  constructor() {
    // Different limits for different endpoints
    this.setupLimiters();
  }
  
  private setupLimiters() {
    // General API rate limit
    this.limiters.set('general', new RateLimiterRedis({
      storeClient: redisClient,
      keyPrefix: 'rl_general',
      points: 100, // Number of requests
      duration: 60, // Per 60 seconds
      blockDuration: 60 // Block for 60 seconds if limit exceeded
    }));
    
    // Login attempts rate limit
    this.limiters.set('login', new RateLimiterRedis({
      storeClient: redisClient,
      keyPrefix: 'rl_login',
      points: 5, // 5 attempts
      duration: 900, // Per 15 minutes
      blockDuration: 900 // Block for 15 minutes
    }));
    
    // Password reset rate limit
    this.limiters.set('password_reset', new RateLimiterRedis({
      storeClient: redisClient,
      keyPrefix: 'rl_pwd_reset',
      points: 3, // 3 attempts
      duration: 3600, // Per hour
      blockDuration: 3600 // Block for 1 hour
    }));
  }
  
  async checkLimit(key: string, identifier: string, limiterType = 'general') {
    const limiter = this.limiters.get(limiterType);
    if (!limiter) {
      throw new Error(`Unknown limiter type: ${limiterType}`);
    }
    
    try {
      await limiter.consume(identifier);
      return { allowed: true };
    } catch (rejRes) {
      return {
        allowed: false,
        remainingPoints: rejRes.remainingPoints,
        msBeforeNext: rejRes.msBeforeNext,
        totalHits: rejRes.totalHits
      };
    }
  }
}
```

### Input Validation and Sanitization

Implement comprehensive input validation:

```typescript
// utils/input-validator.ts
import DOMPurify from 'isomorphic-dompurify';
import validator from 'validator';

export class InputValidator {
  validateAndSanitize(input: any, schema: any): any {
    const sanitized: any = {};
    
    for (const [field, rules] of Object.entries(schema)) {
      const value = input[field];
      
      if (rules.required && !value) {
        throw new Error(`Field ${field} is required`);
      }
      
      if (!value) continue;
      
      // Type validation
      if (rules.type === 'email' && !validator.isEmail(value)) {
        throw new Error(`Invalid email format for field ${field}`);
      }
      
      if (rules.type === 'url' && !validator.isURL(value)) {
        throw new Error(`Invalid URL format for field ${field}`);
      }
      
      // Length validation
      if (rules.minLength && value.length < rules.minLength) {
        throw new Error(`Field ${field} must be at least ${rules.minLength} characters`);
      }
      
      if (rules.maxLength && value.length > rules.maxLength) {
        throw new Error(`Field ${field} must be no more than ${rules.maxLength} characters`);
      }
      
      // Pattern validation
      if (rules.pattern && !new RegExp(rules.pattern).test(value)) {
        throw new Error(`Field ${field} does not match required pattern`);
      }
      
      // Sanitization
      let sanitizedValue = value;
      
      if (rules.sanitize) {
        if (rules.sanitize.includes('html')) {
          sanitizedValue = DOMPurify.sanitize(sanitizedValue);
        }
        
        if (rules.sanitize.includes('sql')) {
          sanitizedValue = this.sanitizeSQL(sanitizedValue);
        }
        
        if (rules.sanitize.includes('xss')) {
          sanitizedValue = this.sanitizeXSS(sanitizedValue);
        }
      }
      
      sanitized[field] = sanitizedValue;
    }
    
    return sanitized;
  }
  
  private sanitizeSQL(input: string): string {
    // Remove common SQL injection patterns
    return input.replace(/[';\\x00\\n\\r\\x1a]/g, '');
  }
  
  private sanitizeXSS(input: string): string {
    // Remove potential XSS vectors
    return input
      .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
      .replace(/javascript:/gi, '')
      .replace(/on\w+\s*=/gi, '');
  }
}
```

### API Key Management

Implement secure API key handling:

```typescript
// utils/api-key-manager.ts
export class APIKeyManager {
  async generateAPIKey(userId: string, permissions: string[]): Promise<string> {
    const key = this.generateSecureKey();
    const hashedKey = await this.hashAPIKey(key);
    
    await this.storeAPIKey({
      userId,
      hashedKey,
      permissions,
      createdAt: new Date(),
      lastUsed: null,
      isActive: true,
      expiresAt: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000) // 1 year
    });
    
    return key;
  }
  
  async validateAPIKey(key: string): Promise<{ valid: boolean; permissions: string[] }> {
    const hashedKey = await this.hashAPIKey(key);
    const keyRecord = await this.getAPIKeyRecord(hashedKey);
    
    if (!keyRecord || !keyRecord.isActive) {
      return { valid: false, permissions: [] };
    }
    
    if (keyRecord.expiresAt < new Date()) {
      await this.deactivateAPIKey(hashedKey);
      return { valid: false, permissions: [] };
    }
    
    // Update last used timestamp
    await this.updateLastUsed(hashedKey);
    
    return {
      valid: true,
      permissions: keyRecord.permissions
    };
  }
  
  private generateSecureKey(): string {
    const crypto = require('crypto');
    const prefix = 'ak_'; // API key prefix
    const randomPart = crypto.randomBytes(32).toString('hex');
    return `${prefix}${randomPart}`;
  }
  
  private async hashAPIKey(key: string): Promise<string> {
    const crypto = require('crypto');
    return crypto.createHash('sha256').update(key).digest('hex');
  }
}
```

## Infrastructure Security

### Network Security

Configure secure network policies:

```typescript
// amplify/backend.ts - Security Groups
export const backend = defineBackend({
  // Configure VPC and security groups
  vpc: {
    cidr: '10.0.0.0/16',
    subnetConfiguration: [
      {
        name: 'private-subnet',
        subnetType: SubnetType.PRIVATE_WITH_EGRESS,
        cidrMask: 24
      },
      {
        name: 'public-subnet',
        subnetType: SubnetType.PUBLIC,
        cidrMask: 24
      }
    ]
  },
  
  securityGroups: {
    database: {
      allowedPorts: [5432], // PostgreSQL
      allowedSources: ['lambda-sg'] // Only Lambda functions
    },
    
    lambda: {
      allowedPorts: [443], // HTTPS only
      allowedSources: ['0.0.0.0/0'] // Internet access for API Gateway
    }
  }
});
```

### Secrets Management

Implement secure secrets handling:

```typescript
// utils/secrets-manager.ts
import { SecretsManager } from 'aws-sdk';

export class SecureSecretsManager {
  private client = new SecretsManager();
  private cache = new Map<string, { value: any; expiry: number }>();
  
  async getSecret(secretName: string, ttl = 300000): Promise<any> {
    // Check cache first
    const cached = this.cache.get(secretName);
    if (cached && cached.expiry > Date.now()) {
      return cached.value;
    }
    
    try {
      const result = await this.client.getSecretValue({
        SecretId: secretName
      }).promise();
      
      const value = JSON.parse(result.SecretString!);
      
      // Cache with TTL
      this.cache.set(secretName, {
        value,
        expiry: Date.now() + ttl
      });
      
      return value;
    } catch (error) {
      console.error(`Failed to retrieve secret ${secretName}:`, error);
      throw new Error('Secret retrieval failed');
    }
  }
  
  async updateSecret(secretName: string, secretValue: any): Promise<void> {
    try {
      await this.client.updateSecret({
        SecretId: secretName,
        SecretString: JSON.stringify(secretValue)
      }).promise();
      
      // Invalidate cache
      this.cache.delete(secretName);
    } catch (error) {
      console.error(`Failed to update secret ${secretName}:`, error);
      throw new Error('Secret update failed');
    }
  }
  
  async rotateSecret(secretName: string): Promise<void> {
    // Implement automatic secret rotation
    // This should be called periodically via CloudWatch Events
  }
}
```

## Compliance Frameworks

### GDPR Compliance

Implement GDPR compliance features:

```typescript
// utils/gdpr-compliance.ts
export class GDPRCompliance {
  async handleDataSubjectRequest(request: {
    type: 'access' | 'rectification' | 'erasure' | 'portability';
    userId: string;
    email: string;
  }) {
    switch (request.type) {
      case 'access':
        return await this.exportUserData(request.userId);
      
      case 'rectification':
        return await this.updateUserData(request.userId, request.data);
      
      case 'erasure':
        return await this.deleteUserData(request.userId);
      
      case 'portability':
        return await this.exportPortableData(request.userId);
    }
  }
  
  private async exportUserData(userId: string) {
    // Collect all user data from various sources
    const userData = {
      profile: await this.getUserProfile(userId),
      posts: await this.getUserPosts(userId),
      comments: await this.getUserComments(userId),
      analytics: await this.getUserAnalytics(userId)
    };
    
    // Log the data access request
    await this.logDataAccess(userId, 'export');
    
    return userData;
  }
  
  private async deleteUserData(userId: string) {
    // Implement right to be forgotten
    const deletionTasks = [
      this.deleteUserProfile(userId),
      this.anonymizeUserPosts(userId),
      this.deleteUserComments(userId),
      this.purgeUserAnalytics(userId)
    ];
    
    await Promise.all(deletionTasks);
    
    // Log the deletion
    await this.logDataDeletion(userId);
    
    return { deleted: true, timestamp: new Date() };
  }
}
```

### SOC 2 Compliance

Implement SOC 2 Type II controls:

```typescript
// utils/soc2-controls.ts
export class SOC2Controls {
  async logSecurityEvent(event: {
    type: string;
    userId?: string;
    ipAddress: string;
    userAgent: string;
    timestamp: Date;
    details: any;
  }) {
    // Immutable audit log entry
    const logEntry = {
      id: this.generateUUID(),
      ...event,
      hash: this.generateHash(event)
    };
    
    await this.storeAuditLog(logEntry);
    
    // Alert on critical security events
    if (this.isCriticalEvent(event.type)) {
      await this.sendSecurityAlert(logEntry);
    }
  }
  
  async generateComplianceReport(startDate: Date, endDate: Date) {
    const report = {
      accessLogs: await this.getAccessLogs(startDate, endDate),
      changeAudits: await this.getChangeAudits(startDate, endDate),
      securityIncidents: await this.getSecurityIncidents(startDate, endDate),
      dataProcessingActivities: await this.getDataProcessingActivities(startDate, endDate)
    };
    
    return {
      ...report,
      generatedAt: new Date(),
      reportHash: this.generateHash(report)
    };
  }
}
```

## Security Monitoring

### Real-time Threat Detection

Implement automated threat detection:

```typescript
// utils/threat-detector.ts
export class ThreatDetector {
  private anomalyThresholds = {
    failedLoginAttempts: 5,
    unusualAccessPatterns: 3,
    suspiciousApiCalls: 10
  };
  
  async analyzeUserBehavior(userId: string, activity: any) {
    const userProfile = await this.getUserBehaviorProfile(userId);
    const anomalies = this.detectAnomalies(activity, userProfile);
    
    if (anomalies.length > 0) {
      await this.handleSecurityAnomaly(userId, anomalies);
    }
  }
  
  private detectAnomalies(activity: any, profile: any): string[] {
    const anomalies: string[] = [];
    
    // Geographic anomaly detection
    if (this.isUnusualLocation(activity.location, profile.usualLocations)) {
      anomalies.push('unusual_location');
    }
    
    // Time-based anomaly detection
    if (this.isUnusualTime(activity.timestamp, profile.usualHours)) {
      anomalies.push('unusual_time');
    }
    
    // Device anomaly detection
    if (this.isUnusualDevice(activity.device, profile.knownDevices)) {
      anomalies.push('unusual_device');
    }
    
    return anomalies;
  }
  
  private async handleSecurityAnomaly(userId: string, anomalies: string[]) {
    // Log the security event
    await this.logSecurityEvent({
      type: 'security_anomaly',
      userId,
      anomalies,
      severity: this.calculateSeverity(anomalies),
      timestamp: new Date()
    });
    
    // Take appropriate action based on severity
    const severity = this.calculateSeverity(anomalies);
    
    if (severity === 'high') {
      await this.lockUserAccount(userId);
      await this.notifySecurityTeam(userId, anomalies);
    } else if (severity === 'medium') {
      await this.requireAdditionalAuth(userId);
    }
  }
}
```

### Security Metrics and Alerting

Implement comprehensive security monitoring:

```typescript
// utils/security-monitor.ts
export class SecurityMonitor {
  async trackSecurityMetrics() {
    const metrics = {
      failedLoginAttempts: await this.countFailedLogins(),
      activeSecurityIncidents: await this.countActiveIncidents(),
      vulnerabilityScore: await this.calculateVulnerabilityScore(),
      complianceScore: await this.calculateComplianceScore()
    };
    
    // Send metrics to monitoring system
    await this.sendMetrics(metrics);
    
    // Check for alert conditions
    await this.checkAlertConditions(metrics);
    
    return metrics;
  }
  
  private async checkAlertConditions(metrics: any) {
    if (metrics.failedLoginAttempts > 100) {
      await this.sendAlert('High number of failed login attempts', 'high');
    }
    
    if (metrics.vulnerabilityScore > 7) {
      await this.sendAlert('High vulnerability score detected', 'critical');
    }
    
    if (metrics.complianceScore < 90) {
      await this.sendAlert('Compliance score below threshold', 'medium');
    }
  }
}
```

## Best Practices Summary

### Development Security Guidelines

1. **Never commit secrets** to version control
2. **Validate all inputs** on both client and server side
3. **Use parameterized queries** to prevent SQL injection
4. **Implement proper error handling** without exposing sensitive information
5. **Apply the principle of least privilege** for all access controls
6. **Regular security audits** and dependency updates
7. **Implement comprehensive logging** for security events
8. **Use HTTPS everywhere** with proper certificate management

### Deployment Security Checklist

- [ ] All secrets stored in AWS Secrets Manager
- [ ] Rate limiting configured for all endpoints
- [ ] Input validation implemented
- [ ] Security headers configured
- [ ] Encryption at rest and in transit
- [ ] Access logs enabled
- [ ] Security monitoring active
- [ ] Compliance controls implemented

---

[← Back to Performance Optimization](performance.md) | [Multi-environment Setup →](environments.md)