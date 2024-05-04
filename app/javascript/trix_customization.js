document.addEventListener('trix-initialize', function (event) {
  console.log('initialized!');
  const toolbar_button_icons = [
    {
      identifier: '.trix-button--icon-bold',
      text: '<strong>Жирный</strong>',
      title: 'Жирный',
    },
    {
      identifier: '.trix-button--icon-italic',
      text: '<em>Курсив</em>',
      title: 'Курсив',
    },
    {
      identifier: '.trix-button--icon-link',
      text: 'Ссылка',
      title: 'Ссылка',
    },
    {
      identifier: '.trix-button--icon-heading-1',
      text: 'Тт',
      title: 'Заголовок',
    },
    {
      identifier: '.trix-button--icon-quote',
      text: '«Цитата»',
      title: 'Цитаты',
    },
    {
      identifier: '.trix-button--icon-bullet-list',
      text: '• Список',
      title: 'Маркированный список',
    },
    {
      identifier: '.trix-button--icon-number-list',
      text: '1. Список',
      title: 'Нумерованный список',
    },
    {
      identifier: '.trix-button--icon-attach',
      text: '',
      title: 'Вложение',
    },
  ];

  toolbar_button_icons.forEach((group) => {
    document.querySelector(group.identifier).innerHTML = group.text;
    document
      .querySelector(group.identifier)
      .setAttribute('title', `${group.title}`);
    if (group.identifier == '.trix-button--icon-link') {
      document
        .querySelector(group.identifier)
        .classList.add('underlined');
    }
  });
});

document.addEventListener('DOMContentLoaded', function () {
  var title = document.querySelector('#test');
  var toolbar = document.querySelector('#trix-toolbar-1');
  var trixContent = document.querySelector('.trix-content');
  toolbar.parentNode.insertBefore(title, trixContent);
});
