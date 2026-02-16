export function initProductTabs(prestashop: any, events: any) {
  const tabsContainer = document.querySelector('.product-tabs');
  if (!tabsContainer) return;

  const tabLinks = tabsContainer.querySelectorAll('.product-tabs__link');
  const tabContents = document.querySelectorAll('.product-tabs__content');
  const tabClose = document.querySelectorAll('.product-tabs__close');

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
      tabLinks.forEach((tab: Element) => tab.classList.remove('active'));
      tabContents.forEach((content: Element) => content.classList.add('hide'));
      el.classList.add('hide');
    })
  });

  tabLinks.forEach((link: Element) => {
    link.addEventListener('click', (event: Event) => {
      event.preventDefault();
      const clickedLink = event.target as HTMLElement;
      const tabId = clickedLink.getAttribute('data-id');
      tabLinks.forEach((tab: Element) => tab.classList.remove('active'));
      tabClose.forEach((el: Element) => el.classList.remove('hide'));
      clickedLink.classList.add('active');
      tabContents.forEach((content: Element) => content.classList.add('hide'));
      if (tabId) {
        const activeContent = document.getElementById(tabId);
        if (activeContent) {
          activeContent.classList.remove('hide');
        }
      }
    });
  });

  //prestashop.on(events.updatedProduct, () => initProductTabs(prestashop, events));
  prestashop.on(events.quickviewOpened, () => initProductTabs(prestashop, events));
}