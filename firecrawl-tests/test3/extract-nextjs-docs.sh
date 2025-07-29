#!/bin/bash

# Extract Next.js documentation from AWS Amplify docs repository
# This script copies all MDX files and organizes them in a clean structure

echo "🚀 Extracting Next.js Documentation from AWS Amplify Docs Repository"
echo "=================================================================="

# Create output directory
OUTPUT_DIR="nextjs-docs-extracted"
mkdir -p "$OUTPUT_DIR"

echo "📁 Created output directory: $OUTPUT_DIR"

# Copy all MDX files from the platform pages
echo "📄 Copying MDX documentation files..."
cp -r docs/src/pages/\[platform\]/* "$OUTPUT_DIR/"

# Create an index of all files
echo "📋 Creating documentation index..."
find "$OUTPUT_DIR" -name "*.mdx" | sort > "$OUTPUT_DIR/all-docs-index.txt"

# Count files
TOTAL_FILES=$(find "$OUTPUT_DIR" -name "*.mdx" | wc -l)
echo "✅ Extracted $TOTAL_FILES MDX documentation files"

# Create README
cat > "$OUTPUT_DIR/README.md" << 'EOF'
# AWS Amplify Next.js Documentation - Source Files

This directory contains the complete AWS Amplify documentation source files in MDX format, extracted directly from the official repository.

## What's Included

- All platform-agnostic documentation (works for Next.js, React, etc.)
- Complete source files with frontmatter and metadata
- Original directory structure preserved
- 883+ documentation files

## Key Sections

- `start/` - Getting started guides
- `build-a-backend/` - Backend development guides
- `build-ui/` - UI component guides  
- `ai/` - AI and ML integration
- `deploy-and-host/` - Deployment guides
- `reference/` - API reference documentation
- `how-amplify-works/` - Core concepts

## File Format

Files are in MDX format (Markdown + JSX), which includes:
- Frontmatter with metadata
- React components
- Code examples
- Interactive elements

## Usage

These files can be:
1. Read directly as markdown
2. Processed by MDX parsers
3. Converted to other formats
4. Used as source for custom documentation sites

## Advantages over Web Scraping

✅ No cookie consent issues
✅ Complete content including metadata
✅ Source code examples intact
✅ All internal links and references
✅ Faster than web scraping
✅ Always up-to-date with repository
EOF

echo "📊 Documentation extraction complete!"
echo ""
echo "📍 Location: $OUTPUT_DIR"
echo "📈 Total files: $TOTAL_FILES"
echo "📖 See $OUTPUT_DIR/README.md for more information"
echo "📝 Full file list: $OUTPUT_DIR/all-docs-index.txt"