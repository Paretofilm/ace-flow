# E-Commerce Architecture Pattern

**Comprehensive architecture pattern for building e-commerce platforms, marketplaces, and online stores with AWS Amplify Gen 2 and Next.js.**

## 🎯 Pattern Overview

### What This Pattern Provides
The E-Commerce pattern enables building scalable online stores and marketplaces with features like product catalogs, shopping carts, payment processing, order management, and multi-vendor support. It's designed for applications that handle commercial transactions and require robust inventory management.

### Core Characteristics
- **Product-Centric Design**: Everything revolves around products, catalogs, and inventory
- **Transaction Management**: Secure payment processing and order fulfillment
- **Multi-Vendor Support**: Marketplace functionality with vendor management
- **Inventory Tracking**: Real-time inventory management and stock control
- **Customer Experience**: Shopping carts, wishlists, reviews, and recommendations

## 🏗️ Architecture Components

### High-Level Architecture
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Next.js App   │    │  Amplify Gen 2   │    │  AWS Services   │
│                 │    │                  │    │                 │
│ • Product Catalog│◄──►│ • GraphQL API    │◄──►│ • Cognito       │
│ • Shopping Cart │    │ • Payment API    │    │ • S3 + CloudFront│
│ • Checkout      │    │ • Auth Rules     │    │ • DynamoDB      │
│ • Order Mgmt    │    │ • Data Models    │    │ • Lambda        │
│ • Vendor Portal │    │ • File Storage   │    │ • SQS/SNS       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
```

### Key Components

#### 1. Product Management System
```typescript
// Core product interfaces
interface Product {
  id: string;
  vendorId: string;
  name: string;
  description: string;
  shortDescription?: string;
  sku: string;
  price: number;
  compareAtPrice?: number;
  costPrice?: number;
  weight?: number;
  dimensions?: ProductDimensions;
  inventory: ProductInventory;
  images: ProductImage[];
  variants: ProductVariant[];
  categories: string[];
  tags: string[];
  seo: ProductSEO;
  status: 'draft' | 'active' | 'archived';
  visibility: 'public' | 'private' | 'hidden';
  createdAt: Date;
  updatedAt: Date;
}

interface ProductVariant {
  id: string;
  productId: string;
  name: string;
  sku: string;
  price?: number;
  compareAtPrice?: number;
  inventory: ProductInventory;
  options: Record<string, string>; // { color: 'red', size: 'large' }
  image?: string;
  position: number;
}

