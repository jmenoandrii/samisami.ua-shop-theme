/**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SelectorsMap from './constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export default () => {
  const {prestashop, Theme: {events}} = window;

  const initProductSlide = () => {
    document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  };

  function onProductSlide(event: ProductSlideEvent): void {
    document.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
    document.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
  }

  initProductSlide();
  prestashop.on(events.updatedProduct, initProductSlide);
  prestashop.on(events.quickviewOpened, initProductSlide);

  // Ініціалізація кольорових варіантів
  const initColorVariants = () => {
    const colorVariants = document.querySelectorAll('.color-variant');

    colorVariants.forEach((variant: Element) => {
      const colorElement = variant.querySelector('.color') as HTMLElement;
      
      if (colorElement) {
        updateColorVariantClass(variant, colorElement);
      }
    });

    // Оновлюємо при змінені варіантів
    const variantInputs = document.querySelectorAll('.input-color');
    variantInputs.forEach((input: Element) => {
      input.addEventListener('change', (event: Event) => {
        const variant = (event.target as HTMLElement).closest('.color-variant') as Element;
        const colorElement = variant?.querySelector('.color') as HTMLElement;
        
        if (colorElement) {
          updateColorVariantClass(variant, colorElement);
        }
      });
    });
  };

  /**
   * Оновлює клас color-white залежно від кольору
   */
  function updateColorVariantClass(variant: Element, colorElement: HTMLElement): void {
    const bgColor = window.getComputedStyle(colorElement).backgroundColor;
    const isWhite = isWhiteColor(bgColor);
    
    if (isWhite) {
      variant.classList.add('color-white');
    } else {
      variant.classList.remove('color-white');
    }
  }

  /**
   * Перевіряє чи колір є білим або близьким до нього
   */
  function isWhiteColor(bgColor: string): boolean {
    const rgbMatch = bgColor.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\)/);
    
    if (rgbMatch) {
      const r = parseInt(rgbMatch[1], 10);
      const g = parseInt(rgbMatch[2], 10);
      const b = parseInt(rgbMatch[3], 10);
      
      // Вважаємо білим якщо RGB > 240
      return r > 240 && g > 240 && b > 240;
    }
    
    const colorLower = bgColor.toLowerCase();
    return colorLower.includes('white') || 
           colorLower.includes('#fff') ||
           colorLower.includes('rgb(255');
  }

  // Ініціалізуємо кольорові варіанти при завантаженні
  initColorVariants();
  
  // Переініціалізуємо при оновленні товару
  prestashop.on(events.updatedProduct, initColorVariants);
  prestashop.on(events.quickviewOpened, initColorVariants);

  function detectQuantityChange() {
    const quantityInput = document.querySelector(
      SelectorsMap.qtyInput.quantityWanted,
    ) as HTMLInputElement;
    const incrementButton = document.querySelector(
      SelectorsMap.qtyInput.increment,
    ) as HTMLButtonElement;
    const decrementButton = document.querySelector(
      SelectorsMap.qtyInput.decrement,
    ) as HTMLButtonElement;

    if (quantityInput && incrementButton && decrementButton) {
      // Function to trigger emit
      const triggerEmit = () => {
        const inputValue = parseInt(quantityInput.value, 10);
        const minValue = parseInt(quantityInput.min, 10);

        // Check if the input value is a valid and greater or equal than the minimum value
        if (!isNaN(inputValue) && inputValue >= minValue) {
          quantityInput.value = inputValue.toString();
        } else {
          quantityInput.value = minValue.toString();
        }

        prestashop.emit('updateProduct', {
          eventType: 'updatedProductQuantity',
        });
      };

      // Attach event listener for input changes
      quantityInput.addEventListener('change', triggerEmit);

      // Attach event listener for increment / decrement button click
      incrementButton.addEventListener('click', triggerEmit);
      decrementButton.addEventListener('click', triggerEmit);
    }
  }

  // Call the function to start listening for quantity changes
  detectQuantityChange();

  // Ініціалізація табів продукту
  const initProductTabs = () => {
    const tabsContainer = document.querySelector('.product-tabs');
    
    if (!tabsContainer) return;

    const tabLinks = tabsContainer.querySelectorAll('.product-tabs__link');
    const tabContents = document.querySelectorAll('.product-tabs__content');
    const tabClose = document.querySelectorAll('.product-tabs__close');

    // Активуємо перший таб при завантаженні
    const firstTabLink = tabsContainer.querySelector('.product-tabs__item:first-child .product-tabs__link') as HTMLElement;
    if (firstTabLink) {
      firstTabLink.classList.add('active');
      const firstTabId = firstTabLink.getAttribute('data-id');
      if (firstTabId) {
        const firstContent = document.getElementById(firstTabId);
        if (firstContent) {
          firstContent.classList.remove('hide');
        }
      }
    }

    // Приховуємо всі інші таби крім першого
    tabContents.forEach((content: Element) => {
      const contentId = content.getAttribute('id');
      const isActive = firstTabLink && firstTabLink.getAttribute('data-id') === contentId;
      if (!isActive) {
        content.classList.add('hide');
      }
    });

    tabClose.forEach((el: Element) => {
      el.addEventListener('click', (event: Event) => {
        event.preventDefault();
        
        tabLinks.forEach((tab: Element) => {
          tab.classList.remove('active');
        });
        tabContents.forEach((content: Element) => {
          content.classList.add('hide');
        });

        el.classList.add('hide');
      })
    });

    // Обробляємо клік по табам
    tabLinks.forEach((link: Element) => {
      link.addEventListener('click', (event: Event) => {
        event.preventDefault();

        const clickedLink = event.target as HTMLElement;
        const tabId = clickedLink.getAttribute('data-id');

        // Видаляємо клас active з усіх табів
        tabLinks.forEach((tab: Element) => {
          tab.classList.remove('active');
        });

        tabClose.forEach((el: Element) => {
          el.classList.remove('hide');
        });

        // Додаємо клас active на натиснутий таб
        clickedLink.classList.add('active');

        // Приховуємо всі блоки контенту
        tabContents.forEach((content: Element) => {
          content.classList.add('hide');
        });

        // Показуємо відповідний блок контенту
        if (tabId) {
          const activeContent = document.getElementById(tabId);
          if (activeContent) {
            activeContent.classList.remove('hide');
          }
        }
      });
    });
  };

  // Ініціалізуємо таби при завантаженні
  initProductTabs();
  
  // Переініціалізуємо таби при оновленні товару
  prestashop.on(events.updatedProduct, initProductTabs);
  prestashop.on(events.quickviewOpened, initProductTabs);

  // Ініціалізація текстурної модалки
  const initColorVariantTooltip = () => {
    const colorVariants = document.querySelectorAll('.color-variant');
    let tooltipTimeout: NodeJS.Timeout | null = null;
    let currentTooltip: HTMLElement | null = null;
    let lastVariant: Element | null = null;
    let lastMouseX = 0;
    let lastMouseY = 0;

    const showTooltip = (bgImage: string, text: string): void => {
      // Не створюємо новий tooltip якщо він вже існує з тією ж інформацією
      if (currentTooltip) {
        return;
      }

      const tooltip = document.createElement('div');
      tooltip.className = 'color-variant-tooltip';
      
      // Екрануємо текст від XSS
      const safeText = document.createElement('div');
      safeText.textContent = text;
      
      tooltip.innerHTML = `
        <div class="color-variant-tooltip__image" style='background-image: ${bgImage}'></div>
        <div class="color-variant-tooltip__text">${safeText.innerHTML}</div>
      `;

      // Встановлюємо стилі до додавання до DOM
      tooltip.style.position = 'fixed';
      tooltip.style.zIndex = '10000';
      tooltip.style.visibility = 'hidden';

      document.body.appendChild(tooltip);
      currentTooltip = tooltip;

      // Розраховуємо позицію з поточною позицією мишки
      requestAnimationFrame(() => {
        positionTooltip(lastMouseX, lastMouseY);
        tooltip.style.visibility = 'visible';
      });
    };

    const positionTooltip = (clientX: number, clientY: number): void => {
      if (!currentTooltip) return;

      const offsetX = -150;
      const offsetY = -180;
      let x = clientX + offsetX;
      let y = clientY + offsetY;

      // Перевіряємо щоб модалка не вийшла за межи вікна
      const tooltipRect = currentTooltip.getBoundingClientRect();
      
      if (x + tooltipRect.width > window.innerWidth) {
        x = clientX + 15;
      }
      
      if (y < 0) {
        y = clientY + 15;
      }

      currentTooltip.style.left = `${x}px`;
      currentTooltip.style.top = `${y}px`;
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

    const handleMouseEnter = (variant: Element, event: Event): void => {
      const colorElement = variant.querySelector('.color') as HTMLElement;
      const attributeName = variant.querySelector('.attribute-name') as HTMLElement;
      const mouseEvent = event as MouseEvent;

      if (!colorElement || !attributeName) return;

      lastVariant = variant;
      lastMouseX = mouseEvent.clientX;
      lastMouseY = mouseEvent.clientY;

      tooltipTimeout = setTimeout(() => {
        // Перевіряємо чи мишка ще на цьому елементі
        if (lastVariant !== variant) return;

        try {
          const bgImage = window.getComputedStyle(colorElement).backgroundImage;
          const text = attributeName.textContent?.trim() || '';

          if (bgImage && bgImage !== 'none' && text) {
            showTooltip(bgImage, text);
          }
        } catch (error) {
          console.warn('Error getting tooltip data:', error);
        }
      }, 600);
    };

    const handleMouseLeave = (): void => {
      lastVariant = null;
      hideTooltip();
    };

    const handleMouseMove = (event: Event): void => {
      const mouseEvent = event as MouseEvent;
      lastMouseX = mouseEvent.clientX;
      lastMouseY = mouseEvent.clientY;

      if (currentTooltip) {
        positionTooltip(lastMouseX, lastMouseY);
      }
    };

    colorVariants.forEach((variant: Element) => {
      variant.addEventListener('mouseenter', (event) => handleMouseEnter(variant, event));
      variant.addEventListener('mouseleave', handleMouseLeave);
      variant.addEventListener('mousemove', handleMouseMove);
    });

    // Очищуємо при видаленні елемента зі сторінки
    return () => {
      hideTooltip();
      colorVariants.forEach((variant: Element) => {
        variant.removeEventListener('mouseenter', (event) => handleMouseEnter(variant, event));
        variant.removeEventListener('mouseleave', handleMouseLeave);
        variant.removeEventListener('mousemove', handleMouseMove);
      });
    };
  };

  // Зберігаємо функцію очищення
  let cleanupColorVariantTooltip = initColorVariantTooltip();
  
  // Переініціалізуємо при оновленні товару
  prestashop.on(events.updatedProduct, () => {
    if (cleanupColorVariantTooltip) {
      cleanupColorVariantTooltip();
    }
    cleanupColorVariantTooltip = initColorVariantTooltip();
  });
  
  prestashop.on(events.quickviewOpened, () => {
    if (cleanupColorVariantTooltip) {
      cleanupColorVariantTooltip();
    }
    cleanupColorVariantTooltip = initColorVariantTooltip();
  });
};
