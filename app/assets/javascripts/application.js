// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
	$(".headerwa").click(function(){
	    var header = $(this);
	    //getting the next element
	    var content = header.next();
	    console.log(content);
	    //open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
	    content.slideToggle(500, function () {
	        //execute this after slideToggle is done
	        //change text of header based on visibility of content div
	        header.text(function () {
	            //change text based on condition
	            return content.is(":visible") ? "Click here to Hide custom option" : "Click here to Show custom option";
	        });
	    });

	});
});