// document.addEventListener('DOMContentLoaded', function () {
//   var logo = document.getElementById('logo');
//   var A_LogoDescriptor = document.getElementById('A_LogoDescriptor');
//   var logoWidth = logo.offsetWidth;
//   var logoHeight = logo.offsetHeight;
//   var windowWidth = 1440;
//   var windowHeight = 900;

//   logo.addEventListener('mouseenter', function () {
//     A_LogoDescriptor.style.display = 'block';
//   });

//   logo.addEventListener('mouseleave', function () {
//     A_LogoDescriptor.style.display = 'none';
//   });

//   logo.addEventListener('mousemove', function (e) {
//     var mouseX = e.pageX - logoWidth / 2;
//     var mouseY = e.pageY;

//     var descriptorX = mouseX;
//     var descriptorY = mouseY;
//     if (descriptorX < 0) {
//       descriptorX = 0;
//     }
//     if (descriptorY < 0) {
//       descriptorY = 0;
//     }
//     if (descriptorX + A_LogoDescriptor.offsetWidth > windowWidth) {
//       descriptorX = windowWidth - A_LogoDescriptor.offsetWidth;
//     }
//     if (descriptorY + A_LogoDescriptor.offsetHeight > windowHeight) {
//       descriptorY = windowHeight - A_LogoDescriptor.offsetHeight;
//     }

//     A_LogoDescriptor.style.top = descriptorY + 'px';
//     A_LogoDescriptor.style.left = descriptorX + 'px';
//   });
// });
