//= require jquery
//= require jquery_ujs
//= require patient_messages.js

$(document).ready(function() {
    //button redirects to top of page
    $('.top').on('click',function (e) {
	    e.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, "slow");
	});
    
    //changes the nav to fixed whenever user scrolls down past the nav
    
    var scrollTop     = $(window).scrollTop(),
  
    //toggle for mobile menu click
      var menuToggle = $('#js-mobile-menu').unbind();
    $('#js-navigation-menu').removeClass("show");
    menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle(function(){
      if($('#js-navigation-menu').is(':hidden')) {
        $('#js-navigation-menu').removeAttr('style');
      }
    });
  });
});
