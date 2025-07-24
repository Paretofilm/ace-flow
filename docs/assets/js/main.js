// ACE-Flow Documentation JavaScript

document.addEventListener('DOMContentLoaded', function() {
  // Smooth scrolling for anchor links
  const links = document.querySelectorAll('a[href^="#"]');
  links.forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Add fade-in animation to feature cards
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver(function(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('fade-in-up');
      }
    });
  }, observerOptions);

  // Observe feature cards and other elements
  const animateElements = document.querySelectorAll('.feature-card, .hero-content');
  animateElements.forEach(el => observer.observe(el));

  // Mobile documentation navigation
  const mobileNavToggle = document.querySelector('.mobile-nav-toggle');
  const mobileNavClose = document.querySelector('.mobile-nav-close');
  const mobileNavBackdrop = document.querySelector('.mobile-nav-backdrop');
  const docsSidebar = document.querySelector('.docs-sidebar');
  const docsLayout = document.querySelector('.docs-layout');
  
  function openMobileNav() {
    if (docsSidebar) docsSidebar.classList.add('mobile-nav-open');
    if (mobileNavBackdrop) mobileNavBackdrop.classList.add('mobile-nav-open');
    document.body.style.overflow = 'hidden';
  }
  
  function closeMobileNav() {
    if (docsSidebar) docsSidebar.classList.remove('mobile-nav-open');
    if (mobileNavBackdrop) mobileNavBackdrop.classList.remove('mobile-nav-open');
    document.body.style.overflow = '';
  }
  
  if (mobileNavToggle && docsSidebar) {
    mobileNavToggle.addEventListener('click', openMobileNav);
  }
  
  if (mobileNavClose) {
    mobileNavClose.addEventListener('click', closeMobileNav);
  }
  
  // Close mobile nav when clicking backdrop
  if (mobileNavBackdrop) {
    mobileNavBackdrop.addEventListener('click', closeMobileNav);
  }
  
  // Close mobile nav when clicking outside or on navigation links
  if (docsSidebar) {
    // Close mobile nav when clicking on content area
    if (docsLayout) {
      docsLayout.addEventListener('click', function(e) {
        if (e.target === docsLayout || !docsSidebar.contains(e.target)) {
          closeMobileNav();
        }
      });
    }
    
    // Close mobile nav when clicking on a navigation link
    const navLinks = docsSidebar.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
      link.addEventListener('click', closeMobileNav);
    });
    
    // Close mobile nav on escape key
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape' && docsSidebar.classList.contains('mobile-nav-open')) {
        closeMobileNav();
      }
    });
  }

  // Header mobile menu toggle (existing functionality)
  const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
  const siteNav = document.querySelector('.site-nav');
  
  if (mobileMenuToggle && siteNav) {
    mobileMenuToggle.addEventListener('click', function() {
      siteNav.classList.toggle('active');
    });
  }

  // Copy code button functionality
  const codeBlocks = document.querySelectorAll('pre code');
  codeBlocks.forEach(codeBlock => {
    const copyButton = document.createElement('button');
    copyButton.textContent = 'Copy';
    copyButton.classList.add('copy-button');

    const pre = codeBlock.parentElement;
    pre.style.position = 'relative';
    pre.appendChild(copyButton);

    pre.addEventListener('mouseenter', () => {
      copyButton.style.opacity = '1';
    });

    pre.addEventListener('mouseleave', () => {
      copyButton.style.opacity = '0';
    });

    copyButton.addEventListener('click', async () => {
      try {
        await navigator.clipboard.writeText(codeBlock.textContent);
        copyButton.textContent = 'Copied!';
        setTimeout(() => {
          copyButton.textContent = 'Copy';
        }, 2000);
      } catch (err) {
        console.error('Failed to copy code: ', err);
      }
    });
  });

  // Add active class to current page in sidebar
  const currentPath = window.location.pathname;
  const sidebarLinks = document.querySelectorAll('.nav-link');
  sidebarLinks.forEach(link => {
    if (link.getAttribute('href') === currentPath || 
        (currentPath.includes(link.getAttribute('href')) && link.getAttribute('href') !== '/')) {
      link.classList.add('active');
    }
  });

  // Table of contents generation for documentation pages
  const tocContainer = document.querySelector('.table-of-contents');
  if (tocContainer) {
    const headings = document.querySelectorAll('.docs-content h2, .docs-content h3');
    if (headings.length > 0) {
      const tocList = document.createElement('ul');
      tocList.classList.add('toc-list');

      headings.forEach((heading, index) => {
        const id = heading.id || `heading-${index}`;
        heading.id = id;

        const listItem = document.createElement('li');
        const link = document.createElement('a');
        link.href = `#${id}`;
        link.textContent = heading.textContent;
        link.classList.add('toc-link');
        
        if (heading.tagName === 'H3') {
          listItem.classList.add('toc-subitem');
        }

        listItem.appendChild(link);
        tocList.appendChild(listItem);
      });

      tocContainer.appendChild(tocList);
    }
  }
});

// Add some utility functions
window.ACEFlow = {
  // Scroll to top function
  scrollToTop: function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  },

  // Toggle theme (for future dark/light mode toggle)
  toggleTheme: function() {
    document.body.classList.toggle('light-theme');
    localStorage.setItem('theme', document.body.classList.contains('light-theme') ? 'light' : 'dark');
  },

  // Initialize theme from localStorage
  initTheme: function() {
    const savedTheme = localStorage.getItem('theme');
    if (savedTheme === 'light') {
      document.body.classList.add('light-theme');
    }
  }
};

// Initialize theme on load
window.ACEFlow.initTheme();