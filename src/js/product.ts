import { initProductSlide } from './product/product-slider';
import { initColorVariants } from './product/color-variants';
import { detectQuantityChange } from './product/quantity-change';
import { initProductTabs } from './product/product-tabs';
import { initColorVariantTooltip } from './product/color-variant-tooltip';

export default () => {
  const {prestashop, Theme: {events}} = window;

  initProductSlide(prestashop, events);
  initColorVariants(prestashop, events);
  detectQuantityChange(prestashop);
  initProductTabs(prestashop, events);

  let cleanupColorVariantTooltip = initColorVariantTooltip(prestashop, events);

  prestashop.on(events.updatedProduct, () => {
    if (cleanupColorVariantTooltip) cleanupColorVariantTooltip();
    cleanupColorVariantTooltip = initColorVariantTooltip(prestashop, events);
  });

  prestashop.on(events.quickviewOpened, () => {
    if (cleanupColorVariantTooltip) cleanupColorVariantTooltip();
    cleanupColorVariantTooltip = initColorVariantTooltip(prestashop, events);
  });
};