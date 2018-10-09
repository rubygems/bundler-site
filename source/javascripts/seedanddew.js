var SeedAndDewConfig = {};
(function() {
  SeedAndDewConfig['adClass'] = "snd-ad";
  SeedAndDewConfig['projectId'] = '5e00460b-8b80-4f56-a4b4-f39c46d83397';
  SeedAndDewConfig['loadStartTime'] = performance.now();
  SeedAndDewConfig['apiVersion'] = '2018-05-28'
  SeedAndDewConfig['sessionId'] = Math.random().toString(36).substring(2, 15);
  var snd = document.createElement('script');
  snd.type = 'text/javascript';
  snd.async = true;
  snd.src = 'https://www.seedanddew.com/static/embed.min.js';
  (document.getElementsByTagName('head')[0] ||
  document.getElementsByTagName('body')[0]).appendChild(snd);
})();
