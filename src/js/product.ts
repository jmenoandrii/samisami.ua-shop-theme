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
};
