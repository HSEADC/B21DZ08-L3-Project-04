document.addEventListener('trix-initialize', function (event) {
  var editor = event.target;

  // Кастомизация кнопок
  editor.toolbarElement.setAttribute(
    'data-trix-button-group',
    'text-tools'
  );
  editor.toolbarElement.classList.add('C_TextEditorButtons');
  editor.toolbarElement.innerHTML = `
    <button type="button" class="A_Button Black" data-trix-attribute="bold" title="Жирный" tabindex="-1" style="font-weight: bold;">Жирный</button>
    <button type="button" class="A_Button Black" data-trix-attribute="italic" title="Курсив" tabindex="-1" style="font-style: italic;">Курсив</button>
    <button type="button" class="A_Button Black" data-trix-attribute="link" title="Вставить ссылку" tabindex="-1" style="text-decoration: underline;">Ссылка</button>
    <button type="button" class="A_Button Black" data-trix-attribute="quote" title="Цитата" tabindex="-1">«Цитата»</button>
    <button type="button" class="A_Button Black" data-trix-attribute="bullet" title="Список" tabindex="-1">• Список</button>
    <button type="button" class="A_IconButton Blue Attachment" data-trix-attribute="attachment" title="Добавить вложение" tabindex="-1"></button>
  `;
});

// Attach the Trix initialization event listener
document.addEventListener('trix-initialize', function (event) {
  // Your custom initialization code here
});
