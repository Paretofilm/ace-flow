#!/bin/bash

# Complete extraction of AWS Amplify documentation
echo "🚀 Complete AWS Amplify Documentation Extraction"
echo "================================================"

# Create comprehensive output directory
OUTPUT_DIR="amplify-docs-complete"
rm -rf "$OUTPUT_DIR" 2>/dev/null
mkdir -p "$OUTPUT_DIR"

echo "📁 Created output directory: $OUTPUT_DIR"

# Copy platform pages (navigation structure)
echo "📄 Copying platform pages..."
cp -r docs/src/pages/\[platform\]/* "$OUTPUT_DIR/pages/"
mkdir -p "$OUTPUT_DIR/pages"
cp -r docs/src/pages/\[platform\]/* "$OUTPUT_DIR/pages/"

# Copy fragments (actual content)
echo "📄 Copying content fragments..."
mkdir -p "$OUTPUT_DIR/fragments"
cp -r docs/src/fragments/* "$OUTPUT_DIR/fragments/"

# Create indexes
echo "📋 Creating comprehensive index..."
find "$OUTPUT_DIR" -name "*.mdx" | sort > "$OUTPUT_DIR/complete-index.txt"

# Count everything
TOTAL_FILES=$(find "$OUTPUT_DIR" -name "*.mdx" | wc -l)
PAGE_FILES=$(find "$OUTPUT_DIR/pages" -name "*.mdx" | wc -l)
FRAGMENT_FILES=$(find "$OUTPUT_DIR/fragments" -name "*.mdx" | wc -l)

echo "✅ Extraction complete!"
echo "   Total MDX files: $TOTAL_FILES"
echo "   Page files: $PAGE_FILES" 
echo "   Fragment files: $FRAGMENT_FILES"

# Create comprehensive README
cat > "$OUTPUT_DIR/README.md" << EOF
# Complete AWS Amplify Documentation

This is the complete source documentation for AWS Amplify, extracted directly from the official repository.

## Structure

### pages/ (Navigation & Metadata)
- Contains Next.js page files with routing and metadata
- Defines navigation structure and page organization
- $PAGE_FILES files

### fragments/ (Actual Content)
- Contains the actual documentation content
- Reusable content blocks and platform-specific guides
- $FRAGMENT_FILES files

## Total: $TOTAL_FILES Documentation Files

## Key Content Areas

### Getting Started
- fragments/start/ - Setup and quickstart guides
- fragments/gen2/ - Amplify Gen 2 specific content

### Backend Development
- fragments/lib/ - Library and SDK documentation
- Authentication, APIs, Storage, Functions

### UI Development
- fragments/ui/ - UI component documentation
- Figma integration, form builders

### Platform-Specific
- Next.js specific guides and examples
- React, Vue, Angular variations

## Usage

### Finding Next.js Content
Look for files containing 'nextjs' in the path:
- fragments/gen2/quickstart/create-nextjs-*
- fragments/guides/hosting/nextjs.mdx
- fragments/lib/ssr/nextjs/

### Reading MDX Files
These files contain:
- Frontmatter with metadata
- Markdown content
- React/JSX components
- Code examples with syntax highlighting

## Advantages of Source Access

✅ Complete, unmodified content
✅ All code examples intact
✅ Metadata and navigation structure
✅ Latest updates from repository
✅ No rate limiting or scraping issues
✅ Fast local access to 2000+ files

## File Index
See complete-index.txt for full file listing.
EOF

echo "📖 Created comprehensive README.md"
echo "📍 All files located in: $OUTPUT_DIR"
echo "📊 See $OUTPUT_DIR/complete-index.txt for complete file listing"