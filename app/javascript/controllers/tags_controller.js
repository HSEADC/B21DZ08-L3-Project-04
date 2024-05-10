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

  connect() {
    this.displayExistingPostTags();
  }

  displayExistingPostTags() {
    const selectedTagsContainer = this.selectedTagsContainerTarget;

    // Прохожусь по каждому типу тегов
    this.postTagsFormTargets.forEach((form) => {
      const tagValue = form.value.trim();
      const formType = form.dataset.type;
      // Если теги вообще есть, разделяю их и вывожу на страницу
      if (tagValue !== '') {
        const tagValues = tagValue
          .split(', ')
          .map((tag) => tag.trim());

        tagValues.forEach((tagText) => {
          this.createTag(
            tagText,
            'selectedTag',
            formType,
            selectedTagsContainer
          );
          //Затем прохожусь по всем контейнерам тегов и смотрю на теги внутри
          this.tagContainerTargets.forEach((tagContainer) => {
            const tagsInContainer =
              tagContainer.querySelectorAll('.A_Tag');

            // Проверяю соответствие типа тега контейнеру и если мэтч
            // то добавляю класс selected
            if (tagContainer.dataset.type === formType) {
              tagsInContainer.forEach((tag) => {
                if (tag.textContent.trim() === tagText) {
                  tag.classList.add('Selected');
                }
              });
            }
          });
        });
      }
    });
  }

  handleTagClick(event) {
    const clickedTag = event.currentTarget;
    const clickedTagType = clickedTag.dataset.type;
    const specifiedInput = this.searchInputTargets.find(
      (input) => input.id === clickedTagType
    );
    const specifiedTagContainer = this.tagContainerTargets.find(
      (container) => container.id === clickedTagType
    );

    // тык на свежесозданный тег -> сначала проверяю,
    // не существует ли уже такого тега
    if (clickedTag.dataset.tagsTarget === 'newTag') {
      const tagText = clickedTag.textContent.trim();
      let exists = false;
      this.selectedTagTargets.forEach((selectedTag) => {
        if (selectedTag.textContent.trim() === tagText) {
          exists = true;
          return;
        }
      });

      // если не существует -> обнуляю инпут, удаляю тег
      // и создаю новый уже в списке выбранных тегов,
      // снова показываю все скрытые фильтрацией теги
      if (!exists) {
        specifiedInput.value = '';
        clickedTag.remove();
        this.tagTargets.forEach((tag) =>
          tag.classList.remove('None')
        );
        this.createTag(
          clickedTag.textContent,
          'selectedTag',
          clickedTagType,
          this.selectedTagsContainerTarget
        );
      }
      // если существует, обнуляю инпут и удаляю тег,
      // снова показываю все скрытые фильтрацией теги
      else {
        specifiedInput.value = '';
        clickedTag.remove();
        this.tagTargets.forEach((tag) =>
          tag.classList.remove('None')
        );
      }
    }

    // тык на существующий тег
    else if (clickedTag.dataset.tagsTarget === 'tag') {
      // если он уже выбран, убираю класс "Selected",
      // и ищу среди выбранных такой же тег. Удаляю его
      if (clickedTag.classList.contains('Selected')) {
        clickedTag.classList.remove('Selected');
        const selectedTag = this.selectedTagTargets.find(
          (selectedTag) =>
            selectedTag.textContent === clickedTag.textContent &&
            selectedTag.dataset.type === clickedTag.dataset.type
        );
        selectedTag.remove();
      }
      // если тег не выбран, добавляю класс "Selected"
      // и создаю новый выбранный тег
      else {
        clickedTag.classList.add('Selected');
        this.createTag(
          clickedTag.textContent,
          'selectedTag',
          clickedTagType,
          this.selectedTagsContainerTarget
        );
      }
    }
    // тык на выбранный сверху тег -> он удаляется, ищу
    // изначальный тег и убираю с него класс "Selected"
    else if (clickedTag.dataset.tagsTarget === 'selectedTag') {
      clickedTag.remove();
      const originalTag = this.tagTargets.find(
        (originalTag) =>
          originalTag.dataset.type === clickedTag.dataset.type &&
          originalTag.textContent === clickedTag.textContent
      );
      if (originalTag) {
        originalTag.classList.remove('Selected');
      }
    }
    // в конце отправляю список выбранных тегов в бд
    this.tagsToDataBase(clickedTagType);
  }

  filter(event) {
    const input = event.currentTarget;
    const inputValue = input.value.trim().toLowerCase();
    const inputType = input.id;
    const specifiedTagContainer = this.tagContainerTargets.find(
      (container) => container.id === inputType
    );

    // собираю массив подходящих запросу тегов
    const matchedTags = Array.from(
      specifiedTagContainer.querySelectorAll('.existing')
    ).filter((tag) => {
      return tag.textContent
        .trim()
        .toLowerCase()
        .includes(inputValue);
    });

    // если есть мэтчи показываю их и удаляю новый тег
    if (matchedTags.length > 0) {
      specifiedTagContainer
        .querySelectorAll('.existing')
        .forEach((tag) => {
          const tagText = tag.textContent.trim().toLowerCase();
          if (tagText.includes(inputValue)) {
            tag.classList.remove('None');
          } else {
            tag.classList.add('None');
          }
        });
      this.clearNewTag(specifiedTagContainer);
    }
    // если нет мэтчей, прячу все существующие теги,
    // и динамически создаю новый тег
    else {
      specifiedTagContainer
        .querySelectorAll('.existing')
        .forEach((tag) => {
          tag.classList.add('None');
        });
      this.updateNewTag(inputValue, specifiedTagContainer);
      if (inputValue == '') {
        this.clearNewTag(specifiedTagContainer);
      }
      console.log('here!');
    }
  }
  createTag(tagContent, tagTarget, tagType, container) {
    const newTag = document.createElement('div');
    newTag.classList.add('A_Tag', 'newTag');
    newTag.classList.add(tagType);
    newTag.dataset.tagsTarget = tagTarget;
    newTag.dataset.action = 'click->tags#handleTagClick';
    newTag.dataset.type = tagType;
    newTag.textContent = tagContent;
    container.appendChild(newTag);
  }

  clearNewTag(container) {
    const newTag = container.querySelector('.newTag');
    if (newTag) {
      newTag.remove();
    }
  }

  updateNewTag(inputValue, container) {
    const newTag = container.querySelector('.newTag');
    if (newTag) {
      newTag.textContent = inputValue;
    } else {
      this.createTag(inputValue, 'newTag', container.id, container);
    }
  }

  tagsToDataBase(tagType) {
    const tagsContainer = this.selectedTagsContainerTarget;
    const tagElements = tagsContainer.querySelectorAll(
      `[data-type="${tagType}"]`
    );
    const tagValues = Array.from(tagElements).map((tag) =>
      tag.textContent.trim()
    );
    const formField = this.postTagsFormTargets.find(
      (field) => field.id === tagType
    );
    formField.value = tagValues.join(', ');
  }
}
