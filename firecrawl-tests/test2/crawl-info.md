# Test 2: Deep Crawl of AWS Amplify Documentation

## Crawl Configuration
- **Start URL**: https://docs.amplify.aws/nextjs/how-amplify-works/
- **Job ID**: `17e4d3c5-2e73-4437-aec5-c823b536d91f`
- **Max Depth**: 5 levels
- **Page Limit**: 100 pages
- **Include Paths**: `/nextjs/`
- **Exclude Paths**: `/nextjs/$` (index), `/nextjs/start/`, `/prev/`
- **Allow Backward Links**: Yes

## Strategy
Starting from "How Amplify Works" instead of the main index page to avoid:
- Cookie consent popups
- Marketing pages
- Getting stuck on the main landing page

## Expected Results
This should crawl deeper into the technical documentation including:
- Build & connect backend
- Authentication
- Data (GraphQL APIs)
- Storage
- Functions
- AI/ML features
- Deployment guides
- Troubleshooting

## Status Monitoring
Check crawl status with:
```
mcp__mcp-server-firecrawl__firecrawl_check_crawl_status(id="17e4d3c5-2e73-4437-aec5-c823b536d91f")
```

## Initial Discovery
- Found 23 pages to crawl (vs previous 100 limit)
- Credits used: 23
- Status: In progress