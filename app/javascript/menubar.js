document.addEventListener('turbo:load', function () {
  const burgerButton = document.getElementById('burgerMenu');
  const dropdown = document.getElementById('mobileDropdown');
  const desktopOpener = document.getElementById('desktopOpener');
  const desktopDropdown = document.getElementById('desktopDropdown');

  function toggleMenu() {
    burgerButton.classList.toggle('Active');

    if (dropdown.classList.contains('NotActive')) {
      dropdown.classList.remove('NotActive');
      burgerButton.classList.add('Active');
    } else {
      burgerButton.classList.remove('Active');
      dropdown.classList.add('NotActive');
    }
  }

  function desktopDropdownToggle() {
    if (desktopDropdown.classList.contains('NotActive')) {
      desktopDropdown.classList.remove('NotActive');
    } else {
      desktopDropdown.classList.add('NotActive');
    }
  }

  burgerButton.addEventListener('click', toggleMenu);
  desktopOpener.addEventListener('click', desktopDropdownToggle);
});

// document.addEventListener('DOMContentLoaded', function () {
//   const commentInput = document.getElementById('CommentInput');
//   const commentButton = document.getElementById('CommentButton');

//   commentInput.addEventListener('focus', function () {
//     if (commentInput.value.trim() !== '') {
//       commentButton.classList.remove('Grey');
//       commentButton.classList.add('Blue');
//       commentButton.removeAttribute('disabled');
//     }
//   });

//   commentInput.addEventListener('blur', function () {
//     if (commentInput.value.trim() === '') {
//       commentButton.classList.add('Grey');
//       commentButton.classList.remove('Blue');
//       commentButton.setAttribute('disabled', true);
//     }
//   });

//   commentInput.addEventListener('input', function () {
//     if (commentInput.value.trim() !== '') {
//       commentButton.classList.remove('Grey');
//       commentButton.classList.add('Blue');
//       commentButton.removeAttribute('disabled');
//     } else {
//       commentButton.classList.add('Grey');
//       commentButton.classList.remove('Blue');
//       commentButton.setAttribute('disabled', true);
//     }
//   });
// });
