# SendGrid Email Integration

**Complete guide for integrating SendGrid email services with AWS Amplify Gen 2 and Next.js applications.**

## 🎯 Integration Overview

### What This Integration Provides
SendGrid integration enables reliable email delivery, templated emails, and transactional email management in your Amplify Gen 2 applications. This guide covers basic email sending, template management, and webhook integration for delivery tracking.

### Key Features
- **Reliable Email Delivery**: High-deliverability email sending
- **Template Management**: Dynamic email templates with personalization
- **Transactional Emails**: Welcome emails, password resets, notifications
- **Delivery Tracking**: Webhook integration for email status updates
- **List Management**: Contact lists and subscription management

## 🏗️ Architecture Overview

### Integration Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │ SendGrid API    │
│                 │    │                  │    │                 │
│ • Email Triggers│◄──►│ • Lambda Functions│◄──►│ • Mail API      │
│ • Templates     │    │ • Webhook Handler│    │ • Templates     │
│ • Contact Mgmt  │    │ • Data Models    │    │ • Analytics     │
│ • Preferences   │    │ • Auth Rules     │    │ • Webhooks      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components
1. **Email Service Functions**: SendGrid API integration for sending emails
2. **Template Management**: Dynamic email templates with personalization
3. **Webhook Processing**: Real-time email delivery status updates
4. **Contact Management**: Subscriber lists and preferences
5. **Analytics Tracking**: Email delivery and engagement metrics

## 🔧 Setup and Configuration

### 1. SendGrid Account Setup
```bash
# Create SendGrid account at https://sendgrid.com
# Get API key from Settings > API Keys
# Verify sender identity (domain or single sender)
```

### 2. Environment Variables
```bash
# .env.local
SENDGRID_API_KEY=SG.your_api_key_here
SENDGRID_FROM_EMAIL=noreply@yourdomain.com
SENDGRID_FROM_NAME="Your App Name"

# Optional: Template IDs
SENDGRID_WELCOME_TEMPLATE_ID=d-abc123
SENDGRID_PASSWORD_RESET_TEMPLATE_ID=d-def456
SENDGRID_NOTIFICATION_TEMPLATE_ID=d-ghi789
```

### 3. Install Dependencies
```bash
npm install @sendgrid/mail
npm install --save-dev @types/sendgrid__mail
```

### 4. Amplify Configuration
```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { sendEmailFunction } from './functions/send-email/resource';
import { emailWebhookFunction } from './functions/email-webhook/resource';

export const backend = defineBackend({
  auth,
  data,
  sendEmailFunction,
  emailWebhookFunction,
});
```

## 📊 Data Models

