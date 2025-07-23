---
layout: docs
title: E-commerce Pattern
---

# E-commerce Pattern

The E-commerce pattern provides a complete foundation for building online stores, marketplaces, and subscription-based services with integrated payment processing.

## When to Use

- Online retail stores
- Multi-vendor marketplaces
- Subscription services
- Digital product stores
- B2B commerce platforms

## Core Features

### Product Management
- **Product Catalog**: Rich product information with variants
- **Inventory Tracking**: Real-time stock management
- **Categories & Tags**: Flexible product organization
- **Pricing Rules**: Dynamic pricing, discounts, promotions

### Shopping Experience
- **Shopping Cart**: Persistent cart across sessions
- **Checkout Flow**: Streamlined purchase process
- **Order Management**: Complete order lifecycle
- **User Accounts**: Purchase history, wishlists, addresses

### Payment Processing
- **Stripe Integration**: Secure payment processing
- **Multiple Payment Methods**: Cards, digital wallets, BNPL
- **Subscription Billing**: Recurring payments
- **Tax Calculation**: Automated tax handling

### Vendor Management
- **Multi-vendor Support**: Vendor onboarding and management
- **Commission Tracking**: Automated vendor payouts
- **Vendor Analytics**: Sales and performance metrics
- **Product Approval**: Vendor product moderation

## Data Schema

```typescript
export const schema = a.schema({
  Product: a.model({
    name: a.string().required(),
    description: a.string(),
    price: a.float().required(),
    compareAtPrice: a.float(), // For showing discounts
    sku: a.string().required(),
    inventory: a.integer().default(0),
    vendor: a.belongsTo('Vendor', 'vendorId'),
    category: a.belongsTo('Category', 'categoryId'),
    images: a.string().array(),
    variants: a.hasMany('ProductVariant', 'productId'),
    isActive: a.boolean().default(true)
  }),

  ProductVariant: a.model({
    product: a.belongsTo('Product', 'productId'),
    name: a.string().required(), // e.g., "Red Large"
    sku: a.string().required(),
    price: a.float(),
    inventory: a.integer().default(0),
    attributes: a.json() // { color: "red", size: "large" }
  }),

  Category: a.model({
    name: a.string().required(),
    slug: a.string().required(),
    description: a.string(),
    parent: a.belongsTo('Category', 'parentId'),
    children: a.hasMany('Category', 'parentId'),
    products: a.hasMany('Product', 'categoryId')
  }),

  Cart: a.model({
    user: a.belongsTo('User', 'userId'),
    items: a.hasMany('CartItem', 'cartId'),
    total: a.float().default(0),
    currency: a.string().default('USD')
  }),

  CartItem: a.model({
    cart: a.belongsTo('Cart', 'cartId'),
    product: a.belongsTo('Product', 'productId'),
    variant: a.belongsTo('ProductVariant', 'variantId'),
    quantity: a.integer().required(),
    unitPrice: a.float().required(),
    totalPrice: a.float().required()
  }),

  Order: a.model({
    orderNumber: a.string().required(),
    customer: a.belongsTo('User', 'customerId'),
    items: a.hasMany('OrderItem', 'orderId'),
    status: a.enum(['pending', 'processing', 'shipped', 'delivered', 'cancelled']),
    subtotal: a.float().required(),
    tax: a.float().default(0),
    shipping: a.float().default(0),
    total: a.float().required(),
    shippingAddress: a.json(),
    billingAddress: a.json(),
    paymentIntentId: a.string() // Stripe payment intent
  }),

  OrderItem: a.model({
    order: a.belongsTo('Order', 'orderId'),
    product: a.belongsTo('Product', 'productId'),
    variant: a.belongsTo('ProductVariant', 'variantId'),
    quantity: a.integer().required(),
    unitPrice: a.float().required(),
    totalPrice: a.float().required()
  }),

  Vendor: a.model({
    name: a.string().required(),
    email: a.email().required(),
    description: a.string(),
    logo: a.string(), // S3 key
    commissionRate: a.float().default(0.15), // 15% default
    products: a.hasMany('Product', 'vendorId'),
    isActive: a.boolean().default(true)
  })
});
```

## Payment Integration

```typescript
// Stripe payment processing
import { createPaymentIntent, confirmPayment } from './payments';

// Create payment intent when order is placed
const handleCheckout = async (orderData) => {
  try {
    // Create order in database
    const order = await client.models.Order.create(orderData);
    
    // Create Stripe payment intent
    const paymentIntent = await createPaymentIntent({
      amount: order.total * 100, // Convert to cents
      currency: 'usd',
      metadata: { orderId: order.id }
    });
    
    // Update order with payment intent ID
    await client.models.Order.update({
      id: order.id,
      paymentIntentId: paymentIntent.id
    });
    
    return { clientSecret: paymentIntent.client_secret };
  } catch (error) {
    console.error('Checkout error:', error);
  }
};
```

## Inventory Management

```typescript
// Real-time inventory updates
const updateInventory = async (productId, variantId, quantity) => {
  // Check current inventory
  const variant = await client.models.ProductVariant.get({ id: variantId });
  
  if (variant.inventory < quantity) {
    throw new Error('Insufficient inventory');
  }
  
  // Update inventory atomically
  await client.models.ProductVariant.update({
    id: variantId,
    inventory: variant.inventory - quantity
  });
  
  // Trigger low inventory alerts if needed
  if (variant.inventory - quantity < 10) {
    await sendLowInventoryAlert(productId, variantId);
  }
};
```

