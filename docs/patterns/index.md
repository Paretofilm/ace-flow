---
layout: docs
title: Architecture Patterns
---

# Architecture Patterns

ACE-Flow provides five pre-built architecture patterns optimized for AWS Amplify Gen 2 development. Each pattern includes complete backend schema, authentication, storage, and frontend components.

## Available Patterns

### [Social Platform Pattern](social-platform.md)
**Best for**: Social media apps, community platforms, collaboration tools
- User profiles and relationships
- Real-time feeds and notifications
- Media upload and sharing
- Social interactions (likes, comments, follows)

### [E-commerce Pattern](e-commerce.md)
**Best for**: Online stores, marketplaces, subscription services
- Product catalog and inventory
- Shopping cart and checkout
- Payment processing (Stripe integration)
- Order management and fulfillment

### [Content Management Pattern](content-management.md)
**Best for**: Blogs, documentation sites, publishing platforms
- Rich content creation and editing
- Multi-author workflows
- SEO optimization
- Content categorization and search

### [Dashboard Analytics Pattern](dashboard-analytics.md)
**Best for**: Business intelligence, monitoring dashboards, reporting tools
- Real-time data visualization
- Custom dashboard layouts
- Data aggregation and analysis
- Alert and notification systems

### [Simple CRUD Pattern](simple-crud.md)
**Best for**: Basic data management apps, forms, simple business tools
- Standard create, read, update, delete operations
- Form handling and validation
- Basic user management
- Simple reporting features

## Choosing the Right Pattern

When running `/ace-genesis`, ACE-Flow will automatically suggest the best pattern based on your description. However, you can also specify a pattern directly:

```bash
# Let ACE-Flow choose automatically
/ace-genesis "fitness tracking app with social features"

# Specify a pattern explicitly
/ace-genesis "fitness tracking app" --pattern=social_platform
```

## Pattern Features Comparison

| Feature | Social Platform | E-commerce | Content Mgmt | Dashboard | Simple CRUD |
|---------|----------------|------------|--------------|-----------|-------------|
| User Auth | ✅ Full social | ✅ Customer/Admin | ✅ Multi-role | ✅ Organization | ✅ Basic |
| Real-time | ✅ Subscriptions | ⚠️ Order updates | ⚠️ Comments | ✅ Live data | ❌ Not needed |
| File Storage | ✅ Media heavy | ⚠️ Product images | ✅ Rich content | ⚠️ Reports only | ⚠️ Basic files |
| Payments | ❌ Usually free | ✅ Core feature | ⚠️ Subscriptions | ❌ Not needed | ❌ Not needed |
| Search | ✅ Users/content | ✅ Products | ✅ Full-text | ✅ Data queries | ⚠️ Basic filter |
| Analytics | ⚠️ Basic metrics | ✅ Sales data | ⚠️ Content stats | ✅ Advanced | ⚠️ Simple reports |

## Implementation Time Estimates

- **Simple CRUD**: 30-60 minutes
- **Content Management**: 1-2 hours  
- **Social Platform**: 1.5-2.5 hours
- **E-commerce**: 2-3 hours
- **Dashboard Analytics**: 2.5-4 hours

*Times include complete backend + frontend implementation with AWS deployment*

## Custom Patterns

Need something different? ACE-Flow can create custom patterns by combining elements from existing ones:

```bash
/ace-genesis "marketplace with social features and analytics dashboard"
# Will combine e-commerce + social + dashboard patterns
```

## Getting Started

1. **Describe your app** to `/ace-genesis`
2. **Review the suggested pattern** and architecture
3. **Customize** through ACE-Flow's interview process
4. **Deploy** your production-ready application

---

[← Back to Getting Started](../getting-started.md) | [View Examples →](../examples.md)