### Email Data Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  EmailLog: a
    .model({
      messageId: a.string().required(),
      to: a.email().required(),
      from: a.email().required(),
      subject: a.string().required(),
      templateId: a.string(),
      personalizations: a.json(),
      status: a.enum(['queued', 'sent', 'delivered', 'bounced', 'blocked', 'spam', 'unsubscribed', 'failed']).default('queued'),
      sentAt: a.datetime(),
      deliveredAt: a.datetime(),
      openedAt: a.datetime(),
      clickedAt: a.datetime(),
      bouncedAt: a.datetime(),
      errorMessage: a.string(),
    })
    .authorization(allow => [
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']).where((email) => email.to.eq('current-user-email')),
    ]),

  EmailTemplate: a
    .model({
      sendgridTemplateId: a.string().required(),
      name: a.string().required(),
      description: a.string(),
      subject: a.string().required(),
      category: a.enum(['welcome', 'notification', 'marketing', 'transactional']),
      isActive: a.boolean().default(true),
      variables: a.json(), // Template variable definitions
    })
    .authorization(allow => [
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
    ]),

  EmailSubscription: a
    .model({
      email: a.email().required(),
      userId: a.string(),
      listId: a.string(),
      isSubscribed: a.boolean().default(true),
      preferences: a.json(),
      subscribedAt: a.datetime(),
      unsubscribedAt: a.datetime(),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  EmailCampaign: a
    .model({
      name: a.string().required(),
      templateId: a.string().required(),
      listIds: a.string().array(),
      scheduledAt: a.datetime(),
      sentAt: a.datetime(),
      status: a.enum(['draft', 'scheduled', 'sending', 'sent', 'cancelled']).default('draft'),
      recipientCount: a.integer().default(0),
      deliveryStats: a.json(),
    })
    .authorization(allow => [
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),
});

export type Schema = ClientSchema<typeof schema>;
```

## 🔧 Backend Integration

### Email Sending Function
```typescript
// amplify/functions/send-email/handler.ts
import { APIGatewayProxyHandler } from 'aws-lambda';
import sgMail from '@sendgrid/mail';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../data/resource';

sgMail.setApiKey(process.env.SENDGRID_API_KEY!);

const client = generateClient<Schema>({
  authMode: 'iam',
});

export const handler: APIGatewayProxyHandler = async (event) => {
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
  };

  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  try {
    const { action, ...payload } = JSON.parse(event.body || '{}');

    switch (action) {
      case 'send_email':
        return await sendEmail(payload);
      case 'send_template_email':
        return await sendTemplateEmail(payload);
      case 'send_bulk_email':
        return await sendBulkEmail(payload);
      default:
        return {
          statusCode: 400,
          headers,
          body: JSON.stringify({ error: 'Invalid action' }),
        };
    }
  } catch (error) {
    console.error('SendGrid API error:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({ 
        error: 'Internal server error',
        message: error instanceof Error ? error.message : 'Unknown error'
      }),
    };
  }
};

async function sendEmail(payload: any) {
  const { to, subject, html, text, templateId, templateData } = payload;

  const msg = {
    to,
    from: {
      email: process.env.SENDGRID_FROM_EMAIL!,
      name: process.env.SENDGRID_FROM_NAME!,
    },
    subject,
    html,
    text,
    ...(templateId && {
      templateId,
      dynamicTemplateData: templateData,
    }),
  };

  try {
    const response = await sgMail.send(msg);
    const messageId = response[0].headers['x-message-id'];

    // Log email send
    await client.models.EmailLog.create({
      messageId,
      to: Array.isArray(to) ? to[0] : to,
      from: process.env.SENDGRID_FROM_EMAIL!,
      subject,
      templateId,
      personalizations: templateData ? JSON.stringify(templateData) : undefined,
      status: 'sent',
      sentAt: new Date().toISOString(),
    });

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        success: true,
        messageId,
      }),
    };
  } catch (error) {
    console.error('Error sending email:', error);
    
    // Log failed email
    await client.models.EmailLog.create({
      messageId: `failed-${Date.now()}`,
      to: Array.isArray(to) ? to[0] : to,
      from: process.env.SENDGRID_FROM_EMAIL!,
      subject,
      templateId,
      status: 'failed',
      errorMessage: error instanceof Error ? error.message : 'Unknown error',
    });

    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Failed to send email',
        message: error instanceof Error ? error.message : 'Unknown error',
      }),
    };
  }
}

async function sendTemplateEmail(payload: any) {
  const { to, templateId, templateData, customArgs } = payload;

  const msg = {
    to,
    from: {
      email: process.env.SENDGRID_FROM_EMAIL!,
      name: process.env.SENDGRID_FROM_NAME!,
    },
    templateId,
    dynamicTemplateData: templateData,
    customArgs,
  };

  try {
    const response = await sgMail.send(msg);
    const messageId = response[0].headers['x-message-id'];

    await client.models.EmailLog.create({
      messageId,
      to: Array.isArray(to) ? to[0] : to,
      from: process.env.SENDGRID_FROM_EMAIL!,
      subject: 'Template Email', // Will be replaced by template
      templateId,
      personalizations: JSON.stringify(templateData),
      status: 'sent',
      sentAt: new Date().toISOString(),
    });

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        success: true,
        messageId,
      }),
    };
  } catch (error) {
    console.error('Error sending template email:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Failed to send template email',
        message: error instanceof Error ? error.message : 'Unknown error',
      }),
    };
  }
}

