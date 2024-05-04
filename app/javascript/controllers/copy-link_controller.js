import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  copyLink() {
    const currentUrl = window.location.href;
    navigator.clipboard
      .writeText(currentUrl)
      .then(() => {
        alert('Ссылка скопирована в буфер обмена');
      })
      .catch((error) => {
        console.error(
          'Произошла ошибка при копировании ссылки:',
          error
        );
        alert('Скопировать ссылку не удалось.');
      });
  }
}
