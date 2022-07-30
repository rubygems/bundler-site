import AnchorJS from 'anchor-js';

const anchors = new AnchorJS();

anchors.add(
  '#page-content-wrapper h2, #page-content-wrapper h3, ' +
    '#page-content-wrapper h4, #page-content-wrapper h5'
);

const el = document.querySelector('.version-selects');
el &&
  el.addEventListener('input', function (e) {
    document.location.href = e.target.value;
  });
