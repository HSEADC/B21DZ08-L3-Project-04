import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['openedDropdown'];
  isOpen = false;
  closeTimeout = null;
  open() {
    const openedDropdown = this.openedDropdownTarget;
    openedDropdown.classList.remove('hidden');
    this.isOpen = true;
  }

  close() {
    const openedDropdown = this.openedDropdownTarget;
    openedDropdown.classList.add('hidden');
    this.isOpen = false;
  }

  cancelClose() {
    clearTimeout(this.closeTimeout);
  }

  resumeClose() {
    this.closeTimeout = setTimeout(() => {
      if (
        !this.element.matches(':hover') &&
        !this.openedDropdownTarget.matches(':hover')
      ) {
        this.close();
      }
    }, 100);
  }
}
