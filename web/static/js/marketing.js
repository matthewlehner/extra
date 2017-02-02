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

// Adding this to ensure that lightGallery isn't stupid.
window.picturefill = function picturefill() {
  return;
}

window.lightGallery(galleryEl, galleryOpts);
