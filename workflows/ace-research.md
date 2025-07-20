# 🔬 ACE-Research: Advanced Context Engineering Research Workflow

**Comprehensive documentation research system that gathers 30-100 pages of framework-specific knowledge before implementation.**

## Research Philosophy

ACE-Research operates on the principle that **documentation is the source of truth**. It systematically gathers, validates, and organizes the most current documentation to ensure implementations are accurate and follow best practices.

## Research Workflow Architecture

### Phase 1: Domain Research Planning
```yaml
Input: "ace-research [project-domain] [architecture-pattern]"
Example: "ace-research social-fitness-app social_platform"

Planning_Stage:
  domain_analysis:
    - Extract key technologies from architecture decision
    - Identify critical integration points
    - Map documentation requirements
    
  research_scope:
    - Primary frameworks (AWS Amplify Gen 2, Next.js, React)
    - Secondary integrations (authentication, storage, real-time)
    - Tertiary optimizations (performance, security, deployment)
    
  priority_matrix:
    critical: ["amplify_gen2_data", "amplify_gen2_auth", "nextjs_app_router"]
    important: ["real_time_subscriptions", "s3_storage", "cognito_integration"]
    supplementary: ["performance_optimization", "deployment_strategies", "monitoring"]
```

### Phase 2: Systematic Documentation Gathering
```python
class DocumentationResearcher:
    def __init__(self, architecture_decision: dict):
        self.architecture = architecture_decision
        self.research_plan = self.create_research_plan()
        self.scraped_docs = {}
        
    def execute_research_workflow(self):
        """
        Execute comprehensive documentation research
        """
        # Phase 1: Core framework documentation
        core_docs = self.scrape_core_frameworks()
        
        # Phase 2: Integration-specific documentation
        integration_docs = self.scrape_integrations()
        
        # Phase 3: Pattern-specific best practices
        pattern_docs = self.scrape_architecture_patterns()
        
        # Phase 4: Validation and completeness check
        validated_docs = self.validate_documentation_completeness()
        
        return self.organize_research_output(validated_docs)
    
    def scrape_core_frameworks(self) -> dict:
        """
        Scrape essential framework documentation
        """
        core_urls = {
            "amplify_gen2": [
                "https://docs.amplify.aws/gen2/start/",
                "https://docs.amplify.aws/gen2/build-a-backend/data/",
                "https://docs.amplify.aws/gen2/build-a-backend/auth/",
                "https://docs.amplify.aws/gen2/build-a-backend/storage/",
                "https://docs.amplify.aws/gen2/deploy-and-host/",
            ],
            "nextjs_14": [
                "https://nextjs.org/docs/app",
                "https://nextjs.org/docs/app/building-your-application/routing",
                "https://nextjs.org/docs/app/building-your-application/data-fetching",
                "https://nextjs.org/docs/app/api-reference/components",
            ],
            "amplify_ui": [
                "https://ui.docs.amplify.aws/react/getting-started/installation",
                "https://ui.docs.amplify.aws/react/components/authenticator",
                "https://ui.docs.amplify.aws/react/components/storage",
            ]
        }
        
        return self.batch_scrape_urls(core_urls)
    
    def scrape_architecture_specific_docs(self) -> dict:
        """
        Scrape documentation specific to chosen architecture pattern
        """
        pattern = self.architecture["architecture_type"]["name"]
        
        pattern_specific_urls = {
            "social_platform": [
                "https://docs.amplify.aws/gen2/build-a-backend/data/data-modeling/",
                "https://docs.amplify.aws/gen2/build-a-backend/data/subscribe-to-real-time-events/",
                "https://docs.amplify.aws/gen2/build-a-backend/auth/concepts/user-groups/",
                "https://docs.amplify.aws/gen2/build-a-backend/storage/upload/",
            ],
            "e_commerce": [
                "https://docs.amplify.aws/gen2/build-a-backend/functions/",
                "https://docs.amplify.aws/gen2/build-a-backend/data/customize-authz/",
                "https://stripe.com/docs/connect",
                "https://docs.amplify.aws/gen2/build-a-backend/auth/manage-user-attributes/",
            ],
            "content_management": [
                "https://docs.amplify.aws/gen2/build-a-backend/storage/",
                "https://docs.amplify.aws/gen2/build-a-backend/data/data-modeling/",
                "https://nextjs.org/docs/app/building-your-application/optimizing/images",
            ],
            "dashboard_analytics": [
                "https://docs.amplify.aws/gen2/build-a-backend/data/data-modeling/",
                "https://docs.amplify.aws/gen2/build-a-backend/functions/streaming/",
                "https://docs.aws.amazon.com/kinesis/latest/dev/",
            ]
        }
        
        return self.batch_scrape_urls({pattern: pattern_specific_urls.get(pattern, [])})
```

