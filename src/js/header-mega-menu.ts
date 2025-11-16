class HeaderMegaMenu {
  private buttonSelector = '.header .catalog-btn';
  private menuSelector = '.header-mega-menu';
  private backdropSelector = '.header-mega-menu__background';
  private wrapperSelector = '.header-mega-menu__wrapper';
  private activeClass = 'active';
  private openingClass = 'opening';
  private preventScrollClass = 'prevent-scrolling';
  private button: HTMLElement | null = null;
  private menu: HTMLElement | null = null;
  private backdrop: HTMLElement | null = null;
  private wrapper: HTMLElement | null = null;
  private boundDocumentClick: (e: Event) => void;
  private boundButtonClick: (e: Event) => void;
  private boundBackdropClick: (e: Event) => void;
  private scrollPosition: number = 0;

  constructor() {
    this.boundDocumentClick = this.onDocumentClick.bind(this);
    this.boundButtonClick = this.onButtonClick.bind(this);
    this.boundBackdropClick = this.onBackdropClick.bind(this);
  }

  private attachListeners(): void {
    if (this.button) {
      this.button.addEventListener('click', this.boundButtonClick);
    }
    if (this.backdrop) {
      this.backdrop.addEventListener('click', this.boundBackdropClick);
    }
    document.addEventListener('click', this.boundDocumentClick, true);
  }

  reinit(): void {
    this.button = document.querySelector(this.buttonSelector);
    this.menu = document.querySelector(this.menuSelector);
    this.backdrop = document.querySelector(this.backdropSelector);
    this.wrapper = document.querySelector(this.wrapperSelector);

    if (!this.button || !this.menu) {
      return;
    }
    this.attachListeners();
  }

  private onButtonClick(e: Event): void {
    e.stopPropagation();
    const isOpen = this.menuHasActive();
    if (isOpen) {
      this.close();
    } else {
      this.open();
    }
  }

  private onBackdropClick(): void {
    this.close();
  }

  private onDocumentClick(e: Event): void {
    if (!this.menu || !this.button) {
      return;
    }
    const target = e.target as Node;
    if (this.menu.contains(target) || this.button.contains(target)) {
      return;
    }
    if (this.menuHasActive()) {
      this.close();
    }
  }

  private disableScroll(): void {    
    // Додаємо клас для блокування скролу
    document.body.classList.add(this.preventScrollClass);
  }

  private enableScroll(): void {
    // Видаляємо клас
    document.body.classList.remove(this.preventScrollClass);
  }

  private open(): void {
    if (!this.menu || !this.button) return;
    
    // Блокуємо скрол
    this.disableScroll();
    
    // Спочатку показуємо елемент
    this.menu.classList.add(this.openingClass);
    this.button.classList.add(this.activeClass);
    this.button.setAttribute('aria-expanded', 'true');
    
    // Trigger reflow для запуску анімації
    this.menu.offsetHeight;
    
    // Додаємо active клас для анімації
    requestAnimationFrame(() => {
      this.menu?.classList.add(this.activeClass);
    });
  }

  private close(): void {
    if (!this.menu || !this.button) return;
    
    this.menu.classList.remove(this.activeClass);
    this.button.classList.remove(this.activeClass);
    this.button.setAttribute('aria-expanded', 'false');
    
    // Чекаємо завершення анімації перед приховуванням
    setTimeout(() => {
      this.menu?.classList.remove(this.openingClass);
      // Розблоковуємо скрол після закриття
      this.enableScroll();
    }, 400); // Час має відповідати тривалості transition
  }

  private menuHasActive(): boolean {
    return !!this.menu && this.menu.classList.contains(this.activeClass);
  }
}

const instance = new HeaderMegaMenu();

export default function initHeaderMegaMenu(): void {
  instance.reinit();
}