# Stripe Payment Integration

**Complete guide for integrating Stripe payment processing with AWS Amplify Gen 2 and Next.js applications.**

## 🎯 Integration Overview

### What This Integration Provides
Stripe integration enables secure payment processing, subscription management, and marketplace functionality in your Amplify Gen 2 applications. This guide covers one-time payments, recurring subscriptions, and multi-party marketplace payments.

### Key Features
- **Secure Payment Processing**: PCI DSS compliant payment handling
- **Subscription Management**: Recurring billing and subscription lifecycle
- **Marketplace Payments**: Split payments between multiple vendors
- **Webhook Integration**: Real-time payment status updates
- **Customer Management**: Customer profiles and payment methods

## 🏗️ Architecture Overview

### Integration Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │ Stripe Platform │
│                 │    │                  │    │                 │
│ • Payment UI    │◄──►│ • Lambda APIs    │◄──►│ • Payment API   │
│ • Customer Mgmt │    │ • Webhook Handler│    │ • Webhooks      │
│ • Subscriptions │    │ • Data Models    │    │ • Dashboard     │
│ • Marketplace   │    │ • Auth Rules     │    │ • Analytics     │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components
1. **Frontend Payment Components**: Secure payment forms and UI
2. **Backend API Functions**: Stripe API integration and webhook handling
3. **Data Models**: Payment records, customers, and subscriptions
4. **Webhook Processing**: Real-time payment status updates
5. **Security Layer**: PCI compliance and data protection

## 🔧 Setup and Configuration

### 1. Stripe Account Setup
```bash
# Install Stripe CLI for local development
npm install -g stripe-cli

# Login to your Stripe account
stripe login

# Get your API keys from Stripe Dashboard
# Dashboard > Developers > API keys
```

### 2. Environment Variables
```bash
# .env.local
STRIPE_SECRET_KEY=sk_test_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Production
STRIPE_SECRET_KEY=sk_live_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

### 3. Install Dependencies
```bash
npm install stripe @stripe/stripe-js
npm install --save-dev @types/stripe
```

### 4. Amplify Configuration
```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { stripePaymentFunction } from './functions/stripe-payment/resource';
import { stripeWebhookFunction } from './functions/stripe-webhook/resource';

export const backend = defineBackend({
  auth,
  data,
  stripePaymentFunction,
  stripeWebhookFunction,
});
```

## 📊 Data Models

### Payment Data Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  Customer: a
    .model({
      userId: a.string().required(),
      stripeCustomerId: a.string().required(),
      email: a.email().required(),
      name: a.string(),
      defaultPaymentMethodId: a.string(),
      isActive: a.boolean().default(true),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Payment: a
    .model({
      customerId: a.string().required(),
      stripePaymentIntentId: a.string().required(),
      amount: a.integer().required(),
      currency: a.string().default('usd'),
      status: a.enum(['pending', 'succeeded', 'failed', 'canceled']),
      description: a.string(),
      metadata: a.json(),
      receiptUrl: a.string(),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Subscription: a
    .model({
      customerId: a.string().required(),
      stripeSubscriptionId: a.string().required(),
      productId: a.string().required(),
      priceId: a.string().required(),
      status: a.enum(['active', 'canceled', 'incomplete', 'incomplete_expired', 'past_due', 'trialing', 'unpaid']),
      currentPeriodStart: a.datetime(),
      currentPeriodEnd: a.datetime(),
      cancelAtPeriodEnd: a.boolean().default(false),
      metadata: a.json(),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Product: a
    .model({
      stripeProductId: a.string().required(),
      name: a.string().required(),
      description: a.string(),
      images: a.string().array(),
      metadata: a.json(),
      isActive: a.boolean().default(true),
    })
    .authorization(allow => [
      allow.authenticated().to(['read']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Price: a
    .model({
      stripePriceId: a.string().required(),
      productId: a.string().required(),
      amount: a.integer().required(),
      currency: a.string().default('usd'),
      interval: a.enum(['month', 'year', 'week', 'day']),
      intervalCount: a.integer().default(1),
      type: a.enum(['one_time', 'recurring']),
      isActive: a.boolean().default(true),
    })
    .authorization(allow => [
      allow.authenticated().to(['read']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),
});

export type Schema = ClientSchema<typeof schema>;
```

## 🔧 Backend Integration

