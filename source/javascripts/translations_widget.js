'use strict';

(function() {
  var TranslationWidget = window.TranslationWidget = function()  {
    this.TRANSLATIONS_BAR_ID = '#translations-bar';
    this.LANGUAGE_LINK_ID = '#language-link';
    this.LANGUAGE_LINK_STATIC_ID = '#language-link-static';
    this.DISMISS_BUTTON_ID = '#translations-bar-close';
    this.LANGUAGE_SELECT_ID = '#language-select';
    this.LINK_REGEX = /^\/[a-zA-Z]{2}(\/.*)/;
    this.cookiesManager = new CookiesManager();
    this.choosenLanguage = this.cookiesManager.choosenLanguage();

    this.detectLanguage = function()  {
      var lang = window.navigator.languages ? window.navigator.languages[0] : null;
      lang = lang || window.navigator.language || window.navigator.browserLanguage || window.navigator.userLanguage;
      if (lang.indexOf('-') !== -1) return lang.split('-')[0];
      if (lang.indexOf('_') !== -1) return lang.split('_')[0];
      return lang;
    };

    this.initElements = function() {
      this.translationBar = $(this.TRANSLATIONS_BAR_ID);
      this.link = $(this.LANGUAGE_LINK_ID);
      this.staticLink = $(this.LANGUAGE_LINK_STATIC_ID);
      this.dismissButton = $(this.DISMISS_BUTTON_ID);
    };

    this.initWidget = function()  {
      this.setRedirectButtons();
      this.initDismissButton();
      this.translationBar.slideDown(1000);
    };

    this.initDismissButton = function() {
      var self = this;

      this.dismissButton.click(function(e)  {
        e.preventDefault();
        self.translationBar.slideUp(1000);
        self.cookiesManager.setDismiss();
      });
    };

    this.setRedirectButtons = function()  {
      this.link.click(this.switchToLanguageAndSaveCookies.bind(this));
      this.staticLink.click(this.switchToLanguageAndSaveCookies.bind(this));
      this.link.text(LANGUAGES[this.browserLanguage]);
    };

    this.switchToLanguageAndSaveCookies = function(e)  {
      e.preventDefault();
      this.cookiesManager.setLanguage(this.browserLanguage);
      window.location.href = this.languagePath();
    };

    this.languagePath = function()  {
      var language = (this.browserLanguage == 'en' ? '' : ('/' + this.browserLanguage));
      return language + this.pathname();
    };

    this.switchToLanguageUsingCookies = function()  {
      window.location.href = this.languagePathFromCookies();
    };

    this.languagePathFromCookies = function() {
      var language = (this.cookiesManager.choosenLanguage() == 'en' ? '' : ('/' + this.cookiesManager.choosenLanguage()));
      return language + this.pathname();
    };

    this.checkChoosenLanguage = function() {
      return (this.choosenLanguage != null) && (CURRENT_LANGUAGE != this.choosenLanguage) &&
        (this.choosenLanguage in LANGUAGES);
    };

    this.pathname = function()  {
      var url_without_language = location.pathname.match(this.LINK_REGEX);
      return url_without_language != null ? url_without_language[1] : location.pathname;
    }
  };

  TranslationWidget.prototype.init = function()  {
    if (CURRENT_LANGUAGE == null || CURRENT_LANGUAGE === '')  return;
    if (LANGUAGES == null || LANGUAGES === '')  return;

    // checks from cookies
    if (this.cookiesManager.isDismissed()) return;

    // language detection
    this.browserLanguage = this.detectLanguage();
    if (CURRENT_LANGUAGE === this.browserLanguage) return;
    if (!(this.browserLanguage in LANGUAGES)) return;

    this.initElements();
    this.initWidget();
  };

  TranslationWidget.prototype.checkChoosenLanguageAndRedirect = function()  {
    if (CURRENT_LANGUAGE == null || CURRENT_LANGUAGE === '')  return;
    if (LANGUAGES == null || LANGUAGES === '')  return;

    if (this.checkChoosenLanguage()) {
      return this.switchToLanguageUsingCookies();
    }
  };

  TranslationWidget.prototype.initLanguageSelect = function()  {
    var self = this;
    this.languageSelect = $(this.LANGUAGE_SELECT_ID);

    this.languageSelect.change(function() {
      var optionSelected = $(this).find("option:selected");
      var valueSelected  = optionSelected.val();

      self.cookiesManager.setDismiss();
      self.cookiesManager.setLanguage(valueSelected);
      self.switchToLanguageUsingCookies();
    })
  };
})();

window.translationWidget = new TranslationWidget();
translationWidget.checkChoosenLanguageAndRedirect();

$(document).ready(function()  {
  translationWidget.initLanguageSelect();
  translationWidget.init();
});
