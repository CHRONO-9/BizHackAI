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

  // 2. コピペボタンのイベントリスナー（＋GA4 prompt_copy イベント計測）
  const copyButtons = document.querySelectorAll('.copy-btn, .fv-copy-btn, [data-copy-target]');
  copyButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const rawTarget = btn.getAttribute('data-target') || btn.getAttribute('data-copy-target') || '';
      const targetId = rawTarget.replace(/^#/, '');
      let textToCopy = '';

      if (targetId) {
        const targetElement = document.getElementById(targetId);
        if (targetElement) {
          textToCopy = targetElement.innerText || targetElement.textContent;
        }
      } else {
        const codeBlock = btn.closest('.code-box, .prompt-box, .fv-try-box, .fv-instant-tool')?.querySelector('pre');
        if (codeBlock) {
          textToCopy = codeBlock.innerText || codeBlock.textContent;
        }
      }

      if (textToCopy) {
        navigator.clipboard.writeText(textToCopy.trim()).then(() => {
          const originalText = btn.innerHTML;
          btn.innerHTML = '✓ コピー完了！';
          btn.style.backgroundColor = '#059669';

          // GA4 カスタムイベント送信: prompt_copy
          if (typeof gtag === 'function') {
            const promptTitle =
              btn.closest('.code-box')?.querySelector('.code-title')?.textContent?.trim() ||
              btn.closest('.prompt-box')?.querySelector('.prompt-title')?.textContent?.trim() ||
              btn.closest('.fv-try-box')?.querySelector('.fv-try-title')?.textContent?.trim() ||
              btn.closest('.fv-instant-tool')?.querySelector('.fv-tool-label span')?.textContent?.trim() ||
              targetId ||
              'prompt';
            gtag('event', 'prompt_copy', {
              article_path: window.location.pathname,
              article_title: document.title,
              prompt_id: targetId || 'inline',
              prompt_title: promptTitle
            });
          }

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

    document.querySelectorAll('.article-content h2, .article-content h3, article h2, article h3').forEach(heading => {
      if (heading.id) {
        observer.observe(heading);
      }
    });
  }

  // 4. カテゴリー別クイック絞り込みタブ（案A 試作UI）
  const filterTabs = document.querySelectorAll('.filter-tab');
  const articleCards = document.querySelectorAll('.articles-grid .article-card');
  const filterHint = document.getElementById('filter-hint');

  if (filterTabs.length > 0 && articleCards.length > 0) {
    const hintMessages = {
      all: '※お探しの業務領域・職種に合わせて瞬時に切り替えられます（全12弾を表示中）',
      routine: '事務・日常実務向け（メール・議事録・エクセル・PDF要約・請求書仕訳・スプシ＆Gmail自動化など 8本）を表示中',
      creative: '企画・クリエイティブ・副業向け（パワポ構成案・Canva画像・Notion一人起業など 3本）を表示中',
      governance: '組織導入・セキュリティ向け（情報漏洩対策・上司への社内提案メモ 1本）を表示中'
    };

    filterTabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const targetFilter = tab.getAttribute('data-filter');

        // タブのアクティブ切り替え
        filterTabs.forEach(t => t.classList.remove('active'));
        tab.classList.add('active');

        // ヒント文の更新
        if (filterHint && hintMessages[targetFilter]) {
          filterHint.textContent = hintMessages[targetFilter];
        }

        // 記事カードの表示/非表示およびアニメーション
        articleCards.forEach(card => {
          const category = card.getAttribute('data-category');
          card.classList.remove('is-animating');

          if (targetFilter === 'all' || category === targetFilter) {
            card.classList.remove('is-hidden');
            // 次のフレームでアニメーションクラスを再付与
            requestAnimationFrame(() => {
              card.classList.add('is-animating');
            });
          } else {
            card.classList.add('is-hidden');
          }
        });
      });
    });
  }

  // 5. GA4 カスタムイベント計測: アフィリエイト広告クリック (affiliate_click) & 関連記事回遊 (internal_circulation_click)
  const affiliateLinks = document.querySelectorAll('a[rel*="nofollow"]');
  affiliateLinks.forEach(link => {
    link.addEventListener('click', () => {
      if (typeof gtag === 'function') {
        const imgAlt = link.querySelector('img')?.getAttribute('alt') || '';
        const label = (link.textContent || imgAlt || link.href).trim().replace(/\s+/g, ' ').slice(0, 100);
        const placement = link.closest('.article-sidebar') ? 'sidebar' : 'in_article';
        gtag('event', 'affiliate_click', {
          article_path: window.location.pathname,
          article_title: document.title,
          link_url: link.href,
          link_label: label,
          placement: placement
        });
      }
    });
  });

  const relatedLinks = document.querySelectorAll('.related-article-card, .quick-start-link, .step-up-link, .fv-quick-btn');
  relatedLinks.forEach(link => {
    link.addEventListener('click', () => {
      if (typeof gtag === 'function') {
        let component = 'related_articles_box';
        if (link.classList.contains('quick-start-link')) component = 'quick_start_banner';
        else if (link.classList.contains('step-up-link')) component = 'in_article_step_up';
        else if (link.classList.contains('fv-quick-btn')) component = 'fv_quick_jump';
        gtag('event', 'internal_circulation_click', {
          from_path: window.location.pathname,
          to_url: link.getAttribute('href') || '',
          component: component
        });
      }
    });
  });
});

