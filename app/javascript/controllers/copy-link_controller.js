import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  copyLink() {
    const currentUrl = window.location.href;
    navigator.clipboard.writeText(currentUrl);
  }
}
