import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['searchInput', 'tag', 'tagContainer'];

  filter() {
    // const inputValue = this.searchInputTarget.value
    //   .trim()
    //   .toLowerCase();
    // this.tagTargets.forEach((tag) => {
    //   const tagText = tag.textContent.trim().toLowerCase();
    //   if (tagText.includes(inputValue)) {
    //     tag.classList.remove('None');
    //   } else {
    //     tag.classList.add('None');
    //   }
    // });
    const inputValue = this.searchInputTarget.value
      .trim()
      .toLowerCase();
    const matchedTags = this.tagTargets.filter((tag) =>
      tag.textContent.trim().toLowerCase().includes(inputValue)
    );

    if (inputValue === '') {
      this.clearInput();
      this.tagTargets.forEach((tag) => tag.classList.remove('None'));
    } else if (matchedTags.length === 0) {
      this.hideAllTagsExceptNewTag(inputValue);
    } else {
      this.tagTargets.forEach((tag) => {
        const tagText = tag.textContent.trim().toLowerCase();
        if (tagText.includes(inputValue)) {
          tag.classList.remove('None');
        } else {
          tag.classList.add('None');
        }
      });
    }
  }

  hideAllTagsExceptNewTag(tagText) {
    this.tagTargets.forEach((tag) => tag.classList.add('None'));
    const tagContainer = this.tagContainerTarget;
    let newTag = tagContainer.querySelector('.new-tag');
    if (!newTag) {
      newTag = document.createElement('div');
      newTag.classList.add(
        'A_Paragraph',
        'Antiqua',
        'A_Tag',
        'new-tag'
      );
      tagContainer.appendChild(newTag);
    }
    newTag.textContent = tagText;
    newTag.classList.remove('None');
  }

  clearInput() {
    const tagContainer = this.tagContainerTarget;
    const newTag = tagContainer.querySelector('.new-tag');
    if (newTag) {
      tagContainer.removeChild(newTag);
    }
  }
}