async function sendBulkEmail(payload: any) {
  const { recipients, templateId, globalTemplateData, customArgs } = payload;

  const personalizations = recipients.map((recipient: any) => ({
    to: [{ email: recipient.email, name: recipient.name }],
    dynamicTemplateData: { ...globalTemplateData, ...recipient.templateData },
  }));

  const msg = {
    from: {
      email: process.env.SENDGRID_FROM_EMAIL!,
      name: process.env.SENDGRID_FROM_NAME!,
    },
    templateId,
    personalizations,
    customArgs,
  };

  try {
    const response = await sgMail.send(msg);
    const messageId = response[0].headers['x-message-id'];

    // Log bulk email send
    for (const recipient of recipients) {
      await client.models.EmailLog.create({
        messageId: `${messageId}-${recipient.email}`,
        to: recipient.email,
        from: process.env.SENDGRID_FROM_EMAIL!,
        subject: 'Bulk Template Email',
        templateId,
        personalizations: JSON.stringify({ ...globalTemplateData, ...recipient.templateData }),
        status: 'sent',
        sentAt: new Date().toISOString(),
      });
    }

    return {
      statusCode: 200,
      headers,
      body: JSON.stringify({
        success: true,
        messageId,
        recipientCount: recipients.length,
      }),
    };
  } catch (error) {
    console.error('Error sending bulk email:', error);
    return {
      statusCode: 500,
      headers,
      body: JSON.stringify({
        error: 'Failed to send bulk email',
        message: error instanceof Error ? error.message : 'Unknown error',
      }),
    };
  }
}
```

### Webhook Handler Function
```typescript
// amplify/functions/email-webhook/handler.ts
import { APIGatewayProxyHandler } from 'aws-lambda';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../data/resource';

const client = generateClient<Schema>({
  authMode: 'iam',
});

export const handler: APIGatewayProxyHandler = async (event) => {
  try {
    const events = JSON.parse(event.body || '[]');

    for (const emailEvent of events) {
      await processEmailEvent(emailEvent);
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ processed: events.length }),
    };
  } catch (error) {
    console.error('Webhook processing error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Webhook processing failed' }),
    };
  }
};

async function processEmailEvent(emailEvent: any) {
  const { event, sg_message_id, email, timestamp } = emailEvent;

  try {
    const updateData: any = {
      messageId: sg_message_id,
    };

    switch (event) {
      case 'delivered':
        updateData.status = 'delivered';
        updateData.deliveredAt = new Date(timestamp * 1000).toISOString();
        break;
      case 'bounce':
        updateData.status = 'bounced';
        updateData.bouncedAt = new Date(timestamp * 1000).toISOString();
        updateData.errorMessage = emailEvent.reason;
        break;
      case 'blocked':
        updateData.status = 'blocked';
        updateData.errorMessage = emailEvent.reason;
        break;
      case 'spam':
        updateData.status = 'spam';
        break;
      case 'unsubscribe':
        updateData.status = 'unsubscribed';
        // Also update subscription status
        await client.models.EmailSubscription.update({
          email,
          isSubscribed: false,
          unsubscribedAt: new Date(timestamp * 1000).toISOString(),
        });
        break;
      case 'open':
        updateData.openedAt = new Date(timestamp * 1000).toISOString();
        break;
      case 'click':
        updateData.clickedAt = new Date(timestamp * 1000).toISOString();
        break;
      default:
        console.log(`Unhandled email event: ${event}`);
        return;
    }

    await client.models.EmailLog.update(updateData);
    console.log(`Processed email event: ${event} for ${sg_message_id}`);
  } catch (error) {
    console.error(`Error processing email event ${event}:`, error);
  }
}
```

## 🎨 Frontend Integration

### Email Service
```typescript
// lib/emailService.ts
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

