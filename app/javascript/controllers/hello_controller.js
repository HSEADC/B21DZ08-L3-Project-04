import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['name'];

  connect() {
    // this.element.textContent = "Hello World!"
    console.log('Hello, Stimulus!', this.element);
  }

  greet() {
    console.log(`Hello, ${this.name}!`);
  }

  get name() {
    return this.nameTarget.value;
  }
}