interface ProductInventory {
  trackQuantity: boolean;
  quantity: number;
  lowStockThreshold: number;
  allowBackorder: boolean;
  location?: string;
}
```

#### 2. Order & Transaction System
```typescript
// Order management interfaces
interface Order {
  id: string;
  customerId: string;
  vendorId?: string;
  orderNumber: string;
  status: 'pending' | 'confirmed' | 'processing' | 'shipped' | 'delivered' | 'cancelled' | 'refunded';
  items: OrderItem[];
  subtotal: number;
  taxAmount: number;
  shippingAmount: number;
  discountAmount: number;
  totalAmount: number;
  currency: string;
  paymentStatus: 'pending' | 'paid' | 'failed' | 'refunded';
  shippingAddress: Address;
  billingAddress: Address;
  shippingMethod: ShippingMethod;
  paymentMethod: PaymentMethod;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

interface OrderItem {
  id: string;
  productId: string;
  variantId?: string;
  quantity: number;
  price: number;
  title: string;
  variant?: string;
  image?: string;
  vendor?: VendorInfo;
}

interface ShoppingCart {
  id: string;
  customerId: string;
  items: CartItem[];
  subtotal: number;
  estimatedTax: number;
  estimatedShipping: number;
  estimatedTotal: number;
  couponCode?: string;
  discountAmount: number;
  createdAt: Date;
  updatedAt: Date;
}
```

#### 3. Vendor Management System
```typescript
// Multi-vendor marketplace interfaces
interface Vendor {
  id: string;
  businessName: string;
  contactName: string;
  email: string;
  phone?: string;
  address: Address;
  taxId?: string;
  commissionRate: number;
  status: 'pending' | 'approved' | 'suspended' | 'rejected';
  settings: VendorSettings;
  payoutInfo: PayoutInfo;
  createdAt: Date;
  updatedAt: Date;
}

interface VendorSettings {
  autoApproveProducts: boolean;
  allowCustomShipping: boolean;
  returnPolicy?: string;
  processingTime: number; // days
  businessHours?: BusinessHours;
}
```

## 📊 Data Modeling Strategy

### Core E-Commerce Models

#### Product Catalog Schema
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a } from '@aws-amplify/backend';

const schema = a.schema({
  Product: a
    .model({
      vendorId: a.id().required(),
      name: a.string().required(),
      description: a.string(),
      shortDescription: a.string(),
      sku: a.string().required(),
      price: a.float().required(),
      compareAtPrice: a.float(),
      costPrice: a.float(),
      weight: a.float(),
      status: a.enum(['draft', 'active', 'archived']).default('draft'),
      visibility: a.enum(['public', 'private', 'hidden']).default('public'),
      trackQuantity: a.boolean().default(true),
      quantity: a.integer().default(0),
      lowStockThreshold: a.integer().default(10),
      allowBackorder: a.boolean().default(false),
      images: a.string().array(),
      categories: a.string().array(),
      tags: a.string().array(),
      
      // SEO fields
      metaTitle: a.string(),
      metaDescription: a.string(),
      slug: a.string(),
      
      // Relations
      vendor: a.belongsTo('Vendor', 'vendorId'),
      variants: a.hasMany('ProductVariant', 'productId'),
      reviews: a.hasMany('ProductReview', 'productId'),
      orderItems: a.hasMany('OrderItem', 'productId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ])
    .secondaryIndexes(index => [
      index('vendorId').sortKeys(['createdAt']).name('byVendor'),
      index('status').sortKeys(['createdAt']).name('byStatus'),
      index('visibility').sortKeys(['price']).name('byVisibilityAndPrice'),
    ]),

  ProductVariant: a
    .model({
      productId: a.id().required(),
      name: a.string().required(),
      sku: a.string().required(),
      price: a.float(),
      compareAtPrice: a.float(),
      quantity: a.integer().default(0),
      options: a.json(), // { color: 'red', size: 'large' }
      image: a.string(),
      position: a.integer().default(0),
      
      // Relations
      product: a.belongsTo('Product', 'productId'),
      cartItems: a.hasMany('CartItem', 'variantId'),
      orderItems: a.hasMany('OrderItem', 'variantId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.authenticated().to(['read']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Category: a
    .model({
      name: a.string().required(),
      slug: a.string().required(),
      description: a.string(),
      image: a.string(),
      parentId: a.id(),
      position: a.integer().default(0),
      isActive: a.boolean().default(true),
      
      // SEO
      metaTitle: a.string(),
      metaDescription: a.string(),
      
      // Relations
      parent: a.belongsTo('Category', 'parentId'),
      children: a.hasMany('Category', 'parentId'),
    })
    .authorization(allow => [
      allow.authenticated().to(['read']),
      allow.groups(['admin', 'vendor']).to(['create', 'update', 'delete']),
    ]),
});
```

#### Order Management Schema
```typescript
// Order and transaction models
const orderSchema = a.schema({
  Order: a
    .model({
      customerId: a.id().required(),
      vendorId: a.id(),
      orderNumber: a.string().required(),
      status: a.enum(['pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded']).default('pending'),
      
      // Pricing
      subtotal: a.float().required(),
      taxAmount: a.float().default(0),
      shippingAmount: a.float().default(0),
      discountAmount: a.float().default(0),
      totalAmount: a.float().required(),
      currency: a.string().default('USD'),
      
      // Payment
      paymentStatus: a.enum(['pending', 'paid', 'failed', 'refunded']).default('pending'),
      paymentIntentId: a.string(),
      
      // Addresses
      shippingAddress: a.json().required(),
      billingAddress: a.json().required(),
      
      // Shipping
      shippingMethodId: a.id(),
      trackingNumber: a.string(),
      estimatedDelivery: a.date(),
      
      // Additional info
      notes: a.string(),
      couponCode: a.string(),
      
      // Relations
      customer: a.belongsTo('Customer', 'customerId'),
      vendor: a.belongsTo('Vendor', 'vendorId'),
      items: a.hasMany('OrderItem', 'orderId'),
      shippingMethod: a.belongsTo('ShippingMethod', 'shippingMethodId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin', 'vendor']).to(['read', 'update']),
    ])
    .secondaryIndexes(index => [
      index('customerId').sortKeys(['createdAt']).name('byCustomer'),
      index('vendorId').sortKeys(['createdAt']).name('byVendor'),
      index('status').sortKeys(['createdAt']).name('byStatus'),
      index('orderNumber').name('byOrderNumber'),
    ]),

  OrderItem: a
    .model({
      orderId: a.id().required(),
      productId: a.id().required(),
      variantId: a.id(),
      quantity: a.integer().required(),
      price: a.float().required(),
      title: a.string().required(),
      variant: a.string(),
      image: a.string(),
      
      // Relations
      order: a.belongsTo('Order', 'orderId'),
      product: a.belongsTo('Product', 'productId'),
      productVariant: a.belongsTo('ProductVariant', 'variantId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read']),
      allow.groups(['admin', 'vendor']).to(['read']),
    ]),

  ShoppingCart: a
    .model({
      customerId: a.id().required(),
      subtotal: a.float().default(0),
      estimatedTax: a.float().default(0),
      estimatedShipping: a.float().default(0),
      estimatedTotal: a.float().default(0),
      couponCode: a.string(),
      discountAmount: a.float().default(0),
      
      // Relations
      customer: a.belongsTo('Customer', 'customerId'),
      items: a.hasMany('CartItem', 'cartId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
    ]),

  CartItem: a
    .model({
      cartId: a.id().required(),
      productId: a.id().required(),
      variantId: a.id(),
      quantity: a.integer().required(),
      price: a.float().required(),
      
      // Relations
      cart: a.belongsTo('ShoppingCart', 'cartId'),
      product: a.belongsTo('Product', 'productId'),
      variant: a.belongsTo('ProductVariant', 'variantId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
    ]),
});
```

#### Vendor & Customer Schema
```typescript
// User management models
const userSchema = a.schema({
  Vendor: a
    .model({
      businessName: a.string().required(),
      contactName: a.string().required(),
      email: a.email().required(),
      phone: a.phone(),
      address: a.json().required(),
      taxId: a.string(),
      commissionRate: a.float().default(0.15),
      status: a.enum(['pending', 'approved', 'suspended', 'rejected']).default('pending'),
      
      // Settings
      autoApproveProducts: a.boolean().default(false),
      allowCustomShipping: a.boolean().default(true),
      returnPolicy: a.string(),
      processingTime: a.integer().default(3), // days
      
      // Payout info
      payoutMethod: a.enum(['bank', 'paypal', 'stripe']),
      payoutDetails: a.json(),
      
      // Relations
      products: a.hasMany('Product', 'vendorId'),
      orders: a.hasMany('Order', 'vendorId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update']),
      allow.groups(['admin']).to(['create', 'read', 'update', 'delete']),
    ]),

  Customer: a
    .model({
      email: a.email().required(),
      firstName: a.string().required(),
      lastName: a.string().required(),
      phone: a.phone(),
      dateOfBirth: a.date(),
      
      // Preferences
      marketingOptIn: a.boolean().default(false),
      currency: a.string().default('USD'),
      language: a.string().default('en'),
      
      // Stats
      totalOrders: a.integer().default(0),
      totalSpent: a.float().default(0),
      averageOrderValue: a.float().default(0),
      
      // Relations
      addresses: a.hasMany('CustomerAddress', 'customerId'),
      orders: a.hasMany('Order', 'customerId'),
      cart: a.hasOne('ShoppingCart', 'customerId'),
      wishlist: a.hasMany('WishlistItem', 'customerId'),
      reviews: a.hasMany('ProductReview', 'customerId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
      allow.groups(['admin']).to(['read', 'update']),
    ]),

  CustomerAddress: a
    .model({
      customerId: a.id().required(),
      firstName: a.string().required(),
      lastName: a.string().required(),
      company: a.string(),
      address1: a.string().required(),
      address2: a.string(),
      city: a.string().required(),
      province: a.string().required(),
      zip: a.string().required(),
      country: a.string().required(),
      phone: a.phone(),
      isDefault: a.boolean().default(false),
      
      // Relations
      customer: a.belongsTo('Customer', 'customerId'),
    })
    .authorization(allow => [
      allow.owner().to(['create', 'read', 'update', 'delete']),
    ]),
});
```

## 🎨 UI Components Implementation

### Product Catalog Components

#### Product Grid Component
```typescript
// components/ProductGrid.tsx
'use client';

import { useState, useEffect } from 'react';
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

const client = generateClient<Schema>();

interface ProductGridProps {
  categoryId?: string;
  vendorId?: string;
  searchQuery?: string;
  sortBy?: 'name' | 'price' | 'created' | 'rating';
  sortOrder?: 'asc' | 'desc';
  limit?: number;
}

export function ProductGrid({
  categoryId,
  vendorId,
  searchQuery,
  sortBy = 'created',
  sortOrder = 'desc',
  limit = 20
}: ProductGridProps) {
  const [products, setProducts] = useState<Schema['Product']['type'][]>([]);
  const [loading, setLoading] = useState(true);
  const [nextToken, setNextToken] = useState<string | undefined>();
  const [hasMore, setHasMore] = useState(true);

  useEffect(() => {
    fetchProducts(true);
  }, [categoryId, vendorId, searchQuery, sortBy, sortOrder]);

  const fetchProducts = async (reset = false) => {
    try {
      setLoading(true);
      
      const filters: any = {
        and: [
          { status: { eq: 'active' } },
          { visibility: { eq: 'public' } }
        ]
      };

      if (categoryId) {
        filters.and.push({ categories: { contains: categoryId } });
      }

      if (vendorId) {
        filters.and.push({ vendorId: { eq: vendorId } });
      }

      if (searchQuery) {
        filters.and.push({
          or: [
            { name: { contains: searchQuery } },
            { description: { contains: searchQuery } },
            { tags: { contains: searchQuery } }
          ]
        });
      }

      const sortField = sortBy === 'created' ? 'createdAt' : sortBy;
      const result = await client.models.Product.list({
        filter: filters,
        sort: { field: sortField, direction: sortOrder },
        limit,
        nextToken: reset ? undefined : nextToken,
      });

      setProducts(prev => reset ? result.data : [...prev, ...result.data]);
      setNextToken(result.nextToken);
      setHasMore(!!result.nextToken);
    } catch (error) {
      console.error('Error fetching products:', error);
    } finally {
      setLoading(false);
    }
  };

  const loadMore = () => {
    if (!loading && hasMore) {
      fetchProducts(false);
    }
  };

  if (loading && products.length === 0) {
    return <ProductGridSkeleton />;
  }

  return (
    <div className="product-grid-container">
      <div className="product-grid">
        {products.map((product) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
      
      {hasMore && (
        <div className="load-more">
          <button 
            onClick={loadMore} 
            disabled={loading}
            className="btn-secondary"
          >
            {loading ? 'Loading...' : 'Load More Products'}
          </button>
        </div>
      )}

      {products.length === 0 && !loading && (
        <div className="empty-state">
          <h3>No products found</h3>
          <p>Try adjusting your filters or search terms.</p>
        </div>
      )}
    </div>
  );
}
```

#### Product Card Component
```typescript
// components/ProductCard.tsx
import { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useCart } from '@/hooks/useCart';
import { useWishlist } from '@/hooks/useWishlist';
import type { Schema } from '@/amplify/data/resource';

interface ProductCardProps {
  product: Schema['Product']['type'];
  showVendor?: boolean;
  showQuickAdd?: boolean;
}

export function ProductCard({ 
  product, 
  showVendor = true, 
  showQuickAdd = true 
}: ProductCardProps) {
  const [currentImageIndex, setCurrentImageIndex] = useState(0);
  const [isHovered, setIsHovered] = useState(false);
  const { addToCart, isLoading: cartLoading } = useCart();
  const { toggleWishlist, isInWishlist } = useWishlist();

  const hasDiscount = product.compareAtPrice && product.compareAtPrice > product.price;
  const discountPercentage = hasDiscount 
    ? Math.round(((product.compareAtPrice - product.price) / product.compareAtPrice) * 100)
    : 0;

  const handleQuickAdd = async (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    
    try {
      await addToCart({
        productId: product.id,
        quantity: 1,
        price: product.price,
      });
    } catch (error) {
      console.error('Error adding to cart:', error);
    }
  };

  const handleWishlistToggle = async (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    
    await toggleWishlist(product.id);
  };

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(price);
  };

  return (
    <div 
      className="product-card"
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <Link href={`/products/${product.id}`} className="product-link">
        <div className="product-image-container">
          {product.images && product.images.length > 0 && (
            <>
              <Image
                src={product.images[currentImageIndex]}
                alt={product.name}
                fill
                className="product-image"
                sizes="(max-width: 768px) 50vw, (max-width: 1200px) 33vw, 25vw"
              />
              
              {product.images.length > 1 && isHovered && (
                <div className="image-navigation">
                  {product.images.map((_, index) => (
                    <button
                      key={index}
                      className={`nav-dot ${index === currentImageIndex ? 'active' : ''}`}
                      onClick={(e) => {
                        e.preventDefault();
                        setCurrentImageIndex(index);
                      }}
                    />
                  ))}
                </div>
              )}
            </>
          )}

          {hasDiscount && (
            <div className="discount-badge">
              -{discountPercentage}%
            </div>
          )}

          {product.quantity === 0 && (
            <div className="stock-overlay">
              <span>Out of Stock</span>
            </div>
          )}

          <button
            className={`wishlist-btn ${isInWishlist(product.id) ? 'active' : ''}`}
            onClick={handleWishlistToggle}
            aria-label="Add to wishlist"
          >
            ♡
          </button>
        </div>

        <div className="product-info">
          {showVendor && (
            <div className="vendor-name">
              {product.vendor?.businessName || 'Store'}
            </div>
          )}
          
          <h3 className="product-title">{product.name}</h3>
          
          <div className="product-price">
            <span className="current-price">
              {formatPrice(product.price)}
            </span>
            {hasDiscount && (
              <span className="compare-price">
                {formatPrice(product.compareAtPrice)}
              </span>
            )}
          </div>

          {product.shortDescription && (
            <p className="product-description">
              {product.shortDescription}
            </p>
          )}

          <div className="product-meta">
            {product.quantity <= 5 && product.quantity > 0 && (
              <span className="low-stock">
                Only {product.quantity} left
              </span>
            )}
          </div>
        </div>
      </Link>

      {showQuickAdd && product.quantity > 0 && (
        <div className={`quick-actions ${isHovered ? 'visible' : ''}`}>
          <button
            className="quick-add-btn"
            onClick={handleQuickAdd}
            disabled={cartLoading}
          >
            {cartLoading ? 'Adding...' : 'Quick Add'}
          </button>
        </div>
      )}
    </div>
  );
}
```

#### Product Detail Component
```typescript
// components/ProductDetail.tsx
'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';
import { useCart } from '@/hooks/useCart';
import { useWishlist } from '@/hooks/useWishlist';
import { ProductImageGallery } from './ProductImageGallery';
import { ProductVariantSelector } from './ProductVariantSelector';
import { ProductReviews } from './ProductReviews';
import type { Schema } from '@/amplify/data/resource';

interface ProductDetailProps {
  productId: string;
}

export function ProductDetail({ productId }: ProductDetailProps) {
  const [product, setProduct] = useState<Schema['Product']['type'] | null>(null);
  const [selectedVariant, setSelectedVariant] = useState<Schema['ProductVariant']['type'] | null>(null);
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(true);
  
  const { addToCart, isLoading: cartLoading } = useCart();
  const { toggleWishlist, isInWishlist } = useWishlist();

  useEffect(() => {
    fetchProduct();
  }, [productId]);

  const fetchProduct = async () => {
    try {
      const result = await client.models.Product.get(
        { id: productId },
        { include: { variants: true, vendor: true } }
      );
      
      if (result.data) {
        setProduct(result.data);
        // Select first variant by default
        if (result.data.variants && result.data.variants.length > 0) {
          setSelectedVariant(result.data.variants[0]);
        }
      }
    } catch (error) {
      console.error('Error fetching product:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleAddToCart = async () => {
    if (!product) return;

    try {
      await addToCart({
        productId: product.id,
        variantId: selectedVariant?.id,
        quantity,
        price: selectedVariant?.price || product.price,
      });
    } catch (error) {
      console.error('Error adding to cart:', error);
    }
  };

  const currentPrice = selectedVariant?.price || product?.price || 0;
  const comparePrice = selectedVariant?.compareAtPrice || product?.compareAtPrice;
  const currentStock = selectedVariant?.quantity || product?.quantity || 0;
  const hasDiscount = comparePrice && comparePrice > currentPrice;

  if (loading) return <ProductDetailSkeleton />;
  if (!product) return <div>Product not found</div>;

  return (
    <div className="product-detail">
      <div className="product-detail-grid">
        <div className="product-images">
          <ProductImageGallery 
            images={product.images} 
            productName={product.name}
          />
        </div>

        <div className="product-info">
          <div className="product-header">
            <div className="vendor-info">
              <Link href={`/vendors/${product.vendor?.id}`}>
                {product.vendor?.businessName}
              </Link>
            </div>
            
            <h1 className="product-title">{product.name}</h1>
            
            <div className="product-price">
              <span className="current-price">
                {formatPrice(currentPrice)}
              </span>
              {hasDiscount && (
                <span className="compare-price">
                  {formatPrice(comparePrice)}
                </span>
              )}
            </div>
          </div>

          {product.variants && product.variants.length > 0 && (
            <ProductVariantSelector
              variants={product.variants}
              selectedVariant={selectedVariant}
              onVariantChange={setSelectedVariant}
            />
          )}

          <div className="quantity-selector">
            <label htmlFor="quantity">Quantity:</label>
            <div className="quantity-input">
              <button
                onClick={() => setQuantity(Math.max(1, quantity - 1))}
                disabled={quantity <= 1}
              >
                -
              </button>
              <input
                id="quantity"
                type="number"
                value={quantity}
                onChange={(e) => setQuantity(Math.max(1, parseInt(e.target.value) || 1))}
                min="1"
                max={currentStock}
              />
              <button
                onClick={() => setQuantity(Math.min(currentStock, quantity + 1))}
                disabled={quantity >= currentStock}
              >
                +
              </button>
            </div>
          </div>

          <div className="product-actions">
            <button
              className="add-to-cart-btn"
              onClick={handleAddToCart}
              disabled={cartLoading || currentStock === 0}
            >
              {cartLoading ? 'Adding...' : currentStock > 0 ? 'Add to Cart' : 'Out of Stock'}
            </button>
            
            <button
              className={`wishlist-btn ${isInWishlist(product.id) ? 'active' : ''}`}
              onClick={() => toggleWishlist(product.id)}
            >
              {isInWishlist(product.id) ? 'Remove from Wishlist' : 'Add to Wishlist'}
            </button>
          </div>

          <div className="stock-info">
            {currentStock > 0 ? (
              <span className="in-stock">
                ✓ {currentStock} in stock
              </span>
            ) : (
              <span className="out-of-stock">
                ✗ Out of stock
              </span>
            )}
          </div>

          <div className="product-description">
            <h3>Description</h3>
            <div dangerouslySetInnerHTML={{ __html: product.description }} />
          </div>

          <div className="product-details">
            <details>
              <summary>Shipping & Returns</summary>
              <div className="details-content">
                <p>Free shipping on orders over $50</p>
                <p>30-day return policy</p>
                <p>Processing time: 1-3 business days</p>
              </div>
            </details>
          </div>
        </div>
      </div>

      <div className="product-reviews-section">
        <ProductReviews productId={product.id} />
      </div>
    </div>
  );
}
```

### Shopping Cart Components

#### Shopping Cart Component
```typescript
// components/ShoppingCart.tsx
'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { useCart } from '@/hooks/useCart';
import type { Schema } from '@/amplify/data/resource';

export function ShoppingCart() {
  const {
    cart,
    items,
    updateQuantity,
    removeItem,
    clearCart,
    subtotal,
    estimatedTax,
    estimatedShipping,
    total,
    isLoading,
    applyCoupon,
    removeCoupon
  } = useCart();

  const [couponCode, setCouponCode] = useState('');
  const [couponLoading, setCouponLoading] = useState(false);

  const handleCouponApply = async () => {
    if (!couponCode.trim()) return;
    
    setCouponLoading(true);
    try {
      await applyCoupon(couponCode);
      setCouponCode('');
    } catch (error) {
      console.error('Error applying coupon:', error);
    } finally {
      setCouponLoading(false);
    }
  };

  const formatPrice = (price: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(price);
  };

  if (isLoading) return <CartSkeleton />;

  return (
    <div className="shopping-cart">
      <div className="cart-header">
        <h2>Shopping Cart ({items.length} items)</h2>
        {items.length > 0 && (
          <button onClick={clearCart} className="clear-cart-btn">
            Clear Cart
          </button>
        )}
      </div>

      {items.length === 0 ? (
        <div className="empty-cart">
          <h3>Your cart is empty</h3>
          <p>Add some products to get started!</p>
          <Link href="/products" className="btn-primary">
            Continue Shopping
          </Link>
        </div>
      ) : (
        <>
          <div className="cart-items">
            {items.map((item) => (
              <div key={`${item.productId}-${item.variantId || 'default'}`} className="cart-item">
                <div className="item-image">
                  <Image
                    src={item.product.images?.[0] || '/placeholder.jpg'}
                    alt={item.product.name}
                    width={80}
                    height={80}
                  />
                </div>

                <div className="item-details">
                  <Link href={`/products/${item.productId}`} className="item-name">
                    {item.product.name}
                  </Link>
                  
                  {item.variant && (
                    <div className="item-variant">
                      {Object.entries(item.variant.options).map(([key, value]) => (
                        <span key={key} className="variant-option">
                          {key}: {value}
                        </span>
                      ))}
                    </div>
                  )}

                  <div className="item-price">
                    {formatPrice(item.price)}
                  </div>
                </div>

                <div className="item-quantity">
                  <button
                    onClick={() => updateQuantity(item.productId, item.variantId, item.quantity - 1)}
                    disabled={item.quantity <= 1}
                  >
                    -
                  </button>
                  <span>{item.quantity}</span>
                  <button
                    onClick={() => updateQuantity(item.productId, item.variantId, item.quantity + 1)}
                  >
                    +
                  </button>
                </div>

                <div className="item-total">
                  {formatPrice(item.price * item.quantity)}
                </div>

                <button
                  className="remove-item-btn"
                  onClick={() => removeItem(item.productId, item.variantId)}
                >
                  ×
                </button>
              </div>
            ))}
          </div>

          <div className="cart-summary">
            <div className="coupon-section">
              <div className="coupon-input">
                <input
                  type="text"
                  placeholder="Coupon code"
                  value={couponCode}
                  onChange={(e) => setCouponCode(e.target.value)}
                />
                <button
                  onClick={handleCouponApply}
                  disabled={couponLoading || !couponCode.trim()}
                >
                  {couponLoading ? 'Applying...' : 'Apply'}
                </button>
              </div>
              
              {cart?.couponCode && (
                <div className="applied-coupon">
                  <span>Coupon: {cart.couponCode}</span>
                  <button onClick={removeCoupon}>Remove</button>
                </div>
              )}
            </div>

            <div className="cart-totals">
              <div className="total-line">
                <span>Subtotal:</span>
                <span>{formatPrice(subtotal)}</span>
              </div>
              
              {cart?.discountAmount > 0 && (
                <div className="total-line discount">
                  <span>Discount:</span>
                  <span>-{formatPrice(cart.discountAmount)}</span>
                </div>
              )}
              
              <div className="total-line">
                <span>Estimated Tax:</span>
                <span>{formatPrice(estimatedTax)}</span>
              </div>
              
              <div className="total-line">
                <span>Estimated Shipping:</span>
                <span>{formatPrice(estimatedShipping)}</span>
              </div>
              
              <div className="total-line grand-total">
                <span>Total:</span>
                <span>{formatPrice(total)}</span>
              </div>
            </div>

            <div className="cart-actions">
              <Link href="/products" className="btn-secondary">
                Continue Shopping
              </Link>
              <Link href="/checkout" className="btn-primary">
                Proceed to Checkout
              </Link>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
```

## 🔐 Security & Payment Processing

### Payment Integration
```typescript
// Payment processing with Stripe
export class PaymentService {
  private stripe: Stripe;

  constructor() {
    this.stripe = new Stripe(process.env.STRIPE_SECRET_KEY!);
  }

  async createPaymentIntent(amount: number, currency = 'usd'): Promise<string> {
    try {
      const paymentIntent = await this.stripe.paymentIntents.create({
        amount: Math.round(amount * 100), // Convert to cents
        currency,
        automatic_payment_methods: {
          enabled: true,
        },
      });

      return paymentIntent.client_secret!;
    } catch (error) {
      console.error('Payment intent creation failed:', error);
      throw new Error('Unable to process payment');
    }
  }

  async confirmPayment(paymentIntentId: string): Promise<boolean> {
    try {
      const paymentIntent = await this.stripe.paymentIntents.retrieve(paymentIntentId);
      return paymentIntent.status === 'succeeded';
    } catch (error) {
      console.error('Payment confirmation failed:', error);
      return false;
    }
  }
}
```

## ⚡ Performance Optimization

### Product Search & Filtering
```typescript
// Optimized product search
export class ProductSearchService {
  async searchProducts(query: string, filters: ProductFilters): Promise<SearchResult> {
    // Implement Elasticsearch or Algolia for better search performance
    const searchParams = {
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query,
                fields: ['name^3', 'description', 'tags^2'],
                type: 'best_fields',
                fuzziness: 'AUTO'
              }
            }
          ],
          filter: this.buildFilters(filters)
        }
      },
      sort: this.buildSort(filters.sortBy, filters.sortOrder),
      from: filters.offset || 0,
      size: filters.limit || 20
    };

    // Execute search and return results
    return await this.executeSearch(searchParams);
  }

  private buildFilters(filters: ProductFilters): any[] {
    const esFilters = [];

    if (filters.category) {
      esFilters.push({ term: { 'categories.keyword': filters.category } });
    }

    if (filters.priceRange) {
      esFilters.push({
        range: {
          price: {
            gte: filters.priceRange.min,
            lte: filters.priceRange.max
          }
        }
      });
    }

    if (filters.inStock) {
      esFilters.push({ range: { quantity: { gt: 0 } } });
    }

    return esFilters;
  }
}
```

---

*This E-Commerce architecture pattern provides a comprehensive foundation for building scalable online stores and marketplaces with AWS Amplify Gen 2 and Next.js, featuring product management, order processing, payment integration, and multi-vendor support.*

**Pattern Version**: 1.0  
**Complexity**: High  
**Estimated Implementation**: 6-10 weeks  
**Recommended Team Size**: 4-6 developers