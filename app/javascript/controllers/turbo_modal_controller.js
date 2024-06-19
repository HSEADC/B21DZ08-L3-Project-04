import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['overlay'];

  connect() {
    this.overlay = document.querySelector('.Overlay');
    if (this.overlay) {
      this.overlay.addEventListener('click', this.close.bind(this));
    }
  }

  disconnect() {
    if (this.overlay) {
      this.overlay.removeEventListener(
        'click',
        this.close.bind(this)
      );
    }
  }

  close(event) {
    if (event) {
      event.stopPropagation();
    }
    if (event.detail.success) {
      const turboFrame = document.querySelector('#modal');
      if (turboFrame) {
        turboFrame.remove();
      }
    }
    this.element.parentElement.removeAttribute('src');
    this.element.remove();
  }
}
