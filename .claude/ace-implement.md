# ACE-Implement: Infrastructure-Aware Implementation

**Deploys production-ready AWS Amplify Gen 2 applications with infrastructure timing awareness and auto-fix capabilities.**

## Usage

```bash
/ace-implement [project-name]
```

Examples:
- `/ace-implement fit-flow-social`
- `/ace-implement craft-marketplace`
- `/ace-implement content-hub`

## Prerequisites

✅ **Genesis Complete**: `/ace-genesis` conversation finished with structured specifications
✅ **Research Complete**: `/ace-research` documentation gathered (30-100 pages)
✅ **AWS Configured**: AWS CLI with appropriate permissions
✅ **Environment Ready**: Node.js 18+, project directory prepared

## 📊 Progress Tracking

Real-time progress updates during implementation:
```
🚀 Starting ACE-Implement for fit_flow_social...
[30s] ☁️ Deploying backend infrastructure... (creating DynamoDB tables)
[120s] ☁️ Backend deployment... (setting up Auth resources)
[240s] ✅ Backend deployed successfully!
[250s] 📝 Generating TypeScript types...
[300s] 💻 Building frontend components... (12/20 complete)
[450s] 🧪 Running validation tests... (8/15 passed)
[600s] ✅ Implementation complete! App ready at: https://...
```

Use `/ace-status --detailed` for comprehensive progress breakdown.

## Infrastructure-Aware Implementation Process

### Phase 1: Backend Infrastructure Deployment (2-5 minutes)

**Smart Deployment Sequencing**:
1. **Authentication Setup** (2-3 minutes)
   - AWS Cognito user pools and identity pools
   - User groups and role-based access configuration
   - Social authentication providers if required

2. **Data Layer Deployment** (1-2 minutes)  
   - DynamoDB tables with optimized indexes
   - GraphQL API with AppSync configuration
   - Real-time subscription endpoints

3. **Storage Configuration** (1-2 minutes)
   - S3 buckets with proper IAM policies
   - CloudFront CDN for media delivery
   - File upload/download access patterns

4. **Custom Functions** (2-4 minutes if needed)
   - AWS Lambda functions for business logic
   - Event-driven processing pipelines
   - Third-party service integrations

**Infrastructure Timing Awareness**:
```yaml
Expected_Deployment_Times:
  Simple_CRUD: "1-2 minutes"
  Content_Management: "2-3 minutes"  
  Social_Platform: "3-4 minutes"
  E_commerce: "4-5 minutes"
  Dashboard_Analytics: "3-4 minutes"
```

### Phase 2: Smart Hook Activation & Type Generation (30-60 seconds)

**Smart AWS Amplify Hooks**:
- **Schema Change Detection**: Auto-triggers type regeneration on GraphQL changes
- **Build Validation**: Auto-runs validation tests before deployment
- **Cost Monitoring**: Auto-alerts on resource usage thresholds
- **Security Scanning**: Auto-checks for exposed secrets or misconfigurations

**Automatic Type Safety**:
- Waits for GraphQL schema deployment completion
- Generates TypeScript types from deployed schema
- Validates type consistency across all endpoints
- Creates type-safe client configuration

### Phase 3: Frontend Implementation (30-60 minutes)

**Architecture-Specific Implementation**:

#### Social Platform Implementation
- **User Authentication**: Multi-role Cognito with user groups and social login
- **Real-time Features**: GraphQL subscriptions for live feeds and messaging
- **Media Handling**: S3 storage with image optimization and CloudFront delivery
- **Social Components**: User profiles, activity feeds, messaging interfaces, notification systems

#### E-commerce Implementation
- **Multi-vendor Authentication**: Buyer/seller role management with vendor onboarding
- **Payment Integration**: Stripe Connect for marketplace payments with tax handling
- **Product Management**: Catalog with search, inventory tracking, order processing
- **Vendor Dashboard**: Seller tools, analytics, inventory management interfaces

#### Content Management Implementation
- **Publishing Workflow**: Draft/review/publish states with approval processes
- **Rich Content Editor**: WYSIWYG editing with media embedding
- **SEO Optimization**: Meta tags, structured data, sitemap generation
- **Media Library**: Asset management with optimization and CDN delivery

#### Dashboard Analytics Implementation
- **Real-time Data Streams**: Kinesis integration for live data ingestion
- **Interactive Visualizations**: Chart libraries with performance optimization
- **Complex Queries**: Optimized data fetching with caching strategies
- **User Experience**: Responsive dashboards with filtering and drill-down capabilities

### Phase 4: Validation, Auto-Fix & Hook Integration (15-30 minutes)

**Smart Hook Integration**:
- **File Change Hooks**: Auto-format code on save, run linting checks
- **Deployment Hooks**: Auto-backup before deployment, run pre-flight checks  
- **Error Hooks**: Auto-apply research-based fixes for common AWS issues
- **Performance Hooks**: Auto-optimize images, check bundle size

**Multi-Level Validation**:

#### Level 1: Syntax and Type Validation
- TypeScript compilation with strict mode
- ESLint and Prettier formatting validation
- Import/export resolution verification
- Component prop type checking

