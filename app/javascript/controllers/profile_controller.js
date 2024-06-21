import { Controller } from '@hotwired/stimulus';
export default class extends Controller {
  static targets = [
    'draftsButton',
    'collectionsButton',
    'postsButton',
    'posts',
    // 'drafts',
    'collections',
  ];

  showPosts() {
    this.hideAllSections();
    this.postsTarget.classList.remove('Hidden');
    this.activateButton(this.postsButtonTarget);
  }

  showCollections() {
    this.hideAllSections();
    this.collectionsTarget.classList.remove('Hidden');
    this.activateButton(this.collectionsButtonTarget);
  }

  // showDrafts() {
  //   console.log('Yaaaay3');
  //   this.hideAllSections();
  //   this.draftsTarget.classList.remove('Hidden');
  //   this.activateButton(this.draftsButtonTarget);
  // }

  hideAllSections() {
    this.postsTarget.classList.add('Hidden');
    this.collectionsTarget.classList.add('Hidden');
    // this.draftsTarget.classList.add('Hidden');
  }

  activateButton(activeButton) {
    this.postsButtonTarget.classList.remove('A_Link');
    this.collectionsButtonTarget.classList.remove('A_Link');
    // this.draftsButtonTarget.classList.remove('A_Link');
    activeButton.classList.add('A_Link');
  }
}
