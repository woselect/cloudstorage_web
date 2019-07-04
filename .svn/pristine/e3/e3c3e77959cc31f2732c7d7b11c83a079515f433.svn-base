$(document).ready(function() {
	// À©ÈÝ´°¿ÚÏÔÊ¾
	$(".capacity").click(function() {
		$(".lightboxOverlay").fadeIn();
		$(".lightbox1").fadeIn();
	});
	$(".lb-close").click(function() {
		$(".lightboxOverlay").fadeOut();
		$(".lightbox1").fadeOut();
	});
});

// ËÑË÷
function searchfile() {
	var key = $("#navbarInput-01").val();
	$("#searchfiles").attr("href", "search.action?key=" + key);
}

// À©ÈÝ
function buycapacity() {
	var addcapacity = parseInt($("#addcapacity").val());
	var data = {
		capacity : addcapacity
	};
	$.ajax({
		url : "addcapacity.action",
		type : "post",
		data : data,
		success : function(s) {

			location.reload();

		}
	});
}