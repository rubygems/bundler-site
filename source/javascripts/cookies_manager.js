'use strict';

(function() {
  var CookiesManager = window.CookiesManager = function() {
    this.DISMISSED_KEY = 'dismissed';
    this.LANGUAGE_KEY = 'language';
    this.TRUE = 'true';
  };

  CookiesManager.prototype.set = function(name, value) {
    return Cookies.set(name, value, { expires: 365*10 });
  };

  CookiesManager.prototype.remove = function(name)  {
    return Cookies.remove(name);
  };

  CookiesManager.prototype.get = function(name)  {
    return Cookies.get(name);
  };

  CookiesManager.prototype.setDismiss = function()  {
    return this.set(this.DISMISSED_KEY, this.TRUE);
  };

  CookiesManager.prototype.isDismissed = function() {
    return this.get(this.DISMISSED_KEY) === this.TRUE;
  };

  CookiesManager.prototype.choosenLanguage = function() {
    return this.get(this.LANGUAGE_KEY);
  };
  
  CookiesManager.prototype.setLanguage = function(language) {
    return this.set(this.LANGUAGE_KEY, language);
  };
})();