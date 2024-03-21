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
// document.addEventListener('trix-initialize', function (event) {
//   var editor = event.target;

//   editor.toolbarElement.setAttribute(
//     'data-trix-button-group',
//     'text-tools'
//   );
//   editor.toolbarElement.classList.add('C_TextEditorButtons');
//   editor.toolbarElement.innerHTML = `
//     <button type="button" class="A_Button Black" data-trix-attribute="heading1" title="Заголовок" tabindex="-1">Тт</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="bold" title="Жирный" data-trix-key="b" tabindex="-1" style="font-weight: bold;">Жирный</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="italic" title="Курсив" data-trix-key="i" tabindex="-1" style="font-style: italic;">Курсив</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="Ссылка" tabindex="-1">Ссылка</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="quote" title="Цитата" tabindex="-1">«Цитата»</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="bullet" title="Маркированный список" tabindex="-1">• Список</button>
//     <button type="button" class="A_Button Black" data-trix-attribute="number" title="Нумерованный список" tabindex="-1">1. Список</button>
//     <button type="button" class="A_IconButton Blue Attachment" data-trix-action="attachFiles" title="Добавить вложение" tabindex="-1"></button>
//     <button type="button" class="trix-button trix-button--icon trix-button--icon-link" data-trix-attribute="href" data-trix-action="link" data-trix-key="k" title="Link" tabindex="-1">Link</button>
//   `;
// });
