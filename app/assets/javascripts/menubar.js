console.log('menubar');
document.addEventListener('DOMContentLoaded', function () {
  document.addEventListener('click', function (event) {
    console.log(event);
    var dropdowns = document.querySelectorAll('.M_Dropdown');
    dropdowns.forEach(function (dropdown) {
      if (dropdown.classList.contains('NotActive')) {
        if (event.target.classList.contains('Q_DropOpener')) {
          dropdown.classList.remove('NotActive');
        }
      } else {
        dropdown.classList.add('NotActive');
      }
    });
  });
});
