import $ from 'jquery'
(function() {
  var SearchArrows = window.SearchArrows = function() {
    this.LI_SELECTOR = '.search-list-li';
    this.ACTIVE_CLASS = 'active';
    this.active = false;
    this.currentSelection = null;
    this.selectedLi = null;

    this.onKeydown = function(e)  {
      if (e.which === 40)  {
        e.preventDefault();
        this.onDownArrow();
      } else if (e.which === 38) {
        e.preventDefault();
        this.onUpArrow();
      } else if (e.which === 13)  {
        this.onEnter(e);
      }
    };

    this.onUpArrow = function() {
      this.removeActiveClass();

      if (this.currentSelection === 0 || this.currentSelection == null) this.markLastItem();
      else  {
        if (this.currentSelection === 0) this.currentSelection = this.listLength - 1;
        else this.currentSelection -= 1;

        this.selectedLi = this.list.eq(this.currentSelection).addClass(this.ACTIVE_CLASS);
      }
    };

    this.onDownArrow = function() {
      this.removeActiveClass();

      if (this.currentSelection === this.listLength - 1 || this.currentSelection == null) this.markFirstItem();
      else  {
        if (this.currentSelection === this.listLength - 1) this.currentSelection = 0;
        else this.currentSelection += 1;

        this.selectedLi = this.list.eq(this.currentSelection).addClass(this.ACTIVE_CLASS);
      }
    };

    this.onEnter = function() {
      window.location.href = this.selectedLi.find('a').attr('href');
    };

    this.removeActiveClass = function() {
      if (this.selectedLi) this.selectedLi.removeClass(this.ACTIVE_CLASS);
    };

    this.markFirstItem = function() {
      this.selectedLi = this.list.eq(0).addClass(this.ACTIVE_CLASS);
      this.currentSelection = 0;
    };

    this.markLastItem = function()  {
      this.selectedLi = this.list.last().addClass(this.ACTIVE_CLASS);
      this.currentSelection = this.listLength - 1;
    };
  };

  SearchArrows.prototype.init = function()  {
    if (this.isActive()) this.destroy();

    this.list = $(this.LI_SELECTOR);
    this.listLength = this.list.length;
    if (this.listLength === 0) return;

    $(window).keydown(this.onKeydown.bind(this));
    this.active = true;
  };

  SearchArrows.prototype.destroy = function() {
    $(window).unbind('keydown');
    this.active = false;
    this.currentSelection = null;
  };
  
  SearchArrows.prototype.isActive = function()  {
    return this.active;
  };

  SearchArrows.prototype.isOneOfKeys = function(keyCode) {
    return ($.inArray(keyCode, [40, 38, 13]) !== -1);
  }
})();
