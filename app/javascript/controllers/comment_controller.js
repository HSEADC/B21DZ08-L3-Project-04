import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['replies'];

  toggleReplies() {
    console.log('Hiiiii');
    this.repliesTarget.classList.add('open');

    // if (this.repliesTarget.classList.contains('open')) {
    //   this.repliesTarget.classList.remove('open');
    //   this.element.querySelector('button').textContent =
    //     'Show Replies';
    // } else {
    //   this.repliesTarget.classList.add('open');
    //   this.element.querySelector('button').textContent =
    //     'Hide Replies';
    // }
  }
}
