import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['card'];

  connect() {
    this.updateCardVisibility();
    window.addEventListener(
      'resize',
      this.updateCardVisibility.bind(this)
    );
  }

  disconnect() {
    window.removeEventListener(
      'resize',
      this.updateCardVisibility.bind(this)
    );
  }

  updateCardVisibility() {
    const isLargeScreen = window.matchMedia(
      '(min-width: 1920px)'
    ).matches;
    const isMediumScreen = window.matchMedia(
      '(min-width: 1024px) and (max-width: 1919px)'
    ).matches;
    const isSmallScreen = window.matchMedia(
      '(min-width: 768px) and (max-width: 1023px)'
    ).matches;
    const isMobileScreen = window.matchMedia(
      '(max-width: 767px)'
    ).matches;

    let visibleCount;

    if (isLargeScreen) {
      visibleCount = 3;
    } else if (isMediumScreen) {
      visibleCount = 2;
    } else if (isSmallScreen) {
      visibleCount = 1;
    } else if (isMobileScreen) {
      visibleCount = 0;
    }

    this.cardTargets.forEach((card, index) => {
      if (index < visibleCount) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  }
}