export class EmailService {
  private async callEmailFunction(action: string, payload: any) {
    const response = await fetch('/api/email/send', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ action, ...payload }),
    });

    if (!response.ok) {
      throw new Error('Failed to send email');
    }

    return response.json();
  }

  async sendWelcomeEmail(userEmail: string, userName: string) {
    return this.callEmailFunction('send_template_email', {
      to: userEmail,
      templateId: process.env.NEXT_PUBLIC_SENDGRID_WELCOME_TEMPLATE_ID,
      templateData: {
        user_name: userName,
        app_name: 'Your App',
        login_url: `${window.location.origin}/login`,
      },
    });
  }

  async sendPasswordResetEmail(userEmail: string, resetToken: string) {
    return this.callEmailFunction('send_template_email', {
      to: userEmail,
      templateId: process.env.NEXT_PUBLIC_SENDGRID_PASSWORD_RESET_TEMPLATE_ID,
      templateData: {
        reset_url: `${window.location.origin}/reset-password?token=${resetToken}`,
        expiry_time: '1 hour',
      },
    });
  }

  async sendNotificationEmail(userEmail: string, notification: any) {
    return this.callEmailFunction('send_template_email', {
      to: userEmail,
      templateId: process.env.NEXT_PUBLIC_SENDGRID_NOTIFICATION_TEMPLATE_ID,
      templateData: {
        notification_title: notification.title,
        notification_message: notification.message,
        action_url: notification.actionUrl,
      },
    });
  }

  async sendCustomEmail(to: string, subject: string, htmlContent: string) {
    return this.callEmailFunction('send_email', {
      to,
      subject,
      html: htmlContent,
    });
  }

  async getEmailHistory(userEmail: string) {
    const result = await client.models.EmailLog.list({
      filter: { to: { eq: userEmail } },
      sort: { field: 'sentAt', direction: 'desc' },
    });
    return result.data;
  }
}

export const emailService = new EmailService();
```

### Email Preferences Component
```typescript
// components/EmailPreferences.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface EmailPreferences {
  marketing: boolean;
  notifications: boolean;
  security: boolean;
  newsletter: boolean;
}

