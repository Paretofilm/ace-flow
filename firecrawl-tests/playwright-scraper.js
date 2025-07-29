// Playwright script to scrape AWS Amplify docs with cookie handling
const { chromium } = require('playwright');
const fs = require('fs').promises;
const path = require('path');

async function scrapeAmplifyDocs() {
  const browser = await chromium.launch({ headless: false });
  const context = await browser.newContext();
  const page = await context.newPage();
  
  console.log('Navigating to AWS Amplify docs...');
  await page.goto('https://docs.amplify.aws/nextjs/', { waitUntil: 'networkidle' });
  
  // Wait for page to load
  await page.waitForTimeout(3000);
  
  // Handle cookie consent if present
  try {
    // Look for cookie consent button
    const cookieButton = await page.$('button:has-text("Accept"), button:has-text("Accept all"), button:has-text("Accept cookies")');
    if (cookieButton) {
      console.log('Found cookie consent, accepting...');
      await cookieButton.click();
      await page.waitForTimeout(2000);
    }
  } catch (e) {
    console.log('No cookie consent found or already accepted');
  }
  
  // Close any popups
  try {
    await page.keyboard.press('Escape');
    await page.waitForTimeout(1000);
  } catch (e) {
    console.log('No popups to close');
  }
  
  // Get list of documentation links
  console.log('Extracting documentation links...');
  const links = await page.evaluate(() => {
    const linkElements = document.querySelectorAll('a[href*="/nextjs/"]');
    return Array.from(linkElements)
      .map(a => ({
        url: a.href,
        text: a.textContent.trim()
      }))
      .filter(link => link.url.includes('docs.amplify.aws/nextjs/'))
      .slice(0, 10); // Limit to first 10 for demo
  });
  
  console.log(`Found ${links.length} documentation links`);
  
  // Create output directory
  const outputDir = path.join(__dirname, 'amplify-docs-scraped');
  await fs.mkdir(outputDir, { recursive: true });
  
  // Scrape each page
  for (let i = 0; i < links.length; i++) {
    const link = links[i];
    console.log(`\nScraping ${i + 1}/${links.length}: ${link.text}`);
    
    try {
      await page.goto(link.url, { waitUntil: 'networkidle' });
      await page.waitForTimeout(2000);
      
      // Extract content
      const content = await page.evaluate(() => {
        const main = document.querySelector('main') || document.querySelector('[role="main"]');
        const title = document.title;
        const h1 = document.querySelector('h1')?.textContent || '';
        const text = main ? main.innerText : document.body.innerText;
        
        return {
          title,
          h1,
          content: text,
          url: window.location.href
        };
      });
      
      // Save to file
      const filename = `page-${i + 1}-${link.text.replace(/[^a-z0-9]/gi, '-').toLowerCase()}.md`;
      const filepath = path.join(outputDir, filename);
      
      const markdown = `# ${content.h1 || content.title}

**URL**: ${content.url}
**Scraped**: ${new Date().toISOString()}

---

${content.content}
`;
      
      await fs.writeFile(filepath, markdown, 'utf-8');
      console.log(`  ✓ Saved to ${filename}`);
      
    } catch (error) {
      console.error(`  ✗ Error scraping ${link.url}:`, error.message);
    }
  }
  
  // Create index file
  const indexContent = `# AWS Amplify Next.js Documentation - Scraped Content

Generated: ${new Date().toISOString()}

## Pages Scraped

${links.map((link, i) => `${i + 1}. [${link.text}](page-${i + 1}-${link.text.replace(/[^a-z0-9]/gi, '-').toLowerCase()}.md)`).join('\n')}
`;
  
  await fs.writeFile(path.join(outputDir, 'README.md'), indexContent, 'utf-8');
  console.log('\n✓ Created index file');
  
  await browser.close();
  console.log('\nScraping complete!');
}

// Run the scraper
scrapeAmplifyDocs().catch(console.error);