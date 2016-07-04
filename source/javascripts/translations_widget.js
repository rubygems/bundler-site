'use strict';

(function() {
  var TranslationWidget = window.TranslationWidget = function()  {
    this.TRANSLATIONS_BAR_ID = '#translations-bar';
    this.LANGUAGE_LINK_ID = '#language-link';
    this.LANGUAGE_LINK_STATIC_ID = '#language-link-static';
    this.DISMISS_BUTTON_ID = '#translations-bar-close';
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
      return '/' + this.browserLanguage + location.pathname;
    };

    this.switchToLanguageUsingCookies = function()  {
      window.location.href = this.languagePathFromCookies();
    };

    this.languagePathFromCookies = function() {
      return '/' + this.cookiesManager.choosenLanguage() + location.pathname;
    };

    this.checkChoosenLanguage = function() {
      return (this.choosenLanguage != null) && (CURRENT_LANGUAGE != this.choosenLanguage) &&
        (this.choosenLanguage in LANGUAGES);
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
})();

window.translationWidget = new TranslationWidget();
translationWidget.checkChoosenLanguageAndRedirect();

$(document).ready(function()  {
  translationWidget.init();
});