## Frontend Components

### Product Components
- `<ProductGrid />` - Product listing with filtering
- `<ProductCard />` - Individual product display
- `<ProductDetails />` - Detailed product page
- `<ProductImages />` - Image gallery with zoom
- `<VariantSelector />` - Size/color/option selection

### Shopping Components
- `<AddToCartButton />` - Add to cart functionality
- `<CartSidebar />` - Shopping cart overlay
- `<CheckoutForm />` - Multi-step checkout process
- `<PaymentForm />` - Stripe payment integration
- `<OrderSummary />` - Order confirmation

### Vendor Components
- `<VendorDashboard />` - Vendor management interface
- `<ProductManager />` - Product creation and editing
- `<OrderFulfillment />` - Order processing for vendors
- `<AnalyticsDashboard />` - Sales metrics and reporting

## Example Implementation

```bash
# Create online marketplace
/ace-genesis "marketplace where local artisans can sell handmade products"

# ACE-Flow will:
# 1. Interview about marketplace features (multi-vendor, categories, etc.)
# 2. Research e-commerce best practices and AWS Amplify patterns
# 3. Generate schema with vendor management and commission tracking
# 4. Set up Stripe integration with marketplace payments
# 5. Create admin dashboard for marketplace management
# 6. Configure S3 for product images with CDN
# 7. Deploy complete marketplace to AWS
```

## Advanced Features

### Search & Filtering
```typescript
// Elasticsearch integration for product search
const searchProducts = async (query, filters) => {
  const searchParams = {
    index: 'products',
    body: {
      query: {
        bool: {
          must: [
            { match: { name: query } },
            { match: { description: query } }
          ],
          filter: filters
        }
      },
      sort: [{ createdAt: 'desc' }],
      size: 20
    }
  };
  
  return await elasticsearch.search(searchParams);
};
```

### Recommendation Engine
```typescript
// Product recommendations based on purchase history
const getRecommendations = async (userId) => {
  // Get user's purchase history
  const orders = await client.models.Order.list({
    filter: { customerId: { eq: userId } }
  });
  
  // Use ML to find similar products
  const recommendations = await mlRecommendationService({
    userId,
    purchaseHistory: orders.data
  });
  
  return recommendations;
};
```

## Performance Optimizations

### Caching Strategy
- **Product data**: Cache at CDN edge for fast loading
- **Category navigation**: Redis caching for menu structure
- **Search results**: Cache popular search queries
- **Shopping cart**: Session-based caching

### Database Optimization
```typescript
// Optimized indexes for e-commerce queries
Product: a.model({
  // ... fields
}).secondaryIndexes(index => [
  index('categoryId').sortKeys(['price']).name('byCategoryAndPrice'),
  index('vendorId').sortKeys(['createdAt']).name('byVendor'),
  index('isActive').sortKeys(['name']).name('byActiveStatus')
]);
```

## Cost Estimates

For an e-commerce store with 1,000 orders/month:

- **DynamoDB**: ~$20-40/month
- **S3 Storage**: ~$15-30/month (product images)
- **Lambda Functions**: ~$10-25/month
- **Stripe Processing**: ~2.9% + $0.30 per transaction
- **CDN & Transfer**: ~$10-20/month
- **Search (OpenSearch)**: ~$15-25/month

**Total estimated cost**: $70-140/month + payment processing fees

## Security Features

- **PCI Compliance**: Stripe handles sensitive payment data
- **Fraud Detection**: Built-in fraud prevention
- **Secure Checkout**: SSL encryption for all transactions
- **Data Protection**: Customer data encryption at rest
- **Access Control**: Role-based permissions for vendors/admins

## Multi-vendor Features

### Vendor Onboarding
```typescript
const onboardVendor = async (vendorData) => {
  // Create vendor account
  const vendor = await client.models.Vendor.create(vendorData);
  
  // Set up Stripe Connect account for payouts
  const stripeAccount = await stripe.accounts.create({
    type: 'express',
    country: vendorData.country,
    email: vendorData.email
  });
  
  // Update vendor with Stripe account ID
  await client.models.Vendor.update({
    id: vendor.id,
    stripeAccountId: stripeAccount.id
  });
  
  return vendor;
};
```

### Commission Tracking
```typescript
const calculateCommissions = async (orderId) => {
  const order = await client.models.Order.get({ id: orderId });
  const orderItems = await client.models.OrderItem.list({
    filter: { orderId: { eq: orderId } }
  });
  
  // Calculate commission for each vendor
  for (const item of orderItems.data) {
    const product = await client.models.Product.get({ id: item.productId });
    const vendor = await client.models.Vendor.get({ id: product.vendorId });
    
    const commission = item.totalPrice * vendor.commissionRate;
    const vendorEarnings = item.totalPrice - commission;
    
    // Record commission and schedule payout
    await client.models.Commission.create({
      vendorId: vendor.id,
      orderId: order.id,
      amount: commission,
      vendorEarnings: vendorEarnings,
      status: 'pending'
    });
  }
};
```

## Getting Started

1. Run `/ace-genesis` with your e-commerce idea
2. Specify whether it's single or multi-vendor
3. Choose payment methods and shipping options
4. Review generated architecture and customize
5. Deploy and start selling!

---

[← Social Platform](social-platform.md) | [Content Management →](content-management.md)