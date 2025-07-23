# 🛒 E-Commerce Pattern

**Multi-vendor marketplace with payments, inventory, and order management**

## Pattern Overview

This e-commerce pattern implements a comprehensive marketplace solution with:
- Multi-vendor support
- Product catalog management  
- Inventory tracking
- Payment processing integration
- Order management system
- User authentication and profiles

## Architecture

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/gen2/data';

const schema = a.schema({
  // Core entities
  Vendor: a
    .model({
      name: a.string().required(),
      email: a.email().required(),
      description: a.string(),
      isActive: a.boolean().default(true),
      products: a.hasMany('Product', 'vendorId'),
      orders: a.hasMany('Order', 'vendorId'),
    })
    .authorization(allow => [allow.authenticated()]),

  Product: a
    .model({
      name: a.string().required(),
      description: a.string(),
      price: a.float().required(),
      inventoryCount: a.integer().default(0),
      category: a.string(),
      imageUrls: a.string().array(),
      vendorId: a.id().required(),
      vendor: a.belongsTo('Vendor', 'vendorId'),
      orderItems: a.hasMany('OrderItem', 'productId'),
    })
    .authorization(allow => [allow.authenticated()]),

  Customer: a
    .model({
      email: a.email().required(),
      name: a.string().required(),
      address: a.json(),
      orders: a.hasMany('Order', 'customerId'),
    })
    .authorization(allow => [allow.owner()]),

  Order: a
    .model({
      status: a.enum(['pending', 'processing', 'shipped', 'delivered', 'cancelled']),
      totalAmount: a.float().required(),
      customerId: a.id().required(),
      vendorId: a.id().required(),
      customer: a.belongsTo('Customer', 'customerId'),
      vendor: a.belongsTo('Vendor', 'vendorId'),
      items: a.hasMany('OrderItem', 'orderId'),
    })
    .authorization(allow => [allow.owner()]),

  OrderItem: a
    .model({
      quantity: a.integer().required(),
      unitPrice: a.float().required(),
      orderId: a.id().required(),
      productId: a.id().required(),
      order: a.belongsTo('Order', 'orderId'),
      product: a.belongsTo('Product', 'productId'),
    })
    .authorization(allow => [allow.authenticated()]),
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
```

## Key Implementation Components

### Product Catalog
- Multi-vendor product management
- Category-based organization
- Image gallery support
- Inventory tracking
- Search and filtering capabilities

### Payment Integration
- Stripe payment processing
- Multi-vendor payment splits
- Refund management
- Payment history tracking

### Order Management
- Complete order lifecycle
- Status tracking and updates
- Multi-vendor order coordination
- Customer communication

## Best Practices

1. **Security**: Implement proper authorization for vendor/customer data
2. **Performance**: Use efficient queries for product catalogs
3. **Scalability**: Design for high transaction volumes
4. **User Experience**: Provide real-time inventory updates
5. **Data Integrity**: Maintain consistent order and payment states

## Steering Integration

This pattern integrates with ACE-Flow steering files:
- **architecture-decisions.md**: E-commerce design decisions
- **domain-expertise.md**: Marketplace business logic
- **quality-standards.md**: Transaction security standards

For detailed implementation, see the existing [social_platform.md](./social_platform.md) pattern as a reference.