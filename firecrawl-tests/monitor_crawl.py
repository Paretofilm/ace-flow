#!/usr/bin/env python3
"""
Monitor Firecrawl crawl job status
Run this script to check the status of your crawl job
"""

CRAWL_JOB_ID = "87fdbe80-885e-4ed6-a0e7-bf760f0447dc"

print(f"""
AWS Amplify Documentation Crawl Monitor
======================================

Crawl Job ID: {CRAWL_JOB_ID}

To check the status of your crawl job, use this MCP command:

    mcp__mcp-server-firecrawl__firecrawl_check_crawl_status(id="{CRAWL_JOB_ID}")

The crawl job will scrape up to 100 pages from docs.amplify.aws/nextjs/

Once completed, the status will show:
- Status: completed
- Total pages scraped
- Credits used

After completion, you can process the results using the process_crawl_results.py script.

Current possible statuses:
- scraping: The crawl is in progress
- completed: The crawl has finished successfully
- failed: The crawl encountered an error

Note: Large crawl jobs can take several minutes to complete.
""")