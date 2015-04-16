// JavaScript Document
$(document).ready(function () {

    $("#employersselection").hide();


    $('#register').click(function () {
        $("#employersselection").slideToggle();
    });

});

var require = function (jsfile) {
    var ary = document.getElementsByTagName('script');
    for (var i = 0; i < ary.length; i++) {
        if (ary[i].getAttribute('src').match(/\.js$/)) {
            var jspath = ary[i].getAttribute('src').match(/.+\//);
        }
    }
    var elem = document.createElement('script');
    elem.setAttribute('type', 'text/javascript');
    elem.setAttribute('src', jspath + jsfile);
    document.getElementsByTagName('head')[0].appendChild(elem);
}


$(document).ready(function(){
	// Smart Wizard 	
	$('#wizard').smartWizard();
	
  function onFinishCallback(){
	$('#wizard').smartWizard('showMessage','Finish Clicked');
  }     
	});

// Add the following
/*require('jquery.min.js');
require('jquery.flexslider-min.js');
require('jquery.tinycarousel.js');
require('carousal.js');
require('cufon-yui.js');
require('Myriad_Pro_300.font.js');
require('cufon_fonts.js');*/
