
$(function(){
	/********** Main News Slider **********/	   
	$('#slides1').bxSlider({
		prev_image: '/html/scripts/images/btn_arrow_left.png',
		next_image: '/html/scripts/images/btn_arrow_right.png',
		wrapper_class: 'slides1_wrap',
		/*margin: 70,*/
		speed: 1000,
		pause: 5000,
		auto: true,
		auto_controls: true
	});
	
	/********** News Ticker **********/
	$('#js-news').ticker();	
	/*$('#js-news').ticker(
	    speed: 0.10,           // The speed of the reveal
        ajaxFeed: false,       // Populate jQuery News Ticker via a feed
        feedUrl: false,        // The URL of the feed
	                       // MUST BE ON THE SAME DOMAIN AS THE TICKER
        feedType: 'xml',       // Currently only XML
        htmlFeed: true,        // Populate jQuery News Ticker via HTML
        debugMode: true,       // Show some helpful errors in the console or as alerts
  	                       // SHOULD BE SET TO FALSE FOR PRODUCTION SITES!
        controls: true,        // Whether or not to show the jQuery News Ticker controls
        titleText: 'Latest',   // To remove the title set this to an empty String
        displayType: 'reveal', // Animation type - current options are 'reveal' or 'fade'
        direction: 'ltr'       // Ticker direction - current options are 'ltr' or 'rtl'
        pauseOnItems: 2000,    // The pause on a news item before being replaced
        fadeInSpeed: 600,      // Speed of fade in animation
        fadeOutSpeed: 300      // Speed of fade out animation					
	);*/
	/*$("#ticker").bxSlider({
		ticker: true,
    	tickerSpeed: 2500
	});*/
	
	/********** Tabs **********/
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});
	
	/********** Categories Navigation **********/
		$("ul#topnav li").hover(function() { //Hover over event on list item
		$(this).css({ 'background' : '#1376c9 url(topnav_active.gif) repeat-x'}); //Add background color and image on hovered list item
		//$(this).css({ 'background-color' : '#B64926'}); //Add background color and image on hovered list item
		$(this).find("span").show(); //Show the subnav
	} , function() { //on hover out...
		$(this).css({ 'background' : 'none'}); //Ditch the background
		$(this).find("span").hide(); //Hide the subnav
	});


});