///<reference path="../../../../../src/m18web/j/lib/jquery-1.3.2.js"/>
//Slidebox plugin for m18.com-levin 090623
; (function($) {

	//Attach this new method to jQuery
	$.fn.extend({

		//This is where you write your plugin's name
		slidebox: function(urOpts) {
			var defaultOpts = { interval: 10000, fadeInTime: 300, fadeOutTime: 200 };
			urOpts = $.extend({}, defaultOpts, urOpts);
			var interval = urOpts.interval;
			var fadeInTime = urOpts.fadeInTime;
			var fadeOutTime = urOpts.fadeOutTime;
			//Iterate over the current set of matched elements
			return this.each(function(i) {
				var _titles = $("ul.slide-txt li", this);
				var _titles_bg = $("ul.op li", this);
				var _bodies = $("ul.slide-pic li", this);
				var _count = _titles.length;
				var _current = 0;
				var _intervalID = null;
				var stop = function() { window.clearInterval(_intervalID); };
				var slide = function(opts) {
					if (opts) {
						_current = opts.current || 0;
					} else {
						_current = (_current >= (_count - 1)) ? 0 : (++_current);
					};
					_bodies.filter(":visible").fadeOut(fadeOutTime, function() {
						_bodies.eq(_current).fadeIn(fadeInTime);
						_bodies.removeClass("cur").eq(_current).addClass("cur");
					});
					_titles.removeClass("cur").eq(_current).addClass("cur");
					_titles_bg.removeClass("cur").eq(_current).addClass("cur");
				}; //endof slide
				var go = function() {
					_intervalID = window.setInterval(function() { slide(); }, interval);
				}; //endof go
				var itemMouseOver = function(target, items) {
					stop();
					var i = $.inArray(target, items);
					slide({ current: i });
				}; //endof itemMouseOver
				_titles.hover(function() { if($(this).attr('class')!='cur'){itemMouseOver(this, _titles); }else{stop();}}, go);
				//_titles_bg.hover(function() { itemMouseOver(this, _titles_bg); }, go);
				_bodies.hover(stop, go);
				//trigger the slidebox
				go();
			});
		}
	});

	//pass jQuery to the function, 
	//So that we will able to use any valid Javascript variable name 
	//to replace "$" SIGN. But, we'll stick to $ (I like dollar sign: ) )		
})(jQuery);

$(document).ready(function() {
	jQuery("div.slides").slidebox();
});


$(document).ready(function() {
   function myRandom(iStart,iLast){   
	   var iLength = iLast-iStart+1;   
		return Math.floor(Math.random()*iLength+iStart);   
	   }
	function slide(){
		jQuery('#crecom ul li:first').slideUp(300,function(){$(this).show().remove().appendTo('#crecom ul')});
		}
	var	i=myRandom(1,6);
	
	function goScroll(){
		slideInterval=window.setInterval(function(){slide()},3500);
		}
	jQuery('#crecom ul').hover(function(){window.clearInterval(slideInterval);},goScroll);
	goScroll();
})