import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    console.log('Контроллер подключен');
  }
}

// export default class TrixController extends Controller {
//   connect() {
//     addEventListener(
//       'trix-initialize',
//       function (event) {
//         console.log('im inititalized!');
//         // ...
//         // add underline code
//         // remove buttons code
//         // add custom icons code here
//         // ...
//       },
//       true
//     );

//     // remove file upload handling
//     addEventListener(
//       'trix-file-accept',
//       function (event) {
//         event.preventDefault();
//       },
//       true
//     );
//   }
// }
