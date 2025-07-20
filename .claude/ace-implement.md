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

✅ **Genesis Complete**: `/ace-genesis` conversation finished
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

### Phase 2: Type Generation and Validation (30-60 seconds)

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

### Phase 4: Validation and Auto-Fix System (15-30 minutes)

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

**Auto-Fix Capabilities (80%+ success rate)**:

```python
# Auto-fix examples based on research knowledge
def auto_fix_amplify_integration_issues():
    common_fixes = {
        "auth_configuration_mismatch": "Update amplify_outputs.json references",
        "graphql_type_errors": "Regenerate types after schema changes", 
        "s3_permission_denied": "Update IAM policies for bucket access",
        "subscription_connection_failed": "Configure WebSocket authentication",
        "stripe_webhook_verification": "Add proper endpoint validation"
    }
    return apply_research_based_fixes(common_fixes)
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