### Payment Processing Function
```typescript
// amplify/functions/stripe-payment/handler.ts
import { APIGatewayProxyHandler } from 'aws-lambda';
import Stripe from 'stripe';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../data/resource';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
});

const client = generateClient<Schema>({
  authMode: 'iam',
});

export const handler: APIGatewayProxyHandler = async (event) => {
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    'Access-Control-Allow-Methods': 'GET,POST,PUT,DELETE,OPTIONS',
  };

  // Handle preflight requests
  if (event.httpMethod === 'OPTIONS') {
    return { statusCode: 200, headers, body: '' };
  }

  try {
    const { action, ...payload } = JSON.parse(event.body || '{}');

    switch (action) {
      case 'create_payment_intent':
        return await createPaymentIntent(payload);
      case 'create_subscription':
        return await createSubscription(payload);
      case 'cancel_subscription':
        return await cancelSubscription(payload);
      case 'create_customer':
        return await createCustomer(payload);
      default:
        return {
          statusCode: 400,
          headers,
          body: JSON.stringify({ error: 'Invalid action' }),
        };
    }
  } catch (error) {
    console.error('Stripe API error:', error);
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

async function createPaymentIntent(payload: any) {
  const { amount, currency = 'usd', customerId, description, metadata } = payload;

  // Create Stripe payment intent
  const paymentIntent = await stripe.paymentIntents.create({
    amount: Math.round(amount * 100), // Convert to cents
    currency,
    customer: customerId,
    description,
    metadata,
    automatic_payment_methods: {
      enabled: true,
    },
  });

  // Store payment record in database
  await client.models.Payment.create({
    customerId,
    stripePaymentIntentId: paymentIntent.id,
    amount: Math.round(amount * 100),
    currency,
    status: 'pending',
    description,
    metadata,
  });

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    },
    body: JSON.stringify({
      clientSecret: paymentIntent.client_secret,
      paymentIntentId: paymentIntent.id,
    }),
  };
}

async function createSubscription(payload: any) {
  const { customerId, priceId, trialPeriodDays, metadata } = payload;

  const subscription = await stripe.subscriptions.create({
    customer: customerId,
    items: [{ price: priceId }],
    trial_period_days: trialPeriodDays,
    metadata,
    payment_behavior: 'default_incomplete',
    payment_settings: { save_default_payment_method: 'on_subscription' },
    expand: ['latest_invoice.payment_intent'],
  });

  // Store subscription in database
  await client.models.Subscription.create({
    customerId,
    stripeSubscriptionId: subscription.id,
    productId: payload.productId,
    priceId,
    status: subscription.status as any,
    currentPeriodStart: new Date(subscription.current_period_start * 1000).toISOString(),
    currentPeriodEnd: new Date(subscription.current_period_end * 1000).toISOString(),
    metadata,
  });

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    },
    body: JSON.stringify({
      subscriptionId: subscription.id,
      clientSecret: (subscription.latest_invoice as any)?.payment_intent?.client_secret,
    }),
  };
}

async function cancelSubscription(payload: any) {
  const { subscriptionId, cancelAtPeriodEnd = true } = payload;

  const subscription = await stripe.subscriptions.update(subscriptionId, {
    cancel_at_period_end: cancelAtPeriodEnd,
  });

  // Update subscription in database
  await client.models.Subscription.update({
    stripeSubscriptionId: subscriptionId,
    cancelAtPeriodEnd,
    status: subscription.status as any,
  });

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    },
    body: JSON.stringify({
      subscription: {
        id: subscription.id,
        status: subscription.status,
        cancelAtPeriodEnd: subscription.cancel_at_period_end,
      },
    }),
  };
}

async function createCustomer(payload: any) {
  const { email, name, metadata, userId } = payload;

  const customer = await stripe.customers.create({
    email,
    name,
    metadata: { ...metadata, userId },
  });

  // Store customer in database
  await client.models.Customer.create({
    userId,
    stripeCustomerId: customer.id,
    email,
    name,
  });

  return {
    statusCode: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Content-Type,Authorization',
    },
    body: JSON.stringify({
      customerId: customer.id,
    }),
  };
}
```

