import $ from 'jquery'
import lunr from 'lunr'

var lunrIndex = null;
var lunrData  = null;
var search = null;

$(document).ready(function() {
  $.ajax({
    url: "/search/lunr-index.json",
    cache: true,
    method: 'GET',
    success: function (data) {
      lunrData = data;
      lunrIndex = lunr.Index.load(lunrData.index);
      search = new Search();
      search.init();
    }
  });
});

(function() {
  var Search = window.Search = function() {
    this.SEARCH_INPUT_ID = '#input-search';
    this.POPOVER_CLASS = '.popover';
    this.POPOVER_OPTIONS = {
      html: true,
      container: 'body',
      placement: 'bottom',
      trigger: 'manual',
      content: (function() { return search.getPopoverContent() })
    };
    this.LIMIT_RESULTS = 10;
    this.popoverContent = '';
    this.popoverHandler = null;

    this.processText = function(text) {
      if (!text || text === '') return this.hidePopover();

      this.showPopover(text);
    };

    this.initializePopover = function() {
      this.popover = this.searchInput.popover(this.POPOVER_OPTIONS).data('bs.popover');
    };

    this.hidePopover = function() {
      this.popover.options.animation = true;
      this.searchInput.popover('hide');
      this.searchArrows.destroy();
    };

    this.showPopover = function(text) {
      this.popoverContent = this.generatePopoverContent(text);
      this.searchInput.popover('show');
    };

    this.generatePopoverContent = function(text) {
      var results = lunrIndex.search(text);
      if (!results.length) return 'No results found';

      results = results.slice(0, this.LIMIT_RESULTS);
      var uniqueResults = this.uniqueResults(results);

      var generated = '<ul class="search-list-ul">';
      uniqueResults.forEach(function(res) {
        var store = lunrData.docs[res.ref];
        var description = (store.description == null ? '' : $('<p>').text(store.description));
        
        var element = $('<div>').html(
          $('<li class="search-list-li">').html(
            $('<a>').attr('href', store.url).html('<h4>' + store.title + '</h4>').
            append(
              $('<br />')
            )
          ).append(description).
          append(
            $('<li>').attr('class', 'separator').html($('<hr />'))
          )
        );
        generated += element.html();
      });

      return generated + '</ul>';
    };

    this.uniqueResults = function(results) {
      var uniqueResults = [];
      var titles = [];
      $.each(results, function(i, el){
        if($.inArray(lunrData.docs[el.ref].title, titles) === -1) {
          titles.push(lunrData.docs[el.ref].title);
          uniqueResults.push(el);
        }
      });
      return uniqueResults;
    };

    this.initializePopoverEvents = function() {
      var self = this;

      this.searchInput.on('paste keyup', function(e) {
        if (self.searchArrows.isOneOfKeys(e.which)) return;
        if (e.which == 27)  return self.hidePopover(); // esc key
        
        var text = $(this).val();
        self.processText(text);
      });
      this.searchInput.focus(function(e)  {
        var text = $(this).val();
        if (text === '') return;
        
        self.showPopover(text);
      });
      this.searchInput.on('shown.bs.popover', function()  {
        self.popoverHandler = $(self.POPOVER_CLASS);
        self.popover.options.animation = false;
        self.popoverHandler.click(function(e) { e.stopPropagation() });
        self.searchArrows.init();
      });
      this.searchInput.click(function(e) { e.stopPropagation() });
      $(window).click(function() { self.hidePopover() });
    }
  };

  Search.prototype.init = function()  {
    this.searchInput = $(this.SEARCH_INPUT_ID);
    this.searchArrows = new SearchArrows();
    this.initializePopoverEvents();
    this.initializePopover();
  };

  Search.prototype.getPopoverContent = function() {
    return this.popoverContent;
  };
})();
