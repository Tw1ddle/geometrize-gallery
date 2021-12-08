(function ($global) { "use strict";
var GalleryItem = function(beforeImagePath,afterImagePath,descriptionText) {
	this.beforeImagePath = beforeImagePath;
	this.afterImagePath = afterImagePath;
	this.descriptionText = descriptionText;
};
GalleryItem.__name__ = true;
GalleryItem.prototype = {
	get_link: function() {
		return "http://gallery.geometrize.co.uk/" + this.afterImagePath;
	}
};
var Main = function() {
	this.galleryItems = [new GalleryItem("assets/images/resting_shoes.png","assets/images/resting_shoes_geometrized.png","<i>350 Rotated Ellipses</i>"),new GalleryItem("assets/images/ridge.png","assets/images/ridge_geometrized.png","<i>430 Circles</i>"),new GalleryItem("assets/images/man.png","assets/images/man_geometrized.png","<i>400 Rotated Rectangles</i>"),new GalleryItem("assets/images/wolf.png","assets/images/wolf_geometrized.png","<i>210 Triangles</i>"),new GalleryItem("assets/images/man_and_lake.png","assets/images/man_and_lake_geometrized.png","<i>350 Circles</i>"),new GalleryItem("assets/images/rose.png","assets/images/rose_geometrized.png","<i>250 Triangles</i>"),new GalleryItem("assets/images/building.png","assets/images/building_geometrized.png","<i>460 Circles</i>"),new GalleryItem("assets/images/flowers.png","assets/images/flowers_geometrized.png","<i>200 Rotated Ellipses</i>"),new GalleryItem("assets/images/lake_with_pier.png","assets/images/lake_with_pier_geometrized.png","<i>430 Rotated Ellipses</i>"),new GalleryItem("assets/images/skyscrapers.png","assets/images/skyscrapers_geometrized.png","<i>470 Triangles</i>"),new GalleryItem("assets/images/train.png","assets/images/train_geometrized.png","<i>260 Rotated Ellipses</i>"),new GalleryItem("assets/images/lake.png","assets/images/lake_geometrized.png","<i>300 Triangles</i>"),new GalleryItem("assets/images/flower.png","assets/images/flower_geometrized.png","<i>315 Rotated Ellipses</i>"),new GalleryItem("assets/images/borrowdale_autumn.png","assets/images/borrowdale_autumn_geometrized.png","<i>500 Rotated Ellipses</i>"),new GalleryItem("assets/images/mountain.png","assets/images/mountain_geometrized.png","<i>350 Circles</i>"),new GalleryItem("assets/images/sunset.png","assets/images/sunset_geometrized.png","<i>350 Triangles</i>"),new GalleryItem("assets/images/rolling_hills.png","assets/images/rolling_hills_geometrized.png","<i>470 Rotated Ellipses</i>"),new GalleryItem("assets/images/tree_under_clouds.png","assets/images/tree_under_clouds_geometrized.png","<i>200 Ellipses</i>")];
	window.onload = $bind(this,this.onWindowLoaded);
};
Main.__name__ = true;
Main.main = function() {
	var main = new Main();
};
Main.prototype = {
	onWindowLoaded: function() {
		var _g = 0;
		var _g1 = this.galleryItems;
		while(_g < _g1.length) {
			var item = _g1[_g];
			++_g;
			var container = window.document.createElement("div");
			container.className = "container stitched";
			var twentyTwenty = window.document.createElement("div");
			twentyTwenty.className = "twentytwenty";
			container.appendChild(twentyTwenty);
			var caption = window.document.createElement("p");
			caption.innerHTML = item.descriptionText;
			var beforeImage = window.document.createElement("img");
			beforeImage.src = item.beforeImagePath;
			var afterImage = window.document.createElement("img");
			afterImage.src = item.afterImagePath;
			twentyTwenty.appendChild(beforeImage);
			twentyTwenty.appendChild(afterImage);
			var anchor = window.document.createElement("a");
			anchor.href = item.get_link();
			anchor.target = "_blank";
			anchor.appendChild(twentyTwenty);
			container.appendChild(anchor);
			container.appendChild(caption);
			Main.galleryItemContainer.appendChild(container);
			var tmp = Main.galleryItemContainer;
			var tmp1 = window.document.createElement("div");
			tmp.appendChild(tmp1);
		}
		var nodes = window.document.querySelectorAll(".twentytwenty");
		var _g = 0;
		while(_g < nodes.length) {
			var node = nodes[_g];
			++_g;
			new TwentyTwenty(node);
		}
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.parseInt = function(x) {
	if(x != null) {
		var _g = 0;
		var _g1 = x.length;
		while(_g < _g1) {
			var i = _g++;
			var c = x.charCodeAt(i);
			if(c <= 8 || c >= 14 && c != 32 && c != 45) {
				var nc = x.charCodeAt(i + 1);
				var v = parseInt(x,nc == 120 || nc == 88 ? 16 : 10);
				if(isNaN(v)) {
					return null;
				} else {
					return v;
				}
			}
		}
	}
	return null;
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.replace = function(s,sub,by) {
	return s.split(sub).join(by);
};
var TwentyTwenty = function(element,dividerStartFraction) {
	if(dividerStartFraction == null) {
		dividerStartFraction = 0.5;
	}
	this.leftPos = 0;
	this.maxLeftPos = 0;
	this.minLeftPos = 0;
	this.dragElementWidth = 0;
	this.elementOffsetLeft = 0;
	this.elementWidth = 0;
	this.beforeImage = null;
	this.beforeElement = null;
	this.draggerElement = null;
	this.element = element;
	var span = window.document.createElement("span");
	span.className = StringTools.replace(".twentytwenty-drag",".","");
	this.element.appendChild(span);
	var wrapper = window.document.createElement("div");
	var firstImage = this.element.querySelector("img:first-child");
	wrapper.appendChild(firstImage.cloneNode(true));
	firstImage.parentNode.replaceChild(wrapper,firstImage);
	this.draggerElement = this.element.querySelector(".twentytwenty-drag");
	this.beforeElement = this.element.querySelector("div:first-child");
	this.beforeImage = this.beforeElement.querySelector("img");
	this.elementWidth = Std.parseInt(window.getComputedStyle(this.element).width);
	this.elementOffsetLeft = this.element.getBoundingClientRect().left + window.document.body.scrollLeft;
	this.beforeImage.style.width = Std.string(this.elementWidth) + "px";
	this.dragElementWidth = Std.parseInt(window.getComputedStyle(this.draggerElement).width);
	this.minLeftPos = this.elementOffsetLeft + 10;
	this.maxLeftPos = this.elementOffsetLeft + this.elementWidth - this.dragElementWidth - 10;
	this.element.addEventListener("mousemove",$bind(this,this.onDrag));
	this.element.addEventListener("touchmove",$bind(this,this.onDrag));
	window.addEventListener("resize",$bind(this,this.setDimensions));
	this.setDividerPosition(dividerStartFraction);
};
TwentyTwenty.__name__ = true;
TwentyTwenty.prototype = {
	setDimensions: function() {
		this.elementWidth = Std.parseInt(window.getComputedStyle(this.element).width);
		this.elementOffsetLeft = this.element.getBoundingClientRect().left + window.document.body.scrollLeft;
		this.beforeImage.style.width = Std.string(this.elementWidth) + "px";
		this.dragElementWidth = Std.parseInt(window.getComputedStyle(this.draggerElement).width);
		this.minLeftPos = this.elementOffsetLeft + 10;
		this.maxLeftPos = this.elementOffsetLeft + this.elementWidth - this.dragElementWidth - 10;
	}
	,onDrag: function(e) {
		e.preventDefault();
		var moveX = e.pageX != null ? e.pageX : e.touches[0].pageX;
		this.leftPos = moveX - this.dragElementWidth;
		this.requestDrag();
	}
	,performDrag: function(dt) {
		if(this.leftPos < this.minLeftPos) {
			this.leftPos = this.minLeftPos;
		} else if(this.leftPos > this.maxLeftPos) {
			this.leftPos = this.maxLeftPos;
		}
		var openRatio = this.leftPos + this.dragElementWidth / 2 - this.elementOffsetLeft;
		openRatio /= this.elementWidth;
		this.setDividerPosition(openRatio);
	}
	,requestDrag: function() {
		window.requestAnimationFrame($bind(this,this.performDrag));
	}
	,setDividerPosition: function(fractionAcross) {
		var percentAcross = Std.string(fractionAcross * 100) + "%";
		this.draggerElement.style.left = percentAcross;
		this.beforeElement.style.width = percentAcross;
	}
};
var haxe_iterators_ArrayIterator = function(array) {
	this.current = 0;
	this.array = array;
};
haxe_iterators_ArrayIterator.__name__ = true;
haxe_iterators_ArrayIterator.prototype = {
	hasNext: function() {
		return this.current < this.array.length;
	}
	,next: function() {
		return this.array[this.current++];
	}
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(((o) instanceof Array)) {
			var str = "[";
			s += "\t";
			var _g = 0;
			var _g1 = o.length;
			while(_g < _g1) {
				var i = _g++;
				str += (i > 0 ? "," : "") + js_Boot.__string_rec(o[i],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( _g ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		var k = null;
		for( k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) {
			str += ", \n";
		}
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "string":
		return o;
	default:
		return String(o);
	}
};
var $_;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $global.$haxeUID++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = m.bind(o); o.hx__closures__[m.__id__] = f; } return f; }
$global.$haxeUID |= 0;
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = ({ }).toString;
Main.galleryItemContainer = window.document.getElementById("galleryitems");
Main.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
