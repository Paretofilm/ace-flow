# Firecrawl MCP Testing

## Overview

This directory contains tests and examples for using the Firecrawl MCP server to scrape documentation.

## Crawl Job Information

- **Job ID**: `87fdbe80-885e-4ed6-a0e7-bf760f0447dc`
- **Target URL**: https://docs.amplify.aws/nextjs/
- **Limit**: 100 pages
- **Max Depth**: 5
- **Status**: In Progress

## How to Check Crawl Status

Use the MCP tool directly in Claude:
```
mcp__mcp-server-firecrawl__firecrawl_check_crawl_status(id="87fdbe80-885e-4ed6-a0e7-bf760f0447dc")
```

## Expected Results

When the crawl completes, you'll receive:
- An array of scraped pages
- Each page contains:
  - `url`: The page URL
  - `markdown`: The content in markdown format
  - `metadata`: Title, description, and other metadata

## Processing Results

Once the crawl completes with status "completed", the results can be:
1. Saved to individual markdown files
2. Organized by URL structure
3. Indexed for easy navigation

## Alternative Approach

If the crawl takes too long or fails, you can:
1. Use `firecrawl_map` to get a list of URLs
2. Scrape individual pages with `firecrawl_scrape`
3. Use `firecrawl_search` to find specific content

## Notes

- The AWS Amplify docs might have rate limiting or anti-scraping measures
- Large crawls can take several minutes
- Each page scraped uses credits from your Firecrawl account