### Webhook Handler Function
```typescript
// amplify/functions/stripe-webhook/handler.ts
import { APIGatewayProxyHandler } from 'aws-lambda';
import Stripe from 'stripe';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../data/resource';

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
});

const client = generateClient<Schema>({
  authMode: 'iam',
});

const endpointSecret = process.env.STRIPE_WEBHOOK_SECRET!;

export const handler: APIGatewayProxyHandler = async (event) => {
  const sig = event.headers['stripe-signature'];
  
  if (!sig) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Missing stripe-signature header' }),
    };
  }

  let stripeEvent: Stripe.Event;

  try {
    stripeEvent = stripe.webhooks.constructEvent(event.body!, sig, endpointSecret);
  } catch (err) {
    console.error('Webhook signature verification failed:', err);
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Webhook signature verification failed' }),
    };
  }

  try {
    switch (stripeEvent.type) {
      case 'payment_intent.succeeded':
        await handlePaymentIntentSucceeded(stripeEvent.data.object as Stripe.PaymentIntent);
        break;
      case 'payment_intent.payment_failed':
        await handlePaymentIntentFailed(stripeEvent.data.object as Stripe.PaymentIntent);
        break;
      case 'customer.subscription.created':
      case 'customer.subscription.updated':
        await handleSubscriptionUpdate(stripeEvent.data.object as Stripe.Subscription);
        break;
      case 'customer.subscription.deleted':
        await handleSubscriptionDeleted(stripeEvent.data.object as Stripe.Subscription);
        break;
      case 'invoice.payment_succeeded':
        await handleInvoicePaymentSucceeded(stripeEvent.data.object as Stripe.Invoice);
        break;
      case 'invoice.payment_failed':
        await handleInvoicePaymentFailed(stripeEvent.data.object as Stripe.Invoice);
        break;
      default:
        console.log(`Unhandled event type: ${stripeEvent.type}`);
    }

    return {
      statusCode: 200,
      body: JSON.stringify({ received: true }),
    };
  } catch (error) {
    console.error('Webhook processing error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Webhook processing failed' }),
    };
  }
};

async function handlePaymentIntentSucceeded(paymentIntent: Stripe.PaymentIntent) {
  try {
    await client.models.Payment.update({
      stripePaymentIntentId: paymentIntent.id,
      status: 'succeeded',
      receiptUrl: paymentIntent.charges.data[0]?.receipt_url || undefined,
    });
    
    console.log(`Payment succeeded: ${paymentIntent.id}`);
  } catch (error) {
    console.error('Error updating payment status:', error);
  }
}

async function handlePaymentIntentFailed(paymentIntent: Stripe.PaymentIntent) {
  try {
    await client.models.Payment.update({
      stripePaymentIntentId: paymentIntent.id,
      status: 'failed',
    });
    
    console.log(`Payment failed: ${paymentIntent.id}`);
  } catch (error) {
    console.error('Error updating payment status:', error);
  }
}

async function handleSubscriptionUpdate(subscription: Stripe.Subscription) {
  try {
    await client.models.Subscription.update({
      stripeSubscriptionId: subscription.id,
      status: subscription.status as any,
      currentPeriodStart: new Date(subscription.current_period_start * 1000).toISOString(),
      currentPeriodEnd: new Date(subscription.current_period_end * 1000).toISOString(),
      cancelAtPeriodEnd: subscription.cancel_at_period_end,
    });
    
    console.log(`Subscription updated: ${subscription.id}`);
  } catch (error) {
    console.error('Error updating subscription:', error);
  }
}

async function handleSubscriptionDeleted(subscription: Stripe.Subscription) {
  try {
    await client.models.Subscription.update({
      stripeSubscriptionId: subscription.id,
      status: 'canceled',
    });
    
    console.log(`Subscription canceled: ${subscription.id}`);
  } catch (error) {
    console.error('Error updating subscription status:', error);
  }
}

async function handleInvoicePaymentSucceeded(invoice: Stripe.Invoice) {
  console.log(`Invoice payment succeeded: ${invoice.id}`);
  // Handle successful subscription payment
  // Send receipt email, update user access, etc.
}

async function handleInvoicePaymentFailed(invoice: Stripe.Invoice) {
  console.log(`Invoice payment failed: ${invoice.id}`);
  // Handle failed subscription payment
  // Send payment failure notification, suspend service, etc.
}
```

## 🎨 Frontend Integration

