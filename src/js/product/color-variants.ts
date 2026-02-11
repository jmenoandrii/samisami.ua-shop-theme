export function initColorVariants(prestashop: any, events: any) {
  function updateColorVariantClass(variant: Element, colorElement: HTMLElement): void {
    const bgColor = window.getComputedStyle(colorElement).backgroundColor;
    const isWhite = isWhiteColor(bgColor);
    if (isWhite) {
      variant.classList.add('color-white');
    } else {
      variant.classList.remove('color-white');
    }
  }

  function isWhiteColor(bgColor: string): boolean {
    const rgbMatch = bgColor.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\)/);
    if (rgbMatch) {
      const r = parseInt(rgbMatch[1], 10);
      const g = parseInt(rgbMatch[2], 10);
      const b = parseInt(rgbMatch[3], 10);
      return r > 240 && g > 240 && b > 240;
    }
    const colorLower = bgColor.toLowerCase();
    return colorLower.includes('white') || 
           colorLower.includes('#fff') ||
           colorLower.includes('rgb(255');
  }

  const colorVariants = document.querySelectorAll('.color-variant');
  colorVariants.forEach((variant: Element) => {
    const colorElement = variant.querySelector('.color') as HTMLElement;
    if (colorElement) {
      updateColorVariantClass(variant, colorElement);
    }
  });

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

  prestashop.on(events.updatedProduct, () => initColorVariants(prestashop, events));
  prestashop.on(events.quickviewOpened, () => initColorVariants(prestashop, events));
}