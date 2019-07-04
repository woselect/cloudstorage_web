<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>pie</title>
  <meta charset="utf-8">

 <script src="assets/javascripts/jquery.min.js"></script>
  <script src="assets/javascripts/d3.min.js"></script>
  <script src="assets/javascripts/d3-transform.js"></script>  
  <script src="assets/javascripts/extarray.js"></script>
  <script src="assets/javascripts/misc.js"></script>
  <script src="assets/javascripts/micro-observer.js"></script>
  <script src="assets/javascripts/microplugin.js"></script>
  <script src="assets/javascripts/bubble-chart.js"></script>
  <script src="assets/javascripts/central-click.js"></script>
  <script src="assets/javascripts/lines.js"></script>
 <style>
    .bubbleChart {
      min-width: 100px;
      max-width: 700px;
      height: 700px;
      margin: 0 auto;
    }
    .bubbleChart svg{
      background: #ffffff;
    }
  </style>
</head>
<body style="background: #ffffff">
<div id="vis" style="margin: 0 auto;position: fixed;top: 35%; right: 40%;" ><img src="assets/images/analysis.gif" /></div>
<div class="bubbleChart"/>
<script>
(function () {
			var data=[{"text":"宝玉","count":3963},{"text":"笑道","count":2453},{"text":"太太","count":1903},{"text":"凤姐","count":1731},{"text":"贾母","count":1643},{"text":"一个","count":1532},{"text":"夫人","count":1457},{"text":"也不","count":1446},{"text":"黛玉","count":1372},{"text":"我们","count":1220}];
			 $("#vis").html("")
			  var bubbleChart = new d3.svg.BubbleChart({
				    supportResponsive: true,
				    size: 600,
				    innerRadius: 600 / 3.5,
				    radiusMin: 50,
				    data: {
				      items:data,
				      eval: function (item) {return item.count;},
				      classed: function (item) {return item.text.split(" ").join("");}
				    },
				    plugins: [
				      
				      {
				        name: "lines",
				        options: {
				          format: [
				            {// Line #0
				              textField: "count",
				              classed: {count: true},
				              style: {
				                "font-size": "28px",
				                "font-family": "Source Sans Pro, sans-serif",
				                "text-anchor": "middle",
				                fill: "white"
				              },
				              attr: {
				                dy: "0px",
				                x: function (d) {return d.cx;},
				                y: function (d) {return d.cy;}
				              }
				            },
				            {// Line #1
				              textField: "text",
				              classed: {text: true},
				              style: {
				                "font-size": "14px",
				                "font-family": "Source Sans Pro, sans-serif",
				                "text-anchor": "middle",
				                fill: "white"
				              },
				              attr: {
				                dy: "20px",
				                x: function (d) {return d.cx;},
				                y: function (d) {return d.cy;}
				              }
				            }
				          ],
				          centralFormat: [
				            {// Line #0
				              style: {"font-size": "50px"},
				              attr: {}
				            },
				            {// Line #1
				              style: {"font-size": "30px"},
				              attr: {dy: "40px"}
				            }
				          ]
				        }
				      }]
				  });
			
	
		}());</script>
</body>
</html>