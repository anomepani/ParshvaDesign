$(function () {
    $("#sidebar #main-nav li >a").click(function () {
       $("a").removeClass("current");
       $(this).addClass("current");
       $(this).find("li").find("a").addClass("current");
	   
	      });
});