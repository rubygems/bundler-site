import $ from 'jquery'
import AnchorJS from 'anchor-js';

const anchors = new AnchorJS();

$('.version-selects').change(function(e) {
  document.location.href = $(e.target).find(":selected").val();
});

$(document).ready(function() {
  anchors.add('#page-content-wrapper h1, #page-content-wrapper h2, #page-content-wrapper h3, ' +
    '#page-content-wrapper h4, #page-content-wrapper h5');
});
