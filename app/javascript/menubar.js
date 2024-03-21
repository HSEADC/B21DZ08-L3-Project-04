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

document.addEventListener('DOMContentLoaded', function () {
  const commentInput = document.getElementById('CommentInput');
  const commentButton = document.getElementById('CommentButton');

  commentInput.addEventListener('focus', function () {
    if (commentInput.value.trim() !== '') {
      commentButton.classList.remove('Grey');
      commentButton.classList.add('Blue');
      commentButton.removeAttribute('disabled');
    }
  });

  commentInput.addEventListener('blur', function () {
    if (commentInput.value.trim() === '') {
      commentButton.classList.add('Grey');
      commentButton.classList.remove('Blue');
      commentButton.setAttribute('disabled', true);
    }
  });

  commentInput.addEventListener('input', function () {
    if (commentInput.value.trim() !== '') {
      commentButton.classList.remove('Grey');
      commentButton.classList.add('Blue');
      commentButton.removeAttribute('disabled');
    } else {
      commentButton.classList.add('Grey');
      commentButton.classList.remove('Blue');
      commentButton.setAttribute('disabled', true);
    }
  });
});
