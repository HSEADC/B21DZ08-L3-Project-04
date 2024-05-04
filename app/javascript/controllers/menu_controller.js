import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  //   static targets = ['additionalMenu'];
  //   isOpen = false;
  //   toggleMenu() {
  //     const additionalMenu = this.additionalMenuTarget;
  //     if (this.isOpen) {
  //       this.close(additionalMenu);
  //     } else {
  //       this.open(additionalMenu);
  //     }
  //   }
  //   open(additionalMenu) {
  //     additionalMenu.classList.remove('NotActive');
  //     document.addEventListener('click', this.closeOutside);
  //     this.isOpen = true;
  //   }
  //   close(additionalMenu) {
  //     additionalMenu.classList.add('NotActive');
  //     document.removeEventListener('click', this.closeOutside);
  //     this.isOpen = false;
  //   }
  //   closeOutside = (event) => {
  //     const additionalMenu = this.additionalMenuTarget;
  //     if (!this.element.contains(event.target)) {
  //       this.close(additionalMenu);
  //     }
  //   };
}