### Phase 3: Intelligent Documentation Processing
```python
class DocumentationProcessor:
    def process_scraped_documentation(self, raw_docs: dict) -> dict:
        """
        Process and organize scraped documentation for maximum utility
        """
        processed = {}
        
        for category, docs in raw_docs.items():
            processed[category] = {
                "summary": self.generate_category_summary(docs),
                "key_patterns": self.extract_code_patterns(docs),
                "critical_gotchas": self.identify_gotchas(docs),
                "integration_points": self.map_integration_points(docs),
                "examples": self.extract_working_examples(docs),
                "raw_content": docs  # Keep full content for reference
            }
        
        return processed
    
    def extract_code_patterns(self, docs: list) -> list:
        """
        Extract reusable code patterns from documentation
        """
        patterns = []
        
        for doc in docs:
            # Extract TypeScript/JavaScript code blocks
            code_blocks = self.find_code_blocks(doc["content"])
            
            for block in code_blocks:
                if self.is_reusable_pattern(block):
                    patterns.append({
                        "pattern": block["code"],
                        "description": block["description"],
                        "use_case": block["context"],
                        "source_url": doc["url"]
                    })
        
        return patterns
    
    def identify_gotchas(self, docs: list) -> list:
        """
        Identify common pitfalls and gotchas from documentation
        """
        gotcha_indicators = [
            "note:", "important:", "warning:", "caution:",
            "make sure", "be careful", "avoid", "don't",
            "common mistake", "troubleshooting"
        ]
        
        gotchas = []
        for doc in docs:
            for indicator in gotcha_indicators:
                matches = self.find_sections_with_indicator(doc["content"], indicator)
                gotchas.extend(matches)
        
        return gotchas
```

### Phase 4: Research Output Organization
```yaml
Research_Output_Structure:
  ace-flow/research/[project-name]/
    ├── 00-research-summary.md         # Executive summary of all findings
    ├── core-frameworks/
    │   ├── amplify-gen2-essentials.md  # Core Amplify Gen 2 patterns
    │   ├── nextjs-app-router.md        # Next.js App Router specifics
    │   └── amplify-ui-components.md    # UI component library
    ├── architecture-specific/
    │   ├── [pattern]-patterns.md       # Architecture-specific patterns
    │   ├── [pattern]-integrations.md   # Required integrations
    │   └── [pattern]-gotchas.md        # Pattern-specific gotchas
    ├── integrations/
    │   ├── authentication.md           # Auth implementation details
    │   ├── storage.md                  # File storage patterns
    │   ├── real-time.md               # Real-time features
    │   └── third-party.md             # External service integrations
    ├── code-patterns/
    │   ├── data-modeling.md           # GraphQL schema patterns
    │   ├── frontend-components.md     # React component patterns
    │   ├── api-integration.md         # API consumption patterns
    │   └── deployment.md              # Deployment configurations
    └── validation/
        ├── testing-strategies.md      # Testing approaches
        ├── performance.md             # Performance optimization
        └── security.md               # Security best practices
```

