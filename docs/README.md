# ACE-Flow Documentation Site

This folder contains the GitHub Pages documentation for ACE-Flow.

## Structure

- `index.md` - Homepage
- `getting-started.md` - Quick start guide
- `examples.md` - Usage examples
- `patterns/` - Architecture pattern documentation
- `api/` - API reference documentation
- `advanced/` - Advanced topics and troubleshooting
- `_config.yml` - Jekyll configuration

## GitHub Pages Setup

To enable GitHub Pages for this repository:

1. Go to repository Settings → Pages
2. Set Source to "Deploy from a branch"
3. Select branch: `main` 
4. Set folder to `/docs`
5. Click Save

The documentation will be available at:
`https://paretofilm.github.io/ace-flow/`

## System Documentation

The actual ACE-Flow system documentation is located in the `ace-system/` folder (renamed from `docs/` to avoid conflicts with GitHub Pages).

## Local Development

```bash
# Install Jekyll (if not already installed)
gem install bundler jekyll

# Create Gemfile
echo 'source "https://rubygems.org"' > docs/Gemfile
echo 'gem "github-pages", group: :jekyll_plugins' >> docs/Gemfile

# Install dependencies
cd docs && bundle install

# Serve locally
bundle exec jekyll serve

# Visit http://localhost:4000
```