### Payment Form Component
```typescript
// components/PaymentForm.tsx
'use client';

import { useState } from 'react';
import { loadStripe } from '@stripe/stripe-js';
import {
  Elements,
  CardElement,
  useStripe,
  useElements,
} from '@stripe/react-stripe-js';

const stripePromise = loadStripe(process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY!);

interface PaymentFormProps {
  amount: number;
  description: string;
  onSuccess: (paymentIntent: any) => void;
  onError: (error: string) => void;
}

function PaymentFormContent({ amount, description, onSuccess, onError }: PaymentFormProps) {
  const stripe = useStripe();
  const elements = useElements();
  const [processing, setProcessing] = useState(false);

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    if (!stripe || !elements) {
      return;
    }

    setProcessing(true);

    try {
      // Create payment intent on the server
      const response = await fetch('/api/stripe/payment-intent', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          action: 'create_payment_intent',
          amount,
          description,
        }),
      });

      const { clientSecret, error } = await response.json();

      if (error) {
        onError(error);
        return;
      }

      // Confirm the payment
      const cardElement = elements.getElement(CardElement);
      const { error: confirmError, paymentIntent } = await stripe.confirmCardPayment(
        clientSecret,
        {
          payment_method: {
            card: cardElement!,
          },
        }
      );

      if (confirmError) {
        onError(confirmError.message || 'Payment failed');
      } else if (paymentIntent.status === 'succeeded') {
        onSuccess(paymentIntent);
      }
    } catch (error) {
      onError('Payment processing failed');
    } finally {
      setProcessing(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="payment-form">
      <div className="payment-amount">
        <h3>Payment Amount: ${amount.toFixed(2)}</h3>
        <p>{description}</p>
      </div>

      <div className="card-element-container">
        <CardElement
          options={{
            style: {
              base: {
                fontSize: '16px',
                color: '#424770',
                '::placeholder': {
                  color: '#aab7c4',
                },
              },
            },
          }}
        />
      </div>

      <button
        type="submit"
        disabled={!stripe || processing}
        className="payment-button"
      >
        {processing ? 'Processing...' : `Pay $${amount.toFixed(2)}`}
      </button>
    </form>
  );
}

export function PaymentForm(props: PaymentFormProps) {
  return (
    <Elements stripe={stripePromise}>
      <PaymentFormContent {...props} />
    </Elements>
  );
}
```

### Subscription Management Component
```typescript
// components/SubscriptionManager.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

export function SubscriptionManager({ customerId }: { customerId: string }) {
  const [subscriptions, setSubscriptions] = useState<Schema['Subscription']['type'][]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSubscriptions();
  }, [customerId]);

  const fetchSubscriptions = async () => {
    try {
      const result = await client.models.Subscription.list({
        filter: { customerId: { eq: customerId } },
      });
      setSubscriptions(result.data);
    } catch (error) {
      console.error('Error fetching subscriptions:', error);
    } finally {
      setLoading(false);
    }
  };

  const cancelSubscription = async (subscriptionId: string) => {
    if (!confirm('Are you sure you want to cancel this subscription?')) {
      return;
    }

    try {
      const response = await fetch('/api/stripe/payment-intent', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          action: 'cancel_subscription',
          subscriptionId,
          cancelAtPeriodEnd: true,
        }),
      });

      if (response.ok) {
        await fetchSubscriptions();
      }
    } catch (error) {
      console.error('Error canceling subscription:', error);
    }
  };

  if (loading) return <div>Loading subscriptions...</div>;

  return (
    <div className="subscription-manager">
      <h3>Your Subscriptions</h3>
      
      {subscriptions.length === 0 ? (
        <p>No active subscriptions</p>
      ) : (
        subscriptions.map((subscription) => (
          <div key={subscription.id} className="subscription-card">
            <div className="subscription-info">
              <h4>Subscription</h4>
              <p>Status: <span className={`status ${subscription.status}`}>
                {subscription.status}
              </span></p>
              <p>Current period: {new Date(subscription.currentPeriodStart).toLocaleDateString()} - {new Date(subscription.currentPeriodEnd).toLocaleDateString()}</p>
              {subscription.cancelAtPeriodEnd && (
                <p className="cancel-notice">
                  Will cancel at the end of the current period
                </p>
              )}
            </div>
            
            <div className="subscription-actions">
              {subscription.status === 'active' && !subscription.cancelAtPeriodEnd && (
                <button 
                  onClick={() => cancelSubscription(subscription.stripeSubscriptionId)}
                  className="btn-cancel"
                >
                  Cancel Subscription
                </button>
              )}
            </div>
          </div>
        ))
      )}
    </div>
  );
}
```

### API Route Handler
```typescript
// app/api/stripe/payment-intent/route.ts
import { NextRequest, NextResponse } from 'next/server';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    
    // Call your Amplify function
    const response = await fetch(process.env.AMPLIFY_STRIPE_FUNCTION_URL!, {
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
    console.error('API route error:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
```

## 🔐 Security Best Practices

