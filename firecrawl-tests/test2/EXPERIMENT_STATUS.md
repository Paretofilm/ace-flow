# Test 2 Experiment Status

## Setup Complete ✅

Successfully started a Firecrawl crawl job with these parameters:
- **Start URL**: https://docs.amplify.aws/nextjs/how-amplify-works/
- **Job ID**: `17e4d3c5-2e73-4437-aec5-c823b536d91f`
- **Max Depth**: 5 levels
- **Page Limit**: 100 pages
- **Strategy**: Avoid index page to prevent popup issues

## Current Status: In Progress ⏳

- **Status**: scraping
- **Progress**: 0/23 pages processed
- **Credits Used**: 23
- **Expires**: Tue Jul 29 2025 00:12:14 GMT+0200

## Key Differences from Test 1

1. **Starting Point**: Using `/how-amplify-works/` instead of index page
2. **Depth**: 5 levels deep (vs previous shallow crawl)
3. **No Popups**: Avoiding marketing/landing pages that trigger cookie consent
4. **Broader Coverage**: Should reach more technical documentation

## How to Monitor

Check the crawl status anytime with:
```
mcp__mcp-server-firecrawl__firecrawl_check_crawl_status(id="17e4d3c5-2e73-4437-aec5-c823b536d91f")
```

## Expected Outcome

This should successfully crawl deep into AWS Amplify Next.js documentation without the cookie consent issues that blocked our first attempt, giving us comprehensive coverage of:
- Backend building guides
- Authentication setup
- Data/API configuration  
- Storage implementation
- Serverless functions
- AI/ML integration
- Deployment processes

## Next Steps

Once crawl completes (status becomes "completed"), we'll extract and save all the markdown content to organized files in the test2 directory.