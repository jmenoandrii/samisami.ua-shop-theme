export function initColorVariantTooltip(prestashop: any, events: any) {
  const colorVariants = document.querySelectorAll('.color-variant');
  let tooltipTimeout: NodeJS.Timeout | null = null;
  let currentTooltip: HTMLElement | null = null;
  let lastVariant: Element | null = null;

  const showTooltip = (bgImage: string, text: string, anchor: HTMLElement): void => {
    if (currentTooltip) return;
    const tooltip = document.createElement('div');
    tooltip.className = 'color-variant-tooltip';
    const safeText = document.createElement('div');
    safeText.textContent = text;
    tooltip.innerHTML = `
      <div class="color-variant-tooltip__image" style='background-image: ${bgImage}'></div>
      <div class="color-variant-tooltip__text">${safeText.innerHTML}</div>
    `;
    tooltip.style.position = 'absolute';
    tooltip.style.zIndex = '10000';
    tooltip.style.visibility = 'hidden';
    document.body.appendChild(tooltip);
    currentTooltip = tooltip;

    // Позиціонуємо тултіп під або над елементом
    requestAnimationFrame(() => {
      const rect = anchor.getBoundingClientRect();
      const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
      const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;
      const tooltipRect = tooltip.getBoundingClientRect();

      // За замовчуванням – під елементом
      let top = rect.bottom + scrollTop + 8;
      let left = rect.left + scrollLeft;

      // Якщо тултіп виходить за межі вікна знизу — показуємо над елементом
      if (top + tooltipRect.height > window.innerHeight + scrollTop) {
        top = rect.top + scrollTop - tooltipRect.height - 8;
      }

      tooltip.style.left = `${left}px`;
      tooltip.style.top = `${top}px`;
      tooltip.style.visibility = 'visible';
    });
  };

  const hideTooltip = (): void => {
    if (currentTooltip) {
      currentTooltip.remove();
      currentTooltip = null;
    }
    if (tooltipTimeout) {
      clearTimeout(tooltipTimeout);
      tooltipTimeout = null;
    }
  };

  const handleMouseEnter = (variant: Element): void => {
    const colorElement = variant.querySelector('.color') as HTMLElement;
    const attributeName = variant.querySelector('.attribute-name') as HTMLElement;
    if (!colorElement || !attributeName) return;
    lastVariant = variant;
    tooltipTimeout = setTimeout(() => {
      if (lastVariant !== variant) return;
      try {
        const bgImage = window.getComputedStyle(colorElement).backgroundImage;
        const text = attributeName.textContent?.trim() || '';
        if (bgImage && bgImage !== 'none' && text) {
          showTooltip(bgImage, text, colorElement);
        }
      } catch (error) {
        console.warn('Error getting tooltip data:', error);
      }
    }, 1000);
  };

  const handleMouseLeave = (): void => {
    lastVariant = null;
    hideTooltip();
  };

  colorVariants.forEach((variant: Element) => {
    variant.addEventListener('mouseenter', () => handleMouseEnter(variant));
    variant.addEventListener('mouseleave', handleMouseLeave);
  });

  return () => {
    hideTooltip();
    colorVariants.forEach((variant: Element) => {
      variant.removeEventListener('mouseenter', () => handleMouseEnter(variant));
      variant.removeEventListener('mouseleave', handleMouseLeave);
    });
  };
}