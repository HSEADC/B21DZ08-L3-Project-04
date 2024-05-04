import { Controller } from '@hotwired/stimulus';

export default class TrixController extends Controller {
  static TOOLBAR_BUTTON_ICONS = [
    {
      identifier: '.trix-button--icon-bold',
      text: 'Жирный',
    },
    {
      identifier: '.trix-button--icon-italic',
      text: 'Курсив',
    },
    {
      identifier: '.trix-button--icon-link',
      text: 'Ссылка',
    },
    {
      identifier: '.trix-button--icon-heading-1',
      text: 'Тт',
    },
    {
      identifier: '.trix-button--icon-quote',
      text: '«Цитата»',
    },
    {
      identifier: '.trix-button--icon-bullet-list',
      text: '• Список',
    },
    {
      identifier: '.trix-button--icon-number-list',
      text: '1. Список',
    },
    {
      identifier: '.trix-button--icon-attach',
      text: '',
    },
  ];

  connect() {
    console.log('Контроллер подключен!');
    addEventListener(
      'trix-initialize',
      function (event) {
        console.log('im inititalized!');
        TrixController.TOOLBAR_BUTTON_ICONS.forEach((group) => {
          console.log('пиу');
          document.querySelector(group.identifier).innerHTML =
            group.text;
        });
      },
      true
    );
  }
}