export function EmailPreferences({ userEmail }: { userEmail: string }) {
  const [preferences, setPreferences] = useState<EmailPreferences>({
    marketing: true,
    notifications: true,
    security: true,
    newsletter: false,
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    fetchPreferences();
  }, [userEmail]);

  const fetchPreferences = async () => {
    try {
      const result = await client.models.EmailSubscription.list({
        filter: { email: { eq: userEmail } },
      });

      if (result.data.length > 0) {
        const subscription = result.data[0];
        setPreferences(subscription.preferences as EmailPreferences || preferences);
      }
    } catch (error) {
      console.error('Error fetching email preferences:', error);
    } finally {
      setLoading(false);
    }
  };

  const updatePreferences = async (newPreferences: EmailPreferences) => {
    setSaving(true);
    try {
      await client.models.EmailSubscription.create({
        email: userEmail,
        isSubscribed: Object.values(newPreferences).some(Boolean),
        preferences: newPreferences,
        subscribedAt: new Date().toISOString(),
      });

      setPreferences(newPreferences);
    } catch (error) {
      console.error('Error updating email preferences:', error);
    } finally {
      setSaving(false);
    }
  };

  const handlePreferenceChange = (key: keyof EmailPreferences) => {
    const newPreferences = {
      ...preferences,
      [key]: !preferences[key],
    };
    updatePreferences(newPreferences);
  };

  if (loading) return <div>Loading preferences...</div>;

  return (
    <div className="email-preferences">
      <h3>Email Preferences</h3>
      <p>Choose which emails you'd like to receive:</p>

      <div className="preference-list">
        <div className="preference-item">
          <label>
            <input
              type="checkbox"
              checked={preferences.security}
              onChange={() => handlePreferenceChange('security')}
              disabled={saving}
            />
            <span>Security notifications (recommended)</span>
          </label>
          <p className="preference-description">
            Important security alerts and account changes
          </p>
        </div>

        <div className="preference-item">
          <label>
            <input
              type="checkbox"
              checked={preferences.notifications}
              onChange={() => handlePreferenceChange('notifications')}
              disabled={saving}
            />
            <span>App notifications</span>
          </label>
          <p className="preference-description">
            Updates about your account activity and app features
          </p>
        </div>

        <div className="preference-item">
          <label>
            <input
              type="checkbox"
              checked={preferences.newsletter}
              onChange={() => handlePreferenceChange('newsletter')}
              disabled={saving}
            />
            <span>Newsletter</span>
          </label>
          <p className="preference-description">
            Weekly updates and tips about using our platform
          </p>
        </div>

        <div className="preference-item">
          <label>
            <input
              type="checkbox"
              checked={preferences.marketing}
              onChange={() => handlePreferenceChange('marketing')}
              disabled={saving}
            />
            <span>Marketing emails</span>
          </label>
          <p className="preference-description">
            Special offers, product updates, and promotional content
          </p>
        </div>
      </div>

      {saving && (
        <div className="saving-indicator">
          Saving preferences...
        </div>
      )}
    </div>
  );
}
```

### API Route Handler
```typescript
// app/api/email/send/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Call your Amplify email function
    const response = await fetch(process.env.AMPLIFY_EMAIL_FUNCTION_URL!, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(body),
    });

    const result = await response.json();
    
    if (!response.ok) {
      return NextResponse.json(result, { status: response.status });
    }

    return NextResponse.json(result);
  } catch (error) {
    console.error('Email API route error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

## 🔐 Security Best Practices

### API Key Security
```typescript
// Security configuration
const emailSecurityConfig = {
  // Never expose API keys to the frontend
  sendgridApiKey: process.env.SENDGRID_API_KEY, // Server-side only
  
  // Rate limiting configuration
  rateLimitWindow: 60 * 1000, // 1 minute
  maxEmailsPerMinute: 10,
  
  // Allowed domains for email sending
  allowedDomains: process.env.ALLOWED_EMAIL_DOMAINS?.split(',') || [],
  
  // Spam prevention
  maxRecipientsPerEmail: 50,
  maxEmailsPerDay: 1000,
};
```

### Input Validation
```typescript
// Email validation schemas
import { z } from 'zod';

export const emailSchema = z.object({
  to: z.union([z.string().email(), z.array(z.string().email())]),
  subject: z.string().min(1).max(200),
  html: z.string().optional(),
  text: z.string().optional(),
  templateId: z.string().optional(),
  templateData: z.record(z.any()).optional(),
});

export const bulkEmailSchema = z.object({
  recipients: z.array(z.object({
    email: z.string().email(),
    name: z.string().optional(),
    templateData: z.record(z.any()).optional(),
  })).max(100), // Limit bulk sends
  templateId: z.string(),
  globalTemplateData: z.record(z.any()).optional(),
});
```

## 📊 Analytics and Monitoring

### Email Analytics Dashboard
```typescript
// Email analytics service
export class EmailAnalytics {
  static async getDeliveryStats(dateRange: { start: Date; end: Date }) {
    const result = await client.models.EmailLog.list({
      filter: {
        sentAt: {
          between: [dateRange.start.toISOString(), dateRange.end.toISOString()],
        },
      },
    });

    const stats = result.data.reduce((acc, log) => {
      acc.total++;
      acc[log.status] = (acc[log.status] || 0) + 1;
      return acc;
    }, { total: 0 } as Record<string, number>);

    return {
      totalSent: stats.total,
      delivered: stats.delivered || 0,
      bounced: stats.bounced || 0,
      opened: result.data.filter(log => log.openedAt).length,
      clicked: result.data.filter(log => log.clickedAt).length,
      deliveryRate: stats.delivered ? (stats.delivered / stats.total) * 100 : 0,
      openRate: stats.delivered ? (result.data.filter(log => log.openedAt).length / stats.delivered) * 100 : 0,
    };
  }

  static trackEmailInteraction(type: 'send' | 'deliver' | 'open' | 'click', metadata: any) {
    console.log('Email interaction:', { type, metadata, timestamp: Date.now() });
    // Send to analytics service
  }
}
```

---

*This SendGrid integration guide provides comprehensive email delivery capabilities for AWS Amplify Gen 2 applications, including transactional emails, templates, and delivery tracking with proper security and monitoring practices.*

**Integration Version**: 1.0  
**Complexity**: Low-Medium  
**Setup Time**: 1-2 hours  
**Production Ready**: ✅ Yes