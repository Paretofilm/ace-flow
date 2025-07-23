# 🔧 Framework Documentation

**Core framework documentation for AWS Amplify Gen 2, Next.js, and supporting technologies.**

## 📋 Framework Coverage

### AWS Amplify Gen 2
**Status**: ✅ Complete | **Version**: 2.x | **Last Updated**: Current

Essential documentation for AWS Amplify Gen 2 development:
- **[Getting Started](./amplify-gen2/getting-started.md)** - Setup, installation, and first project
- **[Data Modeling](./amplify-gen2/data-modeling.md)** - GraphQL schemas, relationships, and DynamoDB patterns
- **[Authentication](./amplify-gen2/authentication.md)** - User auth, social login, and role management
- **Storage** - File upload, S3 integration, and media handling (see [authentication.md](./amplify-gen2/authentication.md) for related patterns)
- **Real-time** - GraphQL subscriptions and live data (covered in [data-modeling.md](./amplify-gen2/data-modeling.md))
- **Functions** - Lambda functions and custom business logic
- **Deployment** - CI/CD, environments, and production setup  
- **API Reference** - Complete API documentation

### Next.js 14+
**Status**: ✅ Complete | **Version**: 14.x | **Last Updated**: Current

Next.js App Router and modern React patterns:
- **[App Router](./nextjs/app-router.md)** - File-based routing, layouts, and navigation
- **[Data Fetching](./nextjs/data-fetching.md)** - Server components, SSR, and caching
- **Routing** - Dynamic routes, route groups, and middleware (see [app-router.md](./nextjs/app-router.md))
- **Components** - Server/client components and best practices (covered in existing guides)
- **Optimization** - Performance, images, and bundle optimization
- **Deployment** - Production deployment patterns

### Amplify UI
**Status**: ✅ Complete | **Version**: 6.x | **Last Updated**: Current

Amplify UI component library for React:
- **Installation** - Setup and configuration (see [getting-started.md](./amplify-gen2/getting-started.md))
- **Authenticator** - Drop-in authentication UI (see [authentication.md](./amplify-gen2/authentication.md))
- **Components** - Core UI components and patterns
- **Theming** - Customization and styling
- **Storage Components** - File upload and management UI

### React 18+
**Status**: 🟡 Essential | **Version**: 18.x | **Last Updated**: Current

Essential React patterns for modern development:
- **Hooks Patterns** - Essential hooks and custom patterns (see existing guides)
- **State Management** - Context, reducers, and state patterns
- **Performance** - Optimization techniques and best practices

## 🎯 Usage Guidelines

### For Developers
- **Start Here**: Begin with getting-started guides for your chosen frameworks
- **Reference During Development**: Quick lookup for specific implementation patterns
- **Architecture Decisions**: Use framework capabilities to inform architecture choices

### For ACE-Flow Commands
- **Foundation Knowledge**: All commands reference these docs for accurate implementation
- **Pattern Validation**: Ensure generated code follows framework best practices
- **Integration Guidance**: Understand how frameworks work together

### For AI Code Analysis
- **Context Provision**: Comprehensive framework knowledge for code quality analysis
- **Best Practice Validation**: Verify code follows framework conventions
- **Security Review**: Framework-specific security patterns and gotchas

## 🔄 Maintenance Notes

### Update Frequency
- **Framework Releases**: Updated within 1 week of major framework releases
- **Security Updates**: Immediate updates for security-related changes
- **Best Practice Evolution**: Regular updates based on community best practices

### Quality Standards
- **Official Sources Only**: All content sourced from official framework documentation
- **Practical Focus**: Emphasis on real-world implementation patterns
- **Code Examples**: Working code samples for all major concepts
- **Gotcha Documentation**: Common pitfalls and prevention strategies

---

*This framework documentation provides the foundation for all ACE-Flow development, ensuring consistent, high-quality implementations that follow current best practices.*