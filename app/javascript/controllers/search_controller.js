import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['input', 'wrapper', 'button', 'form'];

  connect() {
    this.inputTarget.addEventListener(
      'input',
      this.handleInput.bind(this)
    );
    this.inputTarget.addEventListener(
      'keydown',
      this.handleKeydown.bind(this)
    );
  }

  handleInput() {
    if (this.inputTarget.value.length >= 3) {
      this.showButtonAndShortenInput();
    } else {
      this.hideButtonAndResetInput();
    }
  }

  handleKeydown(event) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.submitForm();
    }
  }

  showButtonAndShortenInput() {
    this.buttonTarget.classList.remove('hidden');
    this.wrapperTarget.classList.add('Short');
    this.inputTarget.classList.add('Short');
  }

  hideButtonAndResetInput() {
    this.buttonTarget.classList.add('hidden');
    this.wrapperTarget.classList.remove('Short');
    this.inputTarget.classList.remove('Short');
  }

  submitForm() {
    this.formTarget.submit();
  }
}
