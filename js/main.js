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

  // 6. 動的サイドバー生成（案A × 案B ハイブリッド方式）
  // window.BIZHACK_ARTICLES マスターから「最新5選 ＋ 現在閲覧中ハイライト ＋ 全記事一覧導線」を自動描画
  const sidebarContainer = document.getElementById('sidebar-latest-articles') || document.querySelector('.sidebar-card[data-dynamic="articles"]');
  if (sidebarContainer && Array.isArray(window.BIZHACK_ARTICLES) && window.BIZHACK_ARTICLES.length > 0) {
    const articles = window.BIZHACK_ARTICLES;
    const currentPath = window.location.pathname;
    const currentFileMatch = currentPath.match(/article-(\d+)\.html/);
    const currentId = currentFileMatch ? parseInt(currentFileMatch[1], 10) : null;

    const totalCount = articles.length;
    const top5 = articles.slice(0, 5);
    const isInTop5 = currentId ? top5.some(a => a.id === currentId) : false;

    let itemsHtml = '';
    top5.forEach(art => {
      const isCurrent = (art.id === currentId);
      if (isCurrent) {
        itemsHtml += `
          <div class="recent-article-item is-current">
            <div class="item-meta">
              <span>第${art.id}弾（閲覧中）</span>
              ${art.isNew ? '<span class="sidebar-badge-new">NEW</span>' : ''}
            </div>
            <a href="${art.url}">${art.title}</a>
          </div>`;
      } else {
        itemsHtml += `
          <div class="recent-article-item">
            <div class="item-meta">
              <span>第${art.id}弾</span>
              ${art.isNew ? '<span class="sidebar-badge-new">NEW</span>' : ''}
              <span>${art.date ? '・' + art.date : ''}</span>
            </div>
            <a href="${art.url}">${art.title}</a>
          </div>`;
      }
    });

    // もし現在閲覧中の記事がトップ5圏外（過去記事）の場合、セパレーターを挟んで現在記事を表示
    if (currentId && !isInTop5) {
      const currentArt = articles.find(a => a.id === currentId);
      if (currentArt) {
        itemsHtml += `
          <div class="sidebar-divider" style="display:flex; align-items:center; gap:0.5rem; margin:0.6rem 0; font-size:0.72rem; color:var(--text-muted, #94a3b8);">
            <span style="flex:1; border-top:1px dashed var(--border-color, #cbd5e1);"></span>
            <span>現在閲覧中の記事</span>
            <span style="flex:1; border-top:1px dashed var(--border-color, #cbd5e1);"></span>
          </div>
          <div class="recent-article-item is-current">
            <div class="item-meta">
              <span>第${currentArt.id}弾（閲覧中）</span>
            </div>
            <a href="${currentArt.url}">${currentArt.title}</a>
          </div>`;
      }
    }

    sidebarContainer.innerHTML = `
      <div class="sidebar-title">
        <span>最新おすすめ記事</span>
        <span style="font-size:0.75rem; color:var(--text-muted, #64748b); font-weight:normal;">全${totalCount}弾</span>
      </div>
      <div class="sidebar-articles-list">
        ${itemsHtml}
      </div>
      <div class="sidebar-cta-wrap" style="margin-top:0.85rem; padding-top:0.75rem; border-top:1px dashed var(--border-color, #e2e8f0);">
        <a href="index.html#featured" class="sidebar-all-articles-btn">
          全${totalCount}弾の実践特集一覧を見る →
        </a>
      </div>
    `;
  }
});

