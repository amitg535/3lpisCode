
jQuery(document).ready(function () {

    var rightpanelmargin = '260px';
    Modernizr.Detectizr.detect();


    prettyPrint(); //syntax highlighter
    mainwrapperHeight();
    responsive();


    // animation
    if (jQuery('.contentinner').hasClass('content-dashboard')) {

        jQuery('.datewidget').addClass('animate1 fadeInUp');

    }



    // adjust height of mainwrapper when 
    // it's below the document height

    function mainwrapperHeight() {
        var windowHeight = jQuery(window).height();
        var mainWrapperHeight = jQuery('.mainwrapper').height();
        var leftPanelHeight = jQuery('.leftpanel').height();
        if (leftPanelHeight > mainWrapperHeight)
            jQuery('.mainwrapper').css({
                minHeight: leftPanelHeight
            });
        if (jQuery('.mainwrapper').height() < windowHeight)
            jQuery('.mainwrapper').css({
                minHeight: windowHeight
            });
    }

    function responsive() {

        var windowWidth = jQuery(window).width();

        // hiding and showing left menu
        if (!jQuery('.showmenu').hasClass('clicked')) {

            if (windowWidth < 960)
                hideLeftPanel();
            else
                showLeftPanel();
        }

        // rearranging widget icons in dashboard
        if (windowWidth < 768) {
            if (jQuery('.widgeticons .one_third').length == 0) {
                var count = 0;
                jQuery('.widgeticons li').each(function () {
                    jQuery(this).removeClass('one_fifth last').addClass('one_third');
                    if (count == 2) {
                        jQuery(this).addClass('last');
                        count = 0;
                    } else {
                        count++;
                    }
                });
            }
        } else {
            if (jQuery('.widgeticons .one_firth').length == 0) {
                var count = 0;
                jQuery('.widgeticons li').each(function () {
                    jQuery(this).removeClass('one_third last').addClass('one_fifth');
                    if (count == 4) {
                        jQuery(this).addClass('last');
                        count = 0;
                    } else {
                        count++;
                    }
                });
            }
        }
    }

    // when resize window event fired
    jQuery(window).resize(function () {
        mainwrapperHeight();
        responsive();
    });






    // show left panel

    function showLeftPanel() {
        jQuery('.leftpanel').css({
            marginLeft: '0px'
        }).removeClass('hide');
        jQuery('.rightpanel').css({
            marginLeft: rightpanelmargin
        });
        jQuery('.mainwrapper').css({
            backgroundPosition: '0 0'
        });
        jQuery('.footerleft').show();
        jQuery('.footerright').css({
            marginLeft: rightpanelmargin
        });
    }



    // transform checkbox and radio box using uniform plugin
    if (jQuery().uniform)
        jQuery('input:checkbox, input:radio, select.uniformselect').uniform();


    // show/hide widget content or widget content's child	
    if (jQuery('.showhide').length > 0) {
        jQuery('.showhide').click(function () {
            var t = jQuery(this);
            var p = t.parent();
            var target = t.attr('href');
            target = (!target) ? p.next() : p.next().find('.' + target);
            t.text((target.is(':visible')) ? 'View Source' : 'Hide Source');
            (target.is(':visible')) ? target.hide() : target.show(100);
            return false;
        });
    }


    // check all checkboxes in table
    if (jQuery('.checkall').length > 0) {
        jQuery('.checkall').click(function () {
            var parentTable = jQuery(this).parents('table');
            var ch = parentTable.find('tbody input[type=checkbox]');
            if (jQuery(this).is(':checked')) {

                //check all rows in table
                ch.each(function () {
                    jQuery(this).attr('checked', true);
                    jQuery(this).parent().addClass('checked'); //used for the custom checkbox style
                    jQuery(this).parents('tr').addClass('selected'); // to highlight row as selected
                });


            } else {

                //uncheck all rows in table
                ch.each(function () {
                    jQuery(this).attr('checked', false);
                    jQuery(this).parent().removeClass('checked'); //used for the custom checkbox style
                    jQuery(this).parents('tr').removeClass('selected');
                });

            }
        });
    }


    // delete row in a table
    if (jQuery('.deleterow').length > 0) {
        jQuery('.deleterow').click(function () {
            var conf = confirm('Continue delete?');
            if (conf)
                jQuery(this).parents('tr').fadeOut(function () {
                    jQuery(this).remove();
                    // do some other stuff here
                });
            return false;
        });
    }


    // dynamic table
    if (jQuery('#dyntable').length > 0) {
        jQuery('#dyntable').dataTable({
            "sPaginationType": "full_numbers",
            "aaSortingFixed": [
                [0, 'asc']
            ],
            "fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
        });
    }
	
	
    if (jQuery('#dyntable1').length > 0) {
        jQuery('#dyntable1').dataTable({
            "sPaginationType": "full_numbers",
            "aaSortingFixed": [
                [0, 'asc']
            ],
            "fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
        });
    }
	
	  if (jQuery('#dyntable_columntwo').length > 0) {
        jQuery('#dyntable_columntwo').dataTable({
            "sPaginationType": "full_numbers",
			"aaSorting": [[ 1, "desc" ]],
			"aoColumns": [
				null,
				null,
				null,
				null,
				null
			],
           
			"fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
        });
    }
	
	  if (jQuery('#dyntable_columnthree').length > 0) {
        jQuery('#dyntable_columnthree').dataTable({
            "sPaginationType": "full_numbers",
			"aaSorting": [[ 2, "desc" ]],
			"aoColumns": [
				null,
				null,
				null,
				null,
				null
			],
           
			"fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
        });
    }
	
	 if (jQuery('#dyntable_four').length > 0) {
        jQuery('#dyntable_four').dataTable({
            "sPaginationType": "full_numbers",
			"aaSorting": [[ 3, "desc" ]],
			"aoColumns": [
				null,
				null,
				null,
				null,
				null,
				null
			],
           
			"fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
        });
    }
	 
	 if (jQuery('#dyntable_five').length > 0) {
	        jQuery('#dyntable_five').dataTable({
	            "sPaginationType": "full_numbers",
				"aaSorting": [[ 3, "desc" ]],
				"aoColumns": [
					null,
					null,
					null,
					null
			
				],
	           
				"fnDrawCallback": function (oSettings) {
	                jQuery.uniform.update();
	            }
	        });
	    }
	
	
	
	
	
	if (jQuery('#dyntable2').length > 0) {
        jQuery('#dyntable2').dataTable({
            "sPaginationType": "full_numbers",
			"aaSorting": [ [2,'asc'] ],
			 "fnDrawCallback": function (oSettings) {
                jQuery.uniform.update();
            }
		});
		
		
		
	}
	

if (jQuery('#scrollable').length > 0) {
        jQuery('#scrollable').dataTable({
           	"sScrollY": 200,
			"bJQueryUI": true,
			"bScrollCollapse": true,
		});
		
		
		
	}
	


    /////////////////////////////// ELEMENTS.HTML //////////////////////////////


    // tabbed widget
    jQuery('#tabs, #tabs2').tabs();

    // accordion widget
    jQuery('#accordion').accordion({
        heightStyle: "content"
    });
	
	  jQuery('#accordion1').accordion({
        heightStyle: "content",
    });

	

    // date picker
    if (jQuery('#datepicker1').length > 0)
        jQuery("#datepicker1").datepicker();
		
	if (jQuery('#datepicker2').length > 0)
        jQuery("#datepicker2").datepicker();

 if (jQuery('#datepicker3').length > 0)
        jQuery("#datepicker3").datepicker();
		
	if (jQuery('#datepicker4').length > 0)
        jQuery("#datepicker4").datepicker();


 if (jQuery('#datepicker5').length > 0)
        jQuery("#datepicker5").datepicker();
		
	if (jQuery('#datepicker6').length > 0)
        jQuery("#datepicker6").datepicker();




    // sortable list
    if (jQuery('#sortable').length > 0)
        jQuery("#sortable").sortable();

    // sortable list with content-->
    if (jQuery('#sortable2').length > 0) {
        jQuery("#sortable2").sortable();
        jQuery('.showcnt').click(function () {
            var t = jQuery(this);
            var det = t.parents('li').find('.details');
            if (!det.is(':visible')) {
                det.slideDown();
                t.removeClass('icon-plus-sign').addClass('icon-minus-sign');
            } else {
                det.slideUp();
                t.removeClass('icon-minus-sign').addClass('icon-plus-sign');
            }
        });
    }


});


