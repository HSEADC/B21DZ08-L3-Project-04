document.addEventListener('DOMContentLoaded', function () {
  const switcher = document.querySelector('.M_Switcher');
  const paragraphs = switcher.querySelectorAll('.A_Paragraph');
  const postsContainers = document.querySelectorAll('.W_Posts');

  paragraphs.forEach(function (paragraph) {
    paragraph.addEventListener('click', function () {
      paragraphs.forEach(function (p) {
        p.classList.remove('A_Link');
      });
      this.classList.add('A_Link');

      const targetClass = this.classList[1];
      postsContainers.forEach(function (container) {
        if (container.classList.contains(targetClass)) {
          container.classList.remove('Hidden');
        } else {
          container.classList.add('Hidden');
        }
      });
    });
  });
});
