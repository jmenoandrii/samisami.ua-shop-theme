import { initEmblaFromElements } from './embla-core'
import type { EmblaOptionsType } from 'embla-carousel'
import type { AutoplayOptionsType } from 'embla-carousel-autoplay'

export default function initEmblaSlider(
  containerClass: string,
  options: EmblaOptionsType = { loop: true },
  autoplayOptions: AutoplayOptionsType = { active: false }
): Array<() => void> {
  const containers = Array.from(document.querySelectorAll<HTMLElement>(`${containerClass}`))
  const teardowns: Array<() => void> = []

  containers.forEach(container => {
    const emblaNode = container.querySelector<HTMLElement>('.embla')
    if (!emblaNode) return

    const viewportNode = emblaNode.querySelector<HTMLElement>('.embla__viewport')
    const prevBtnNode = emblaNode.querySelector<HTMLElement>('.embla__button--prev')
    const nextBtnNode = emblaNode.querySelector<HTMLElement>('.embla__button--next')

    if (!viewportNode) return

    const initResult = initEmblaFromElements(options, {
      viewport: viewportNode,
      prevBtn: prevBtnNode ?? null,
      nextBtn: nextBtnNode ?? null
    }, autoplayOptions)

    const observer = new MutationObserver((mutations) => {
      for (const m of mutations) {
        for (const removedNode of Array.from(m.removedNodes)) {
          if (removedNode === container || (removedNode instanceof HTMLElement && removedNode.contains(container))) {
            initResult.destroy()
            observer.disconnect()
            return
          }
        }
      }
    })
    observer.observe(document.body, { childList: true, subtree: true })

    teardowns.push(() => {
      observer.disconnect()
      initResult.destroy()
    })
  })

  return teardowns
}