jQuery(document).ready(function(){
	
	// Transform upload file
	jQuery('.uniform-file').uniform();
	
	// Dual Box Select
	var db = jQuery('#dualselect').find('.ds_arrow button');	//get arrows of dual select
	var sel1 = jQuery('#dualselect select:first-child');		//get first select element
	var sel2 = jQuery('#dualselect select:last-child');			//get second select element
	
	sel2.empty(); //empty it first from dom.
	
	db.click(function(){
		var t = (jQuery(this).hasClass('ds_prev'))? 0 : 1;	// 0 if arrow prev otherwise arrow next
		if(t) {
			sel1.find('option').each(function(){
				if(jQuery(this).is(':selected')) {
					jQuery(this).attr('selected',false);
					var op = sel2.find('option:first-child');
					sel2.append(jQuery(this));
				}
			});	
		} else {
			sel2.find('option').each(function(){
				if(jQuery(this).is(':selected')) {
					jQuery(this).attr('selected',false);
					sel1.append(jQuery(this));
				}
			});		
		}
		return false;
	});	
	
	//Tags Input
	jQuery('#tags').tagsInput();
	
	jQuery('#primarySkills').tagsInput();
		
	/***created by snehal***/
		jQuery('#tags1').tagsInput();
	/***created by snehal***/

	// Spinner
	jQuery(".month").spinner({min:1, max:12,increment:1});
	
	/***created by snehal***/
	jQuery(".year").spinner({min:1990, max:2013, increment:1});
	jQuery(".spinner3").spinner({min: 1990, max: 2014, increment: 2});
	/***created by snehal***/
	
	
	// Character Counter
	jQuery("#textarea2").charCount({
		allowed: 150,		
		warning: 20,
		counterText: 'Characters left: '	
	});
	jQuery("#textarea1").charCount({
		allowed:500,		
		warning: 20,
		counterText: 'Characters left: '	
	});
	
	// Select with Search
	jQuery(".chzn-select").chosen();
	
	
	// With Form Validation
	jQuery("#form1").validate({
		rules: {
			firstname: "required",
			lastname: "required",
			email: {
				required: true,
				email: true,
			},
			location: "required",
			selection: "required"
		},
		messages: {
			firstname: "Please enter your first name",
			lastname: "Please enter your last name",
			email: "Please enter a valid email address",
			location: "Please enter your location"
		},
		highlight: function(label) {
			jQuery(label).closest('.control-group').addClass('error');
	    },
	    success: function(label) {
	    	label
	    		.text('Ok!').addClass('valid')
	    		.closest('.control-group').addClass('success');
	    }
	});
	
	jQuery('#timepicker1').timepicker();
	jQuery('#timepicker2').timepicker();
		jQuery('#timepicker3').timepicker();
	jQuery('#timepicker4').timepicker();
		jQuery('#timepicker5').timepicker();
	jQuery('#timepicker6').timepicker();
	


});

