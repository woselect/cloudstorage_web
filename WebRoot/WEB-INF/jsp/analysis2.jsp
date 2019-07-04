<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<meta charset="utf-8">
<title>bar</title>
<style>
p{
    color:white;
}
</style>
<body>

<link rel="stylesheet" href="assets/stylesheets/xcharts.min.css">
<script src="assets/javascripts/jquery.min.js"></script>
<script src="assets/javascripts/d3.min.js"></script>
<script src="assets/javascripts/xcharts.min.js"></script>
<figure style="height: 500px" id="chart"></figure>

<script>
(function () {

	
		
			var data = {
					  "xScale": "ordinal",
					  "yScale": "linear",
					  "main": [
					    {
					      "className": ".pizza",
					      "data": [{"y":3963,"x":"宝玉:3963"},{"y":2453,"x":"笑道:2453"},{"y":1903,"x":"太太:1903"},{"y":1731,"x":"凤姐:1731"},{"y":1643,"x":"贾母:1643"},{"y":1532,"x":"一个:1532"},{"y":1457,"x":"夫人:1457"},{"y":1446,"x":"也不:1446"},{"y":1372,"x":"黛玉:1372"},{"y":1220,"x":"我们:1220"}]					    }
					  ]
					};
			
					var myChart = new xChart('bar', data, '#chart');
		
	

}());

</script>
</body>