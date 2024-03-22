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
