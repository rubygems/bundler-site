var lunrIndex = null;
var lunrData  = null;

$(document).ready(function() {
  $.ajax({
    url: "/search/lunr-index.json",
    cache: true,
    method: 'GET',
    success: function (data) {
      lunrData = data;
      lunrIndex = lunr.Index.load(lunrData.index);
    }
  });
});

(function() {
  var Search = window.Search = function() {
    this.SEARCH_INPUT_ID = '#input-search';
  };

  Search.prototype.init = function()  {
    this.searchInput = $(this.SEARCH_INPUT_ID);
    this.searchInput.change(function(e) {
      console.log('test')
      var text = $(this).val();
      console.log(text)
    });
  };

})();

new Search().init();