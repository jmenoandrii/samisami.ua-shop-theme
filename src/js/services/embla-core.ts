// embla-core.ts
import EmblaCarousel, {
  EmblaOptionsType,
  EmblaCarouselType
} from 'embla-carousel'
import Autoplay, { AutoplayOptionsType } from 'embla-carousel-autoplay'

/**
 * Створює інстанс Embla з опціями та плагінами.
 * Повертає об'єкт { embla, destroy }.
 */
export function createEmblaCarousel(
  viewportEl: HTMLElement,
  options: EmblaOptionsType = { loop: true },
  autoplayOptions?: AutoplayOptionsType
): { embla: EmblaCarouselType; destroy: () => void } {
  const plugins = autoplayOptions ? [Autoplay(autoplayOptions)] : [Autoplay()]
  const embla = EmblaCarousel(viewportEl, options, plugins)
  const destroy = (): void => {
    try {
      embla.destroy()
    } catch (err) {
      // ignore
    }
  }
  return { embla, destroy }
}

/* -------------------------
   BUTTONS PLUGIN / HANDLERS
   ------------------------- */

/**
 * Додає логіку включення/відключення кнопок Prev/Next.
 * Повертає функцію, яка скидає стани кнопок та відписує слухачі (clean up handled by caller).
 */
export const addTogglePrevNextBtnsActive = (
  emblaApi: EmblaCarouselType,
  prevBtn: HTMLElement,
  nextBtn: HTMLElement
): (() => void) => {
  const togglePrevNextBtnsState = (): void => {
    if (emblaApi.canScrollPrev()) prevBtn.removeAttribute('disabled')
    else prevBtn.setAttribute('disabled', 'disabled')
    if (emblaApi.canScrollNext()) nextBtn.removeAttribute('disabled')
    else nextBtn.setAttribute('disabled', 'disabled')
  }

  emblaApi
    .on('select', togglePrevNextBtnsState)
    .on('init', togglePrevNextBtnsState)
    .on('reInit', togglePrevNextBtnsState)

  return (): void => {
    prevBtn.removeAttribute('disabled')
    nextBtn.removeAttribute('disabled')
    // не знімаємо слухачі embla .on(...) — embla.destroy() їх приберe
  }
}

/**
 * Додає click handlers для prev/next з опціональним callback'ом.
 * Повертає функцію для видалення слухачів та скидання стану.
 */
export const addPrevNextBtnsClickHandlers = (
  emblaApi: EmblaCarouselType,
  prevBtn: HTMLElement,
  nextBtn: HTMLElement,
  onButtonClick?: (emblaApi: EmblaCarouselType) => void
): (() => void) => {
  const scrollPrev = (): void => {
    emblaApi.scrollPrev()
    if (onButtonClick) onButtonClick(emblaApi)
  }
  const scrollNext = (): void => {
    emblaApi.scrollNext()
    if (onButtonClick) onButtonClick(emblaApi)
  }
  prevBtn.addEventListener('click', scrollPrev, false)
  nextBtn.addEventListener('click', scrollNext, false)

  const removeTogglePrevNextBtnsActive = addTogglePrevNextBtnsActive(
    emblaApi,
    prevBtn,
    nextBtn
  )

  return (): void => {
    removeTogglePrevNextBtnsActive()
    prevBtn.removeEventListener('click', scrollPrev, false)
    nextBtn.removeEventListener('click', scrollNext, false)
  }
}

/**
 * Стандартна функція для "зупинки/скидання" autoplay при кліку навігації.
 */
export const onNavButtonClick = (emblaApi: EmblaCarouselType): void => {
  const autoplay = emblaApi?.plugins()?.autoplay
  if (!autoplay) return
  const resetOrStop =
    autoplay.options?.stopOnInteraction === false
      ? autoplay.reset
      : autoplay.stop
  resetOrStop()
}

/**
 * Повна ініціалізація каруселі по DOM-елементах (viewport, prevBtn, nextBtn).
 * Повертає об'єкт з emblaApi, cleanup функцією.
 */
export function initEmblaFromElements(options: EmblaOptionsType, elements: {
  viewport: HTMLElement
  prevBtn?: HTMLElement | null
  nextBtn?: HTMLElement | null
}, autoplayOptions?: AutoplayOptionsType) {
  const { viewport, prevBtn, nextBtn } = elements
  const { embla, destroy } = createEmblaCarousel(viewport, options, autoplayOptions)

  // підключаємо кнопки якщо передали
  let removeHandlers: (() => void) | null = null
  if (prevBtn && nextBtn) {
    removeHandlers = addPrevNextBtnsClickHandlers(
      embla,
      prevBtn,
      nextBtn,
      onNavButtonClick
    )
    // гарантія, що на destroy буде відпрацьовано
    embla.on('destroy', () => {
      removeHandlers && removeHandlers()
      removeHandlers = null
    })
  }

  return {
    embla,
    destroy: (): void => {
      removeHandlers && removeHandlers()
      destroy()
    }
  }
}
