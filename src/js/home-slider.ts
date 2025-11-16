// embla-home.ts
import EmblaCarousel, {
  EmblaOptionsType,
  EmblaCarouselType
} from 'embla-carousel'
import Autoplay from 'embla-carousel-autoplay'

// --- BUTTONS PLUGIN (офіційний приклад трохи модифікований) ---
const addTogglePrevNextBtnsActive = (
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
  }
}

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

const onNavButtonClick = (emblaApi: EmblaCarouselType): void => {
  const autoplay = emblaApi?.plugins()?.autoplay
  if (!autoplay) return
  const resetOrStop =
    autoplay.options.stopOnInteraction === false
      ? autoplay.reset
      : autoplay.stop
  resetOrStop()
}

export default function initHomeSlider(): void {
  const OPTIONS: EmblaOptionsType = { loop: true }
  const emblaNode = document.querySelector('#home-slider .embla') as HTMLElement
  
  if (!emblaNode) return

  const viewportNode = emblaNode.querySelector('#home-slider .embla__viewport') as HTMLElement
  const prevBtnNode = emblaNode.querySelector('#home-slider .embla__button--prev') as HTMLElement
  const nextBtnNode = emblaNode.querySelector('#home-slider .embla__button--next') as HTMLElement

  if (!viewportNode || !prevBtnNode || !nextBtnNode) return

  const emblaApi = EmblaCarousel(viewportNode, OPTIONS, [Autoplay()])

  const removePrevNextBtnsClickHandlers = addPrevNextBtnsClickHandlers(
    emblaApi,
    prevBtnNode,
    nextBtnNode,
    onNavButtonClick
  )

  emblaApi.on('destroy', removePrevNextBtnsClickHandlers)
}