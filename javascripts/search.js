var lunrIndex=null,lunrData=null,search=null;$(document).ready(function(){$.ajax({url:"/search/lunr-index.json",cache:!0,method:"GET",success:function(t){lunrData=t,lunrIndex=lunr.Index.load(lunrData.index),search=new Search,search.init()}})}),function(){var t=window.Search=function(){this.SEARCH_INPUT_ID="#input-search",this.POPOVER_CLASS=".popover",this.POPOVER_OPTIONS={html:!0,container:"body",placement:"bottom",trigger:"manual",content:function(){return search.getPopoverContent()}},this.LIMIT_RESULTS=10,this.popoverContent="",this.popoverHandler=null,this.processText=function(t){if(!t||""===t)return this.hidePopover();this.showPopover(t)},this.initializePopover=function(){this.popover=this.searchInput.popover(this.POPOVER_OPTIONS).data("bs.popover")},this.hidePopover=function(){this.popover.options.animation=!0,this.searchInput.popover("hide"),this.searchArrows.destroy()},this.showPopover=function(t){this.popoverContent=this.generatePopoverContent(t),this.searchInput.popover("show")},this.generatePopoverContent=function(t){var n=lunrIndex.search(t);if(!n.length)return"No results found";n=n.slice(0,this.LIMIT_RESULTS);var e=this.uniqueResults(n),o='<ul class="search-list-ul">';return e.forEach(function(t){var n=lunrData.docs[t.ref],e=null==n.description?"":$("<p>").text(n.description),r=$("<div>").html($('<li class="search-list-li">').html($("<a>").attr("href",n.url).html("<h4>"+n.title+"</h4>").append($("<br />"))).append(e).append($("<li>").attr("class","separator").html($("<hr />"))));o+=r.html()}),o+"</ul>"},this.uniqueResults=function(t){var n=[],e=[];return $.each(t,function(t,o){-1===$.inArray(lunrData.docs[o.ref].title,e)&&(e.push(lunrData.docs[o.ref].title),n.push(o))}),n},this.initializePopoverEvents=function(){var t=this;this.searchInput.on("paste keyup",function(n){if(!t.searchArrows.isOneOfKeys(n.which)){if(27==n.which)return t.hidePopover();var e=$(this).val();t.processText(e)}}),this.searchInput.focus(function(){var n=$(this).val();""!==n&&t.showPopover(n)}),this.searchInput.on("shown.bs.popover",function(){t.popoverHandler=$(t.POPOVER_CLASS),t.popover.options.animation=!1,t.popoverHandler.click(function(t){t.stopPropagation()}),t.searchArrows.init()}),this.searchInput.click(function(t){t.stopPropagation()}),$(window).click(function(){t.hidePopover()})}};t.prototype.init=function(){this.searchInput=$(this.SEARCH_INPUT_ID),this.searchArrows=new SearchArrows,this.initializePopoverEvents(),this.initializePopover()},t.prototype.getPopoverContent=function(){return this.popoverContent}}();