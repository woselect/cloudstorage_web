<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Word Cloud</title>
		<style>
			body {
				position: relative;
				font-family: "Helvetica Neue", sans-serif;
				width: 960px;
				margin: auto;
				margin-bottom: 1em;
				margin-top: 20px;
			}
			
			#presets a {
				border-left: solid #666 1px;
				padding: 0 10px;
			}
			
			#presets a.first {
				border-left: none;
			}
			
			#keyword {
				width: 300px;
			}
			
			#fetcher {
				width: 500px;
			}
			
			#keyword,
			#go {
				font-size: 1.5em;
			}
			
			#text {
				width: 100%;
				height: 100px;
			}
			
			p.copy {
				font-size: small;
			}
			
			#form {
				font-size: small;
				position: relative;
			}
			
			hr {
				border: none;
				border-bottom: solid #ccc 1px;
			}
			
			a.active {
				text-decoration: none;
				color: #000;
				font-weight: bold;
				cursor: text;
			}
			
			#angles line,
			#angles path,
			#angles circle {
				stroke: #666;
			}
			
			#angles text {
				fill: #333;
			}
			
			#angles path.drag {
				fill: #666;
				cursor: move;
			}
			
			#angles {
				text-align: center;
				margin: 0 auto;
				width: 350px;
			}
			
			#angles input,
			#max {
				width: 42px;
			}
		</style>

		
	</head>

	<body>
		<script src="assets/javascripts/jquery.min.js"></script>
		<script src="assets/javascripts/d3.min.js"></script>
		<script src="assets/javascripts/d3.layout.cloud.js"></script>
		<script>
		    var data=[{"text":"宝玉","size":3963},{"text":"笑道","size":2453},{"text":"太太","size":1903},{"text":"凤姐","size":1731},{"text":"贾母","size":1643},{"text":"一个","size":1532},{"text":"夫人","size":1457},{"text":"也不","size":1446},{"text":"黛玉","size":1372},{"text":"我们","size":1220},{"text":"那里","size":1174},{"text":"袭人","size":1151},{"text":"姑娘","size":1125},{"text":"去了","size":1094},{"text":"不知","size":1076},{"text":"宝钗","size":1076},{"text":"王夫人","size":1076},{"text":"起来","size":1053},{"text":"听了","size":1050},{"text":"出来","size":1043},{"text":"来了","size":1041},{"text":"怎么","size":1029},{"text":"如今","size":1004},{"text":"丫头","size":993},{"text":"知道","size":982},{"text":"说道","size":973},{"text":"老太","size":972},{"text":"这里","size":935},{"text":"他们","size":895},{"text":"说着","size":894},{"text":"不是","size":891},{"text":"众人","size":875},{"text":"奶奶","size":852},{"text":"一面","size":835},{"text":"不得","size":805},{"text":"只见","size":789},{"text":"两个","size":780},{"text":"贾琏","size":771},{"text":"没有","size":768},{"text":"贾政","size":753},{"text":"这个","size":697},{"text":"听见","size":691},{"text":"进来","size":688},{"text":"老爷","size":646},{"text":"的人","size":630},{"text":"东西","size":610},{"text":"就是","size":603},{"text":"告诉","size":602},{"text":"姐儿","size":593},{"text":"姐姐","size":593},{"text":"回来","size":574},{"text":"见了","size":564},{"text":"不好","size":555},{"text":"出去","size":548},{"text":"只是","size":544},{"text":"姨妈","size":535},{"text":"只得","size":534},{"text":"说了","size":521},{"text":"不过","size":517},{"text":"不敢","size":514},{"text":"二爷","size":504},{"text":"过来","size":488},{"text":"个人","size":480},{"text":"人道","size":477},{"text":"的事","size":454},{"text":"也是","size":453},{"text":"的话","size":449},{"text":"我的","size":441},{"text":"来的","size":441},{"text":"探春","size":440},{"text":"不能","size":439},{"text":"一时","size":438},{"text":"紫鹃","size":436},{"text":"这么","size":433},{"text":"鸳鸯","size":426},{"text":"如此","size":423},{"text":"我也","size":423},{"text":"说的","size":415},{"text":"叫他","size":412},{"text":"心里","size":411},{"text":"这一","size":411},{"text":"湘云","size":410},{"text":"又不","size":405},{"text":"妹妹","size":401},{"text":"婆子","size":396},{"text":"罢了","size":391},{"text":"贾珍","size":388},{"text":"都是","size":380},{"text":"今日","size":375},{"text":"是我","size":373},{"text":"人家","size":372},{"text":"几个","size":370},{"text":"一回","size":369},{"text":"在这","size":368},{"text":"是个","size":368},{"text":"李纨","size":368},{"text":"银子","size":366},{"text":"答应","size":360},{"text":"二人","size":359},{"text":"还有","size":359},{"text":"说话","size":357},{"text":"会子","size":344},{"text":"只管","size":343},{"text":"尤氏","size":343},{"text":"晴雯","size":341},{"text":"好了","size":340},{"text":"里的","size":333},{"text":"那边","size":330},{"text":"也有","size":329},{"text":"在那","size":329},{"text":"媳妇","size":328},{"text":"他的","size":326},{"text":"姥姥","size":319},{"text":"这是","size":319},{"text":"这话","size":318},{"text":"外头","size":317},{"text":"屋里","size":316},{"text":"打发","size":310},{"text":"自然","size":309},{"text":"不用","size":307},{"text":"听说","size":305},{"text":"吃了","size":300},{"text":"今儿","size":299},{"text":"刘姥姥","size":293},{"text":"那些","size":293},{"text":"如何","size":292},{"text":"那一","size":290},{"text":"小丫头","size":287},{"text":"也没","size":286},{"text":"问道","size":286},{"text":"薛蟠","size":285},{"text":"到了","size":282},{"text":"有什么","size":282},{"text":"林黛玉","size":280},{"text":"进去","size":278},{"text":"看见","size":276},{"text":"一声","size":270},{"text":"回去","size":270},{"text":"还不","size":269},{"text":"原来","size":267},{"text":"是他","size":267},{"text":"有人","size":267},{"text":"香菱","size":267},{"text":"好的","size":264},{"text":"又说","size":262},{"text":"上来","size":261},{"text":"孩子","size":260},{"text":"这会","size":260},{"text":"是不","size":259},{"text":"家里","size":258},{"text":"不成","size":257},{"text":"不在","size":256},{"text":"我说","size":256},{"text":"给他","size":256},{"text":"姊妹","size":255},{"text":"有了","size":254},{"text":"一句","size":253},{"text":"死了","size":253},{"text":"到底","size":249},{"text":"又是","size":248},{"text":"的是","size":246},{"text":"过去","size":244},{"text":"里头","size":244},{"text":"在家","size":243},{"text":"是你","size":242},{"text":"别人","size":241},{"text":"明儿","size":239},{"text":"你的","size":238},{"text":"叫人","size":238},{"text":"心中","size":235},{"text":"丫鬟","size":234},{"text":"明白","size":233},{"text":"姨娘","size":232},{"text":"方才","size":232},{"text":"哥哥","size":231},{"text":"连忙","size":231},{"text":"说是","size":230},{"text":"麝月","size":230},{"text":"贾蓉","size":229},{"text":"还是","size":228},{"text":"一日","size":224},{"text":"一件","size":223},{"text":"来说","size":223},{"text":"身上","size":223},{"text":"只有","size":222},{"text":"小厮","size":222},{"text":"不如","size":220},{"text":"带了","size":220},{"text":"果然","size":219},{"text":"起身","size":219},{"text":"又有","size":218},{"text":"叫我","size":218},{"text":"意思","size":218},{"text":"于是","size":217},{"text":"我不","size":216},{"text":"怎么样","size":213},{"text":"那个","size":212},{"text":"周瑞","size":211},{"text":"已经","size":211},{"text":"二奶","size":210},{"text":"看了","size":210},{"text":"不必","size":209},{"text":"谁知","size":209},{"text":"跟前","size":207},{"text":"主意","size":205},{"text":"越发","size":204},{"text":"不见","size":202},{"text":"完了","size":202},{"text":"拿了","size":202},{"text":"有些","size":201},{"text":"瞧瞧","size":201},{"text":"在外","size":200},{"text":"我就","size":200},{"text":"我这","size":200},{"text":"人去","size":199},{"text":"女儿","size":199},{"text":"只听","size":198},{"text":"子来","size":197},{"text":"倒是","size":196},{"text":"有的","size":196},{"text":"都不","size":196},{"text":"去的","size":195},{"text":"贾赦","size":195},{"text":"句话","size":194},{"text":"惜春","size":194},{"text":"难道","size":194},{"text":"不肯","size":193},{"text":"喜欢","size":193},{"text":"只怕","size":192},{"text":"话说","size":192},{"text":"他说","size":191},{"text":"好些","size":191},{"text":"贾芸","size":191},{"text":"母道","size":190},{"text":"就是了","size":189},{"text":"有个","size":189},{"text":"不要","size":187},{"text":"你也","size":187},{"text":"吩咐","size":187},{"text":"岂不","size":187},{"text":"问他","size":187},{"text":"想起","size":186},{"text":"不住","size":184},{"text":"况且","size":183},{"text":"才好","size":183},{"text":"此时","size":183},{"text":"雨村","size":183},{"text":"母亲","size":182},{"text":"便是","size":181},{"text":"便说","size":181},{"text":"兄弟","size":181},{"text":"二姐","size":180},{"text":"原是","size":180},{"text":"只说","size":180},{"text":"嫂子","size":180},{"text":"看着","size":180},{"text":"走了","size":180},{"text":"一处","size":179},{"text":"下来","size":178},{"text":"悄悄","size":178},{"text":"是什么","size":178},{"text":"过了","size":178},{"text":"因此","size":177},{"text":"不觉","size":176},{"text":"点头","size":176},{"text":"不出","size":175},{"text":"素日","size":175},{"text":"想着","size":173},{"text":"也就","size":172},{"text":"房里","size":172},{"text":"太的","size":171},{"text":"政道","size":170},{"text":"瑞家","size":170},{"text":"说我","size":170},{"text":"有这","size":169},{"text":"一样","size":167},{"text":"不大","size":166},{"text":"放心","size":166},{"text":"就不","size":165},{"text":"还要","size":165},{"text":"是谁","size":164},{"text":"半日","size":162},{"text":"大爷","size":162},{"text":"家人","size":162},{"text":"为什么","size":161},{"text":"并不","size":161},{"text":"明日","size":161},{"text":"笑说","size":160},{"text":"一会","size":159},{"text":"可不","size":159},{"text":"且说","size":158},{"text":"和他","size":158},{"text":"这几","size":157},{"text":"别的","size":156},{"text":"是有","size":156},{"text":"里来","size":156},{"text":"他不","size":155},{"text":"笑了","size":155},{"text":"言语","size":155},{"text":"走来","size":155},{"text":"不可","size":153},{"text":"芳官","size":153},{"text":"我一","size":152},{"text":"的说","size":152},{"text":"金桂","size":152},{"text":"叫你","size":151},{"text":"时候","size":151},{"text":"雪雁","size":151},{"text":"一点","size":150},{"text":"多少","size":150},{"text":"妙玉","size":150},{"text":"老婆","size":150},{"text":"一般","size":149},{"text":"坐了","size":149},{"text":"正是","size":149},{"text":"给我","size":149},{"text":"上的","size":148},{"text":"也罢","size":148},{"text":"忘了","size":148},{"text":"许多","size":147},{"text":"跟着","size":147},{"text":"房中","size":146},{"text":"然后","size":146},{"text":"哥儿","size":145},{"text":"嬷嬷","size":145},{"text":"回家","size":144},{"text":"不过是","size":143},{"text":"以后","size":143},{"text":"迎春","size":143},{"text":"与他","size":142},{"text":"他来","size":142},{"text":"给你","size":142},{"text":"我还","size":141},{"text":"糊涂","size":141},{"text":"后来","size":139},{"text":"女孩","size":139},{"text":"知道了","size":139},{"text":"十分","size":138},{"text":"我是","size":138},{"text":"见过","size":138},{"text":"也都","size":137},{"text":"奴才","size":137},{"text":"打听","size":137},{"text":"请了","size":137},{"text":"贾环","size":137},{"text":"伏侍","size":136},{"text":"天天","size":136},{"text":"拿着","size":136},{"text":"儿子","size":135},{"text":"生气","size":135},{"text":"说他","size":135},{"text":"请安","size":135},{"text":"预备","size":135},{"text":"不来","size":134},{"text":"回头","size":134},{"text":"悄悄的","size":134},{"text":"来回","size":134},{"text":"坐着","size":133},{"text":"没了","size":133},{"text":"这也","size":133},{"text":"钗道","size":133},{"text":"我看","size":132},{"text":"日子","size":132},{"text":"衣服","size":132},{"text":"坐下","size":131},{"text":"忽见","size":131},{"text":"收拾","size":131},{"text":"父亲","size":131},{"text":"听得","size":130},{"text":"府里","size":130},{"text":"我来","size":130},{"text":"一看","size":129},{"text":"不理","size":129},{"text":"不着","size":129},{"text":"年纪","size":129},{"text":"昨儿","size":129},{"text":"不许","size":128},{"text":"和我","size":128},{"text":"妈妈","size":128},{"text":"必是","size":128},{"text":"三个","size":127},{"text":"才是","size":127},{"text":"话儿","size":127},{"text":"送了","size":127},{"text":"发人","size":126},{"text":"外面","size":126},{"text":"大夫","size":126},{"text":"他也","size":125},{"text":"似的","size":125},{"text":"来请","size":125},{"text":"你又","size":124},{"text":"冷笑","size":124},{"text":"和你","size":124},{"text":"宝琴","size":124},{"text":"一天","size":123},{"text":"再不","size":123},{"text":"各自","size":123},{"text":"次日","size":123},{"text":"正在","size":123},{"text":"不去","size":122},{"text":"倘或","size":122},{"text":"坐在","size":122},{"text":"开了","size":122},{"text":"笑着","size":122},{"text":"一口","size":121},{"text":"你是","size":121},{"text":"我想","size":121},{"text":"不管","size":119},{"text":"和尚","size":119},{"text":"园里","size":119},{"text":"地下","size":119},{"text":"要紧","size":119},{"text":"不曾","size":118},{"text":"那时","size":118},{"text":"住了","size":117},{"text":"宝蟾","size":117},{"text":"想了","size":117},{"text":"祖宗","size":117},{"text":"虽不","size":117},{"text":"一想","size":116},{"text":"出了","size":116},{"text":"各处","size":116},{"text":"之事","size":115},{"text":"原故","size":115},{"text":"带着","size":115},{"text":"又见","size":114},{"text":"回道","size":114},{"text":"将来","size":114},{"text":"有一个","size":114},{"text":"门上","size":114},{"text":"却是","size":113},{"text":"正经","size":113},{"text":"看他","size":113},{"text":"里面","size":113},{"text":"人见","size":112},{"text":"应着","size":112},{"text":"都说","size":112},{"text":"亲戚","size":111},{"text":"少不得","size":111},{"text":"就好","size":111},{"text":"无人","size":111},{"text":"早已","size":111},{"text":"来问","size":111},{"text":"不说","size":110},{"text":"商议","size":110},{"text":"头子","size":110},{"text":"姨太","size":110},{"text":"昨日","size":110},{"text":"说毕","size":110},{"text":"一年","size":109},{"text":"吃饭","size":109},{"text":"四个","size":109},{"text":"便命","size":108},{"text":"又道","size":108},{"text":"回了","size":108},{"text":"地方","size":108},{"text":"我才","size":108},{"text":"他是","size":107},{"text":"光景","size":107},{"text":"是好","size":107},{"text":"这般","size":107},{"text":"上了","size":106},{"text":"你老","size":106},{"text":"琏道","size":106},{"text":"秦钟","size":106},{"text":"若不","size":106},{"text":"等我","size":105},{"text":"走到","size":105},{"text":"这边","size":105},{"text":"上头","size":104},{"text":"也要","size":104},{"text":"便道","size":104},{"text":"可知","size":104},{"text":"想来","size":104},{"text":"愿意","size":104},{"text":"我去","size":104},{"text":"接了","size":104},{"text":"说起","size":104},{"text":"不想","size":103},{"text":"几句","size":103},{"text":"上去","size":102},{"text":"不然","size":102},{"text":"不言","size":102},{"text":"人在","size":102},{"text":"小的","size":102},{"text":"底下","size":102},{"text":"薛蝌","size":102},{"text":"一夜","size":101},{"text":"定了","size":101},{"text":"打了","size":101},{"text":"把这","size":101},{"text":"父母","size":101},{"text":"都在","size":101},{"text":"下了","size":100},{"text":"头儿","size":100},{"text":"秋纹","size":100},{"text":"等着","size":100},{"text":"赶着","size":100},{"text":"几年","size":99},{"text":"就有","size":99}];
		    var fill = d3.scale.category20();
		    var layout=d3.layout.cloud()
		    .size([1500, 1500])
		    .words(data)
		    .padding(5)
		    .rotate(function() { return ~~(Math.random() * 2) * 90; })
		    .font("Impact")
		    .fontSize(function(d) { 
		    	return Math.sqrt(d.size);
		    	 }
		    )
		    .on("end", draw);
		  layout.start();

		function draw(words) {
			  d3.select("body").append("svg")
			      .attr("width", layout.size()[0])
			      .attr("height", layout.size()[1])
			    .append("g")
			      .attr("transform", "translate(" + layout.size()[0] / 2 + "," + layout.size()[1] / 2 + ")")
			    .selectAll("text")
			      .data(words)
			    .enter().append("text")
			      .style("font-size", function(d) { return d.size + "px"; })
			      .style("font-family", "Impact")
			      .style("fill", function(d, i) { return fill(i); })
			      .attr("text-anchor", "middle")
			      .attr("transform", function(d) {
			        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
			      })
			      .text(function(d) { return d.text; });
			}


		</script>
	</body>

</html>