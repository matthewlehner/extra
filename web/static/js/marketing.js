import "lightgallery.js";

const galleryEl = document.getElementById("screenshot-gallery");

const galleryOpts = {
  download: false,
  counter: false,
  enableDrag: false,
  hideBarsDelay: 1000,
  loop: false,
  hideControlOnEnd: true,
  mode: "lg-fade",
};

window.lightGallery(galleryEl, galleryOpts);
