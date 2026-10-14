/**
 * BizHack AI - Interactive & Performance Scripts
 * Lightweight, zero-dependency, Core Web Vitals friendly
 */

document.addEventListener('DOMContentLoaded', () => {
  // 1. 読了プログレスバー
  const progressBar = document.getElementById('read-progress');
  if (progressBar) {
    window.addEventListener('scroll', () => {
      const totalHeight = document.documentElement.scrollHeight - window.innerHeight;
      if (totalHeight > 0) {
        const progress = (window.scrollY / totalHeight) * 100;
        progressBar.style.width = `${Math.min(100, Math.max(0, progress))}%`;
      }
    }, { passive: true });
  }

  // 2. コピペボタンのイベントリスナー
  const copyButtons = document.querySelectorAll('.copy-btn');
  copyButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const targetId = btn.getAttribute('data-target');
      let textToCopy = '';

      if (targetId) {
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
          textToCopy = targetElement.innerText || targetElement.textContent;
        }
      } else {
        const codeBlock = btn.closest('.code-box')?.querySelector('.code-content pre');
        if (codeBlock) {
          textToCopy = codeBlock.innerText || codeBlock.textContent;
        }
      }

      if (textToCopy) {
        navigator.clipboard.writeText(textToCopy.trim()).then(() => {
          const originalText = btn.innerHTML;
          btn.innerHTML = '✓ コピー完了！';
          btn.style.backgroundColor = '#059669';

          setTimeout(() => {
            btn.innerHTML = originalText;
            btn.style.backgroundColor = '';
          }, 2000);
        }).catch(err => {
          console.error('コピー失敗:', err);
        });
      }
    });
  });

  // 3. 自動目次（TOC）のアクティブ追従ハイライト
  const tocLinks = document.querySelectorAll('.toc-list a');
  if (tocLinks.length > 0) {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const id = entry.target.getAttribute('id');
          tocLinks.forEach(link => {
            if (link.getAttribute('href') === `#${id}`) {
              link.style.fontWeight = '700';
              link.style.color = '#2563eb';
            } else {
              link.style.fontWeight = '';
              link.style.color = '';
            }
          });
        }
      });
    }, { rootMargin: '0px 0px -70% 0px' });

    document.querySelectorAll('.article-content h2, .article-content h3').forEach(heading => {
      if (heading.id) {
        observer.observe(heading);
      }
    });
  }
});
