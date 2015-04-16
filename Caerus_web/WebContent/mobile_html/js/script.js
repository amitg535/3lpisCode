$(document).ready(function(){

  $(".employer").click(function(){
	$(this).attr("src","../mobile_html/images/employer_reg_icn_hover.png");

});
  
  $(".candidate").click(function(){
		$(this).attr("src","../mobile_html/images/candidate_reg_icn_hove.png");

	}); 
  
}); 



/*customize radio and check box*/
var d = document;
var safari = (navigator.userAgent.toLowerCase().indexOf('safari') != -1) ? true : false;
var gebtn = function(parEl,child) { return parEl.getElementsByTagName(child); };
onload = function() {
    
    var body = gebtn(d,'body')[0];
    body.className = body.className && body.className != '' ? body.className + ' has-js' : 'has-js';
    
    if (!d.getElementById || !d.createTextNode) return;
    var ls = gebtn(d,'label');
    for (var i = 0; i < ls.length; i++) {
        var l = ls[i];
        if (l.className.indexOf('label_') == -1) continue;
        var inp = gebtn(l,'input')[0];
        if (l.className == 'label_check') {
            l.className = (safari && inp.checked == true || inp.checked) ? 'label_check c_on' : 'label_check c_off';
            l.onclick = check_it;
        };
        if (l.className == 'label_radio') {
            l.className = (safari && inp.checked == true || inp.checked) ? 'label_radio r_on' : 'label_radio r_off';
            l.onclick = turn_radio;
        };
    };
};





var check_it = function() {
    var inp = gebtn(this,'input')[0];
    if (this.className == 'label_check c_off' || (!safari && inp.checked)) {
        this.className = 'label_check c_on';
        if (safari) inp.click();
    } else {
        this.className = 'label_check c_off';
        if (safari) inp.click();
    };
};
var turn_radio = function() {
    var inp = gebtn(this,'input')[0];
    if (this.className == 'label_radio r_off' || inp.checked) {
        var ls = gebtn(this.parentNode,'label');
        for (var i = 0; i < ls.length; i++) {
            var l = ls[i];
            if (l.className.indexOf('label_radio') == -1)  continue;
            l.className = 'label_radio r_off';
        };
        this.className = 'label_radio r_on';
        if (safari) inp.click();
    } else {
        this.className = 'label_radio r_off';
        if (safari) inp.click();
    };
};


/* Show placeholder for input type date starts */
function initOverLabels () {
	  if (!document.getElementById) return;      

	  var labels, id, field;

	  // Set focus and blur handlers to hide and show 
	  // LABELs with 'overlabel' class names.
	  labels = document.getElementsByTagName('label');
	  for (var i = 0; i < labels.length; i++) {
	    
	    if (labels[i].className == 'overlabel') {

	      // Skip labels that do not have a named association
	      // with another field.
	      id = labels[i].htmlFor || labels[i].getAttribute('for');
	      if (!id || !(field = document.getElementById(id))) {
	        continue;
	      }

	      // Change the applied class to hover the label 
	      // over the form field.
	      labels[i].className = 'overlabel-apply';

	      // Hide any fields having an initial value.
	      if (field.value !== '') {
	        hideLabel(field.getAttribute('id'), true);
	      }

	      // Set handlers to show and hide labels.
	      field.onfocus = function () {
	        hideLabel(this.getAttribute('id'), true);
	      };
	      field.onblur = function () {
	        if (this.value === '') {
	          hideLabel(this.getAttribute('id'), false);
	        }
	      };

	      // Handle clicks to LABEL elements (for Safari).
	      labels[i].onclick = function () {
	        var id, field;
	        id = this.getAttribute('for');
	        if (id && (field = document.getElementById(id))) {
	          field.focus();
	        }
	      };

	    }
	  }
	};

/* Show placeholder for input type date ends */