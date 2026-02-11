import SelectorsMap from '../constants/selectors-map';

type ProductSlideEvent = Event & {to: number};

export function initProductSlide(prestashop: any, events: any) {
  function onProductSlide(event: ProductSlideEvent): void {
    document.querySelectorAll(SelectorsMap.product.thumbnail).forEach((e) => e.classList.remove('active'));
    document.querySelector(SelectorsMap.product.activeThumbail(event.to))?.classList.add('active');
  }

  document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  prestashop.on(events.updatedProduct, () => {
    document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  });
  prestashop.on(events.quickviewOpened, () => {
    document.querySelector(SelectorsMap.product.carousel)?.addEventListener('slide.bs.carousel', onProductSlide);
  });
}