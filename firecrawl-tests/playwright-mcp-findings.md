# Playwright MCP AWS Docs Scraping Results

## Summary

Successfully used Playwright MCP to navigate AWS Amplify documentation, but encountered some challenges:

### What Worked
1. ✅ Successfully navigated to AWS Amplify docs
2. ✅ Page loaded without cookie consent blocking (unlike Firecrawl)
3. ✅ Could take screenshots and see the content
4. ✅ Navigation between pages worked

### Challenges Encountered
1. **Response Size Limitation**: Playwright MCP responses exceed the 25,000 token limit when trying to:
   - Get page snapshots (`browser_snapshot`)
   - Execute JavaScript to extract content (`browser_evaluate`)
   - Navigate to pages with lots of content

2. **Popup Handling**: The Amplify Gen 2 announcement popup appeared but wasn't blocking content access

### Alternative Solutions

Since direct content extraction via Playwright MCP hits token limits, here are working alternatives:

#### 1. Use Playwright with Node.js Script
Created `playwright-scraper.js` that:
- Handles cookie consent automatically
- Navigates through multiple pages
- Extracts and saves content to markdown files
- Creates an organized directory structure

Run with:
```bash
npm install playwright
node firecrawl-tests/playwright-scraper.js
```

#### 2. Use Firecrawl Search Instead of Crawl
Since crawling is blocked by cookies, use targeted searches:
```python
mcp__mcp-server-firecrawl__firecrawl_search(
    query="AWS Amplify Next.js authentication guide",
    limit=5
)
```

#### 3. Clone Official Documentation
The most reliable approach:
```bash
git clone https://github.com/aws-amplify/docs
```

## Conclusion

While Playwright MCP can successfully navigate and interact with the AWS docs site, the token limit on responses makes it impractical for content extraction through the MCP interface. The provided Node.js script offers a complete solution for scraping the documentation using Playwright directly.