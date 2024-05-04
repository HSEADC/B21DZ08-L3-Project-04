import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['openedDropdown'];
  isOpen = false;
  closeTimeout = null;
  open() {
    console.log('open');
    const openedDropdown = this.openedDropdownTarget;
    openedDropdown.classList.remove('hidden');
    this.isOpen = true;
  }

  close() {
    console.log('close');
    const openedDropdown = this.openedDropdownTarget;
    openedDropdown.classList.add('hidden');
    this.isOpen = false;
  }

  cancelClose() {
    console.log('cancelClose');
    clearTimeout(this.closeTimeout);
  }

  resumeClose() {
    console.log('resumeClose');
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
