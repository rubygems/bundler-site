import { Popover } from 'bootstrap';
import lunr from 'lunr';

var lunrIndex = null;
var lunrData = null;
var search = null;

document.addEventListener('DOMContentLoaded', function () {
  var oReq = new XMLHttpRequest();
  oReq.open('GET', '/search/lunr-index.json');
  oReq.addEventListener('load', function () {
    lunrData = JSON.parse(oReq.response);
    lunrIndex = lunr.Index.load(lunrData.index);
    search = new Search();
    search.init();
  });
  oReq.send();
});

(function () {
  var Search = (window.Search = function () {
    this.SEARCH_INPUT_ID = '#input-search';
    this.POPOVER_CLASS = '.popover';
    this.POPOVER_OPTIONS = {
      html: true,
      container: 'body',
      placement: 'bottom',
      trigger: 'manual',
      content: function () {
        return search.getPopoverContent();
      },
    };
    this.LIMIT_RESULTS = 10;
    this.popoverContent = '';
    this.popoverHandler = null;

    this.processText = function (text) {
      if (!text || text === '') return this.hidePopover();

      this.showPopover(text);
    };

    this.initializePopover = function () {
      this.popover = new Popover(this.searchInput, this.POPOVER_OPTIONS);
    };

    this.hidePopover = function () {
      const popover = Popover.getInstance(this.searchInput);
      popover && popover.hide();
      this.searchArrows.destroy();
    };

    this.showPopover = function (text) {
      this.popoverContent = this.generatePopoverContent(text);
      const popover = Popover.getInstance(this.searchInput);
      popover.show();
      document.querySelector('.popover-body').innerHTML = this.popoverContent;
    };

    this.generatePopoverContent = function (text) {
      var results = lunrIndex.search(text);
      if (!results.length) return 'No results found';

      results = results.slice(0, this.LIMIT_RESULTS);
      var uniqueResults = this.uniqueResults(results);

      var generated = '<ul class="search-list-ul">';
      uniqueResults.forEach(function (res) {
        var store = lunrData.docs[res.ref];

        // title
        var title = document.createElement('h4');
        title.textContent = store.title;
        var titleLink = document.createElement('a');
        titleLink.href = store.url;
        titleLink.appendChild(title);
        var li = document.createElement('li');
        li.className = 'search-list-li';
        li.appendChild(titleLink);
        li.appendChild(document.createElement('br'));

        // description if provided
        if (store.description !== null) {
          var description = document.createElement('p');
          description.appendChild(document.createTextNode(store.description));
          li.appendChild(description);
        }

        // separator
        var liSep = document.createElement('li');
        liSep.className = 'separator';
        liSep.appendChild(document.createElement('hr'));

        generated += [li, liSep].map((el) => el.outerHTML).join('');
      });

      return generated + '</ul>';
    };

    this.uniqueResults = function (results) {
      var uniqueResults = [];
      var titles = [];
      [].forEach.call(results, function (el) {
        if (titles.indexOf(lunrData.docs[el.ref].title) === -1) {
          titles.push(lunrData.docs[el.ref].title);
          uniqueResults.push(el);
        }
      });
      return uniqueResults;
    };

    this.initializePopoverEvents = function () {
      var self = this;

      this.searchInput.addEventListener('keydown', function (e) {
        if (e.which == 27) return self.hidePopover(); // esc key
      });
      this.searchInput.addEventListener('input', function (e) {
        var text = this.value;
        self.processText(text);
      });
      this.searchInput.addEventListener('focus', function (e) {
        var text = this.value;
        if (text === '') return;

        self.showPopover(text);
      });
      this.searchInput.addEventListener('shown.bs.popover', function () {
        self.popoverHandler = document.querySelector(self.POPOVER_CLASS);
        self.popoverHandler.addEventListener('click', function (e) {
          e.stopPropagation();
        });
        self.searchArrows.init();
      });
      this.searchInput.addEventListener('click', function (e) {
        e.stopPropagation();
      });
      window.addEventListener('click', self.hidePopover.bind(self));
    };
  });

  Search.prototype.init = function () {
    this.searchInput = document.querySelector(this.SEARCH_INPUT_ID);
    this.searchArrows = new SearchArrows();
    this.initializePopoverEvents();
    this.initializePopover();
  };

  Search.prototype.getPopoverContent = function () {
    return this.popoverContent;
  };
})();
