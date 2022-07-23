import AnchorJS from 'anchor-js';

const anchors = new AnchorJS();

const el = document.querySelector('.version-selects');
el.addEventListener('input', function (e) {
  document.location.href = e.target.value;
});

anchors.add(
  '#page-content-wrapper h1, #page-content-wrapper h2, #page-content-wrapper h3, ' +
    '#page-content-wrapper h4, #page-content-wrapper h5'
);
