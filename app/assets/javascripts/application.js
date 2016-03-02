//= require jquery
//= require jquery_ujs
//= require patient_messages.js

$(document).ready(function() {
    
    var menuToggle = $('#js-mobile-menu').unbind();

    //button redirects to top of page
    $('.top').on('click',function () {
        $("html, body").animate({ scrollTop: 0 }, "slow");
	});
    
    
    //toggle for mobile menu click
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