#### Level 2: AWS Integration Validation  
- Authentication flow testing with real Cognito
- Data operations validation with real DynamoDB
- Storage operations testing with real S3
- Real-time features validation with AppSync subscriptions

#### Level 3: Performance and Security Validation
- Image optimization and lazy loading verification
- Security headers and HTTPS enforcement
- Performance metrics and Core Web Vitals validation
- Accessibility compliance checking

**Auto-Fix Capabilities with Smart Hooks (85%+ success rate)**:

```python
# Auto-fix examples with intelligent hook triggers
def smart_hook_auto_fixes():
    hook_enhanced_fixes = {
        "auth_configuration_mismatch": {
            "fix": "Update amplify_outputs.json references",
            "hook": "auto_trigger_on_amplify_config_change"
        },
        "graphql_type_errors": {
            "fix": "Regenerate types after schema changes",
            "hook": "auto_trigger_on_schema_save"
        }, 
        "s3_permission_denied": {
            "fix": "Update IAM policies for bucket access",
            "hook": "auto_validate_permissions_on_deploy"
        },
        "subscription_connection_failed": {
            "fix": "Configure WebSocket authentication", 
            "hook": "auto_test_websocket_on_build"
        },
        "performance_degradation": {
            "fix": "Optimize images and bundle size",
            "hook": "auto_compress_on_asset_add"
        }
    }
    return apply_hook_enhanced_fixes(hook_enhanced_fixes)
```

## Expected Project Structure After Implementation

```
[project-name]/
├── amplify/                    # Backend configuration
│   ├── backend.ts             # Main backend definition
│   ├── auth/resource.ts       # Authentication setup
│   ├── data/resource.ts       # GraphQL schema
│   ├── storage/resource.ts    # S3 configuration
│   └── functions/             # Lambda functions (if needed)
├── src/                       # Frontend application
│   ├── app/                   # Next.js App Router
│   │   ├── layout.tsx         # Root layout with auth
│   │   ├── page.tsx           # Home page
│   │   └── [feature]/         # Feature-specific pages
│   ├── components/            # Reusable UI components
│   │   ├── auth/              # Authentication components
│   │   ├── ui/                # Base UI components
│   │   └── [pattern]/         # Pattern-specific components
│   ├── lib/                   # Utilities and helpers
│   │   ├── amplify.ts         # Amplify configuration
│   │   ├── types.ts           # Generated types
│   │   └── utils.ts           # Helper functions
│   └── styles/                # Styling and themes
├── tests/                     # Comprehensive test suite
│   ├── unit/                  # Component and function tests
│   ├── integration/           # API and database tests
│   └── e2e/                   # End-to-end user flows
├── docs/                      # Generated documentation
│   ├── api.md                 # API documentation
│   ├── deployment.md          # Deployment guide
│   └── architecture.md        # Architecture overview
└── deployment/                # Production deployment config
    ├── amplify.yml            # Amplify hosting config
    └── production.env         # Environment variables
```

## Real-World Infrastructure Testing

**Tests Against Actual AWS Services**:
- Authentication flows with real AWS Cognito user pools
- Data operations with real DynamoDB tables and indexes
- File uploads/downloads with real S3 buckets and CloudFront
- Real-time features with actual AppSync GraphQL subscriptions
- Payment processing with live Stripe Connect (test mode)

## Success Criteria and Quality Gates

### Infrastructure Deployment Success
- ✅ All AWS resources deployed and accessible
- ✅ GraphQL API responding with correct schema
- ✅ Authentication service accepting user registration/login
- ✅ Storage buckets configured with proper permissions

### Frontend Implementation Success  
- ✅ Application builds without TypeScript errors
- ✅ All pages render without console errors
- ✅ Authentication flows work end-to-end
- ✅ Data operations (CRUD) function correctly
- ✅ Real-time features update properly

### Production Readiness Validation
- ✅ All unit and integration tests pass
- ✅ Performance metrics meet benchmarks
- ✅ Security validations complete
- ✅ Accessibility compliance verified
- ✅ SEO optimization implemented

## Implementation Timeline

- **Simple CRUD**: 60-90 minutes total implementation
- **Content Management**: 90-120 minutes total implementation
- **Social Platform**: 120-150 minutes total implementation  
- **E-commerce**: 150-180 minutes total implementation
- **Dashboard Analytics**: 120-180 minutes total implementation

## Quality Metrics

- **First-Run Success Rate**: >95% of implementations deploy successfully
- **Auto-Fix Success Rate**: >80% of common issues resolved automatically
- **Documentation Accuracy**: >95% of patterns match research documentation
- **Production Readiness**: 100% of generated apps pass security and performance validation

## Development Commands

```bash
# Local development
npx amplify sandbox          # Deploy backend to AWS
npm run dev                  # Start frontend development server

# Production deployment
npx amplify pipeline-deploy  # Deploy to production
npm run build               # Build optimized frontend
npm test                    # Run full test suite
```

*ACE-Implement bridges the gap between design and reality, ensuring every generated application works flawlessly in the real AWS cloud environment with proper infrastructure timing awareness and production-ready quality.*