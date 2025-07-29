# ACE-Scrape: Intelligent Documentation Scraping

**Efficiently scrape and organize any technical documentation for your ACE-Flow projects.**

## Usage

```bash
/ace-scrape [url] [destination]
```

Examples:
- `/ace-scrape https://react.dev /ace-system/frameworks/react`
- `/ace-scrape https://stripe.com/docs/api /ace-dev-foundation/stripe-api`
- `/ace-scrape https://d3js.org/getting-started /resources/d3-tutorials`

## What It Does

The ace-scrape command uses the `documentation-scraper-agent` to:

1. **Analyze** the documentation site structure
2. **Detect** version information and documentation type
3. **Scrape** content efficiently using Firecrawl MCP
4. **Organize** into logical folder structures
5. **Create** metadata for version tracking
6. **Optimize** content for Claude consumption

## Destination Guidelines

### Framework Documentation
- **Destination**: `/ace-system/frameworks/[name]/`
- **Example**: `/ace-scrape https://vuejs.org /ace-system/frameworks/vue`
- **Note**: Run `/ace-version-check` after scraping to update registry

### API Documentation
- **Destination**: `/ace-dev-foundation/[api-name]/`
- **Example**: `/ace-scrape https://docs.github.com/rest /ace-dev-foundation/github-api`
- **Focus**: Endpoints, authentication, examples

### Library Documentation
- **Destination**: `/libraries/[library-name]/`
- **Example**: `/ace-scrape https://tanstack.com/query /libraries/tanstack-query`
- **Focus**: Core API, patterns, integration guides

### Tutorials & Resources
- **Destination**: `/resources/[topic]/`
- **Example**: `/ace-scrape https://threejs.org/manual /resources/threejs-tutorials`
- **Focus**: Step-by-step guides, examples

## Advanced Options

### Focused Scraping
```bash
# Scrape only specific sections
/ace-scrape https://nextjs.org/docs/app "focusing on app router" /ace-system/frameworks/nextjs14

# Scrape with version targeting
/ace-scrape https://docs.python.org/3.12/ "Python 3.12 specific" /libraries/python312
```

### Update Existing Documentation
```bash
# Check for updates and re-scrape if newer
/ace-scrape --update https://react.dev /ace-system/frameworks/react
```

## Output Structure

Every scraped documentation includes:
- **README.md** - Auto-generated navigation and overview
- **.scraping-metadata.json** - Version and source tracking
- **Organized sections** - Based on detected structure
- **Clean markdown** - Optimized for Claude

## Metadata Tracking

The `.scraping-metadata.json` file tracks:
```json
{
  "name": "React",
  "version": "18.2.0",
  "scrape_date": "2025-01-28",
  "source_url": "https://react.dev",
  "total_pages": 145,
  "sections": ["learn", "reference", "community"],
  "type": "framework"
}
```

## Integration with ACE-Flow

### For Frameworks
1. Scrape with: `/ace-scrape [url] /ace-system/frameworks/[name]`
2. Update registry: `/ace-version-check`
3. Use in projects: Documentation automatically available

### For Other Resources
1. Scrape to appropriate directory
2. Metadata tracked locally
3. No registry update needed

## Common Use Cases

### Adding a New Framework
```bash
/ace-scrape https://svelte.dev/docs /ace-system/frameworks/svelte
/ace-version-check  # Updates registry
```

### Updating API Documentation
```bash
/ace-scrape https://openai.com/api /ace-dev-foundation/openai-api
# Automatically detects version changes
```

### Collecting Learning Resources
```bash
/ace-scrape https://css-tricks.com/guides /resources/css-guides
# Preserves tutorial structure
```

## Tips for Success

1. **Choose the right destination** - Frameworks go in `/ace-system/frameworks/`
2. **Let it auto-detect** - The agent is smart about documentation types
3. **Check metadata** - Always verify version was captured correctly
4. **Run version-check** - For framework docs, update the registry
5. **Be patient** - Large documentation sites may take a few minutes

## Troubleshooting

### Rate Limiting
The agent automatically handles rate limits with delays

### Dynamic Content
Falls back to Playwright for JavaScript-rendered sites

### Authentication Required
The agent will guide you through manual steps if needed

### Version Not Detected
Check `.scraping-metadata.json` and add manually if needed

## Examples of Scraped Documentation

### Framework Example (React)
```
/ace-system/frameworks/react/
├── README.md
├── .scraping-metadata.json
├── learn/
├── reference/
└── examples/
```

### API Example (Stripe)
```
/ace-dev-foundation/stripe-api/
├── README.md
├── .scraping-metadata.json
├── authentication/
├── core-resources/
├── webhooks/
└── examples/
```

The ace-scrape command makes it easy to build a comprehensive documentation library for all your ACE-Flow projects!