### Phase 5: Context Engineering Integration
```python
class ContextEngineeringIntegrator:
    def integrate_with_prp_generation(self, research_output: dict, architecture: dict) -> dict:
        """
        Integrate research findings with PRP generation
        """
        return {
            "documentation_context": self.create_documentation_context(research_output),
            "code_patterns": self.extract_implementation_patterns(research_output),
            "gotchas_and_warnings": self.compile_critical_warnings(research_output),
            "validation_requirements": self.define_validation_steps(research_output),
            "integration_specifications": self.detail_integration_requirements(research_output)
        }
    
    def create_documentation_context(self, research: dict) -> str:
        """
        Create comprehensive documentation context for PRP
        """
        context = f"""
## All Needed Context

### Documentation & References
```yaml
# MUST READ - Include these in your context window
{self.format_critical_documentation_references(research)}
```

### Known Gotchas & Library Quirks
```typescript
{self.format_gotchas_for_prp(research)}
```

### Proven Code Patterns
```typescript
{self.format_code_patterns_for_prp(research)}
```
"""
        return context
```

## Research Validation System

### Documentation Quality Checks
```python
def validate_research_completeness(research_output: dict) -> dict:
    """
    Validate that research is comprehensive and actionable
    """
    validation_criteria = {
        "coverage_completeness": check_documentation_coverage(research_output),
        "code_pattern_availability": check_code_patterns(research_output),
        "integration_documentation": check_integration_docs(research_output),
        "gotcha_identification": check_gotcha_coverage(research_output),
        "example_availability": check_working_examples(research_output)
    }
    
    missing_areas = [area for area, passed in validation_criteria.items() if not passed]
    
    if missing_areas:
        return {
            "status": "incomplete",
            "missing_areas": missing_areas,
            "recommendations": generate_additional_research_plan(missing_areas)
        }
    
    return {"status": "complete", "ready_for_implementation": True}
```

### Auto-Generated Research Summary
```markdown
# Research Summary: {{project_name}} ({{architecture_pattern}})

## 📊 Research Coverage
- **Pages Scraped**: {{total_pages}}
- **Code Patterns Identified**: {{pattern_count}}
- **Critical Gotchas**: {{gotcha_count}}
- **Integration Points**: {{integration_count}}

## 🔑 Key Findings
{{#each key_findings}}
### {{title}}
{{description}}

**Implementation Impact**: {{impact}}
**Code Pattern**: 
```{{language}}
{{code_example}}
```
{{/each}}

## ⚠️ Critical Gotchas
{{#each critical_gotchas}}
### {{title}}
{{warning}}

**Prevention Strategy**: {{prevention}}
{{/each}}

## 🔗 Integration Requirements
{{#each integrations}}
### {{name}}
- **Documentation**: {{docs_url}}
- **Key Patterns**: {{patterns}}
- **Setup Requirements**: {{setup}}
{{/each}}

## ✅ Implementation Readiness
- [ ] All core documentation researched
- [ ] Architecture-specific patterns identified
- [ ] Integration requirements documented
- [ ] Gotchas and warnings compiled
- [ ] Code patterns extracted and validated

**Status**: Ready for PRP generation and implementation
```

## Usage Examples

### Research for Social Platform
```bash
ace-research social-fitness-app social_platform
```

**Expected Output**: 45-60 pages of documentation covering:
- Amplify Gen 2 user groups and social features
- Real-time GraphQL subscriptions
- S3 media handling with CloudFront
- Next.js social component patterns
- Authentication with user roles

### Research for E-commerce Platform
```bash
ace-research craft-marketplace e_commerce
```

**Expected Output**: 50-70 pages of documentation covering:
- Stripe Connect integration patterns
- Multi-vendor data modeling
- Order processing workflows
- Payment security best practices
- Amplify Gen 2 function integration

---

*ACE-Research ensures every implementation is built on a foundation of comprehensive, current documentation knowledge.*