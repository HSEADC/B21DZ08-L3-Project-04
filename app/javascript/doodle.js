document.addEventListener('DOMContentLoaded', function () {
  var logo = document.getElementById('logo');
  var A_LogoDescriptor = document.getElementById('A_LogoDescriptor');

  logo.addEventListener('mouseenter', function () {
    A_LogoDescriptor.style.display = 'block';
  });

  logo.addEventListener('mouseleave', function () {
    A_LogoDescriptor.style.display = 'none';
  });

  logo.addEventListener('mousemove', function (e) {
    var mouseX = e.pageX - 150;
    var mouseY = e.pageY;
    A_LogoDescriptor.style.top = mouseY + 'px';
    A_LogoDescriptor.style.left = mouseX + 'px';
  });
});
