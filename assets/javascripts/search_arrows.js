(function () {
  var SearchArrows = (window.SearchArrows = function () {
    this.LI_SELECTOR = '.search-list-li';
    this.ACTIVE_CLASS = 'active';
    this.active = false;
    this.currentSelection = null;
    this.selectedLi = null;

    this.onKeydown = function (e) {
      if (e.which === 40) {
        e.preventDefault();
        this.onDownArrow();
      } else if (e.which === 38) {
        e.preventDefault();
        this.onUpArrow();
      } else if (e.which === 13) {
        this.onEnter(e);
      }
    };
    this.onKeydownCb = this.onKeydown.bind(this);

    this.onUpArrow = function () {
      this.removeActiveClass();

      if (this.currentSelection === 0 || this.currentSelection == null)
        this.markLastItem();
      else {
        if (this.currentSelection === 0)
          this.currentSelection = this.listLength - 1;
        else this.currentSelection -= 1;

        this.selectedLi = this.list[this.currentSelection];
        this.selectedLi.classList.add(this.ACTIVE_CLASS);
      }
    };

    this.onDownArrow = function () {
      this.removeActiveClass();

      if (
        this.currentSelection === this.listLength - 1 ||
        this.currentSelection == null
      )
        this.markFirstItem();
      else {
        if (this.currentSelection === this.listLength - 1)
          this.currentSelection = 0;
        else this.currentSelection += 1;

        this.selectedLi = this.list[this.currentSelection];
        this.selectedLi.classList.add(this.ACTIVE_CLASS);
      }
    };

    this.onEnter = function () {
      window.location.href = this.selectedLi
        .querySelector('a')
        .getAttribute('href');
    };

    this.removeActiveClass = function () {
      if (this.selectedLi) this.selectedLi.classList.remove(this.ACTIVE_CLASS);
    };

    this.markFirstItem = function () {
      this.selectedLi = this.list[0];
      this.selectedLi.classList.add(this.ACTIVE_CLASS);
      this.currentSelection = 0;
    };

    this.markLastItem = function () {
      this.selectedLi = this.list[this.list.length - 1];
      this.selectedLi.classList.add(this.ACTIVE_CLASS);
      this.currentSelection = this.listLength - 1;
    };
  });

  SearchArrows.prototype.init = function () {
    if (this.isActive()) this.destroy();

    this.list = document.querySelectorAll(this.LI_SELECTOR);
    this.listLength = this.list.length;
    if (this.listLength === 0) return;

    window.addEventListener('keydown', this.onKeydownCb);
    this.active = true;
  };

  SearchArrows.prototype.destroy = function () {
    window.removeEventListener('keydown', this.onKeydownCb);
    this.active = false;
    this.currentSelection = null;
  };

  SearchArrows.prototype.isActive = function () {
    return this.active;
  };

  SearchArrows.prototype.isOneOfKeys = function (keyCode) {
    return [40, 38, 13].indexOf(keyCode) !== -1;
  };
})();
