import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'searchInput',
    'tag',
    'selectedTag',
    'tagContainer',
    'postTagsForm',
    'selectedTagsContainer',
  ];

  handleTagClick(event) {
    const tag = event.currentTarget;
    const tagId = tag.dataset.tagId;

    if (tag.dataset.tagsTarget === 'tag') {
      if (tag.classList.contains('Selected')) {
        tag.classList.remove('Selected');
        const selectedTag = this.selectedTagTargets.find(
          (selectedTag) => selectedTag.dataset.tagId === tagId
        );
        if (selectedTag) {
          selectedTag.classList.add('None');
        }
      } else {
        tag.classList.add('Selected');
        const selectedTag = this.selectedTagTargets.find(
          (selectedTag) => selectedTag.dataset.tagId === tagId
        );
        if (selectedTag) {
          selectedTag.classList.remove('None');
        }
      }
    } else if (tag.dataset.tagsTarget === 'selectedTag') {
      tag.classList.add('None');
      const originalTag = this.tagTargets.find(
        (originalTag) => originalTag.dataset.tagId === tagId
      );
      if (originalTag) {
        originalTag.classList.remove('Selected');
      } else if (tag.dataset.tagsTarget === 'newTag') {
        // Handling click on newTag
        // Add newTag to selectedTagsContainer
        const selectedTagsContainer =
          this.selectedTagsContainerTarget;
        selectedTagsContainer.appendChild(tag);

        // Hide newTag from previous container
        tag.classList.add('None');
        console.log(tag);

        // Clear the input
        this.searchInputTarget.value = '';
      }
    }

    // 1. if tag.dataset.tagsTarget === 'newTag', I want newTag to be added to the container "selectedTagsContainer",
    // and disappear from the previous containter + input should become empty.
    // 2. when I click on 'newTag' in "selectedTagsContainer", it should disappear.
  }

  filter() {
    const inputValue = this.searchInputTarget.value
      .trim()
      .toLowerCase();
    const matchedTags = this.tagTargets.filter((tag) =>
      tag.textContent.trim().toLowerCase().includes(inputValue)
    );

    //отображение и скрытие отфильтрованных тегов
    if (matchedTags.length > 0) {
      this.tagTargets.forEach((tag) => {
        const tagText = tag.textContent.trim().toLowerCase();
        if (tagText.includes(inputValue)) {
          tag.classList.remove('None');
        } else {
          tag.classList.add('None');
        }
      });
      this.clearNewTag();
    } else {
      this.tagTargets.forEach((tag) => {
        tag.classList.add('None');
      });
      this.updateNewTag(inputValue);
    }
  }

  clearNewTag() {
    const newTag = this.tagContainerTarget.querySelector('.newTag');
    if (newTag) {
      newTag.remove();
    }
  }

  updateNewTag(inputValue) {
    const newTag = this.tagContainerTarget.querySelector('.newTag');
    if (newTag) {
      newTag.textContent = inputValue;
      console.log(inputValue);
    } else {
      const tagContainer = this.tagContainerTarget;
      console.log(tagContainer);
      const newTag = document.createElement('div');
      newTag.classList.add(
        'A_Paragraph',
        'Antiqua',
        'A_Tag',
        'newTag'
      );
      //   newTag.dataset.tagId = '';
      newTag.dataset.tagsTarget = 'newTag';
      newTag.dataset.action = 'click->tags#handleTagClick';
      newTag.textContent = inputValue;
      tagContainer.appendChild(newTag);
    }
  }
}

//   filter() {
//     const inputValue = this.searchInputTarget.value
//       .trim()
//       .toLowerCase();
//     const matchedTags = this.tagTargets.filter((tag) =>
//       tag.textContent.trim().toLowerCase().includes(inputValue)
//     );

//     if (inputValue === '') {
//       this.deleteNewTag();
//       this.tagTargets.forEach((tag) => tag.classList.remove('None'));
//     } else if (matchedTags.length === 0) {
//       this.hideAllTagsExceptNewTag(inputValue);
//     } else if (matchedTags.length === 1) {
//       this.deleteNewTag();
//     } else {
//       this.tagTargets.forEach((tag) => {
//         const tagText = tag.textContent.trim().toLowerCase();
//         if (tagText.includes(inputValue)) {
//           tag.classList.remove('None');
//         } else {
//           tag.classList.add('None');
//         }
//       });
//     }
//   }

// hideAllTagsExceptNewTag(tagText) {
//     this.tagTargets.forEach((tag) => tag.classList.add('None'));
//     const tagContainer = this.tagContainerTarget;
//     let newTag = tagContainer.querySelector('.new-tag');
//     if (!newTag) {
//       newTag = document.createElement('div');
//       newTag.classList.add(
//         'A_Paragraph',
//         'Antiqua',
//         'A_Tag',
//         'new-tag'
//       );
//       newTag.dataset.tagsTarget = 'tag';
//       newTag.dataset.action = 'click->tags#handleTagClick';
//       tagContainer.appendChild(newTag);
//     }
//     newTag.textContent = tagText;
//     newTag.classList.remove('None');
//   }

//   deleteNewTag() {
//     const tagContainer = this.tagContainerTarget;
//     const newTag = tagContainer.querySelector('.new-tag');
//     if (newTag) {
//       tagContainer.removeChild(newTag);
//     }
//   }