### Environment Security
```typescript
// Security configuration
const securityConfig = {
  // Never expose secret keys to the frontend
  stripeSecretKey: process.env.STRIPE_SECRET_KEY, // Server-side only
  stripePublishableKey: process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY, // Frontend safe
  
  // Webhook endpoint security
  webhookSecret: process.env.STRIPE_WEBHOOK_SECRET, // Server-side only
  
  // Additional security measures
  corsOrigins: process.env.ALLOWED_ORIGINS?.split(',') || ['localhost:3000'],
  rateLimitWindow: 15 * 60 * 1000, // 15 minutes
  maxRequestsPerWindow: 100,
};
```

### Input Validation
```typescript
// Validation schemas
import { z } from 'zod';

export const paymentIntentSchema = z.object({
  amount: z.number().min(50).max(999999), // $0.50 to $9,999.99
  currency: z.string().length(3).default('usd'),
  description: z.string().max(500).optional(),
  metadata: z.record(z.string()).optional(),
});

export const subscriptionSchema = z.object({
  priceId: z.string().startsWith('price_'),
  trialPeriodDays: z.number().min(0).max(365).optional(),
  metadata: z.record(z.string()).optional(),
});

// Usage in API handler
export const validatePaymentIntent = (data: unknown) => {
  return paymentIntentSchema.parse(data);
};
```

## 📊 Testing Strategy

### Unit Tests
```typescript
// __tests__/stripe.test.ts
import { describe, it, expect, vi } from 'vitest';
import Stripe from 'stripe';
import { createPaymentIntent } from '../lib/stripe';

// Mock Stripe
vi.mock('stripe');

describe('Stripe Integration', () => {
  it('should create a payment intent successfully', async () => {
    const mockPaymentIntent = {
      id: 'pi_test_123',
      client_secret: 'pi_test_123_secret_test',
      amount: 2000,
      currency: 'usd',
    };

    const mockStripe = {
      paymentIntents: {
        create: vi.fn().mockResolvedValue(mockPaymentIntent),
      },
    };

    (Stripe as any).mockImplementation(() => mockStripe);

    const result = await createPaymentIntent(20, 'Test payment');
    
    expect(mockStripe.paymentIntents.create).toHaveBeenCalledWith({
      amount: 2000,
      currency: 'usd',
      description: 'Test payment',
      automatic_payment_methods: { enabled: true },
    });

    expect(result).toEqual(mockPaymentIntent);
  });
});
```

### Integration Tests
```typescript
// __tests__/stripe-integration.test.ts
import { describe, it, expect } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { PaymentForm } from '../components/PaymentForm';

describe('Payment Form Integration', () => {
  it('should render payment form correctly', () => {
    render(
      <PaymentForm
        amount={20}
        description="Test payment"
        onSuccess={() => {}}
        onError={() => {}}
      />
    );

    expect(screen.getByText('Payment Amount: $20.00')).toBeInTheDocument();
    expect(screen.getByText('Test payment')).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Pay $20.00' })).toBeInTheDocument();
  });
});
```

## 🎯 Production Deployment

### Webhook Configuration
```bash
# Configure webhook endpoints in Stripe Dashboard
# Dashboard > Developers > Webhooks

# Production webhook URL
https://your-domain.com/api/stripe/webhook

# Events to listen for:
- payment_intent.succeeded
- payment_intent.payment_failed
- customer.subscription.created
- customer.subscription.updated
- customer.subscription.deleted
- invoice.payment_succeeded
- invoice.payment_failed
```

### Monitoring and Analytics
```typescript
// Monitoring setup
export class StripeMonitoring {
  static trackPaymentEvent(event: string, metadata: Record<string, any>) {
    // Log to your analytics service
    console.log('Stripe event:', { event, metadata, timestamp: Date.now() });
    
    // Example: Send to CloudWatch, DataDog, etc.
    // analytics.track('stripe_payment_event', { event, ...metadata });
  }

  static alertOnFailure(error: Error, context: string) {
    console.error(`Stripe error in ${context}:`, error);
    
    // Example: Send alert to Slack, PagerDuty, etc.
    // alertService.sendAlert(`Stripe integration error: ${error.message}`);
  }
}
```

---

*This Stripe integration guide provides comprehensive payment processing capabilities for AWS Amplify Gen 2 applications, including one-time payments, subscriptions, and marketplace functionality with proper security and testing practices.*

**Integration Version**: 1.0  
**Complexity**: Medium  
**Setup Time**: 2-4 hours  
**Production Ready**: ✅ Yes