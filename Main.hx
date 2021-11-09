package;

import js.Browser;
import js.html.AnchorElement;
import js.html.DivElement;
import js.html.ImageElement;
import js.html.ParagraphElement;

// Automatic HTML code completion, you need to point these to your debug/release HTML
#if debug
@:build(CodeCompletion.buildLocalFile("bin/index.html"))
#else
@:build(CodeCompletion.buildLocalFile("bin/index.html"))
#end
//@:build(CodeCompletion.buildUrl("https://gallery.geometrize.co.uk/"))
class ID {}

/**
 * Encapsulates an item displayed on the gallery page
 * Consists of a before (original) and after (geometrized) image path and a description.
 */
class GalleryItem {
	public function new(beforeImagePath:String, afterImagePath:String, descriptionText:String) {
		this.beforeImagePath = beforeImagePath;
		this.afterImagePath = afterImagePath;
		this.descriptionText = descriptionText;
	}
	
	public var beforeImagePath(default,null):String;
	public var afterImagePath(default,null):String;
	public var descriptionText(default, null):String;
	
	public var link(get, never):String;
	private function get_link():String {
		return Main.WEBSITE_URL + afterImagePath;
	}
}

/**
 * A one-page landing gallery page for Geometrize, a tool for geometrizing images into geometric primitives.
 * @author Sam Twidale (https://www.geometrize.co.uk/)
 */
class Main {
	public static inline var WEBSITE_URL:String = "http://gallery.geometrize.co.uk/"; // Hosted site URL
	
	// The items to show in the gallery (note could auto-generate this with a macro)
	var galleryItems:Array<GalleryItem> = [
		new GalleryItem("assets/images/resting_shoes.png", "assets/images/resting_shoes_geometrized.png", "<i>350 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/ridge.png", "assets/images/ridge_geometrized.png", "<i>430 Circles</i>"),
		new GalleryItem("assets/images/man.png", "assets/images/man_geometrized.png", "<i>400 Rotated Rectangles</i>"),
		new GalleryItem("assets/images/wolf.png", "assets/images/wolf_geometrized.png", "<i>210 Triangles</i>"),
		new GalleryItem("assets/images/man_and_lake.png", "assets/images/man_and_lake_geometrized.png", "<i>350 Circles</i>"),
		new GalleryItem("assets/images/rose.png", "assets/images/rose_geometrized.png", "<i>250 Triangles</i>"),
		new GalleryItem("assets/images/building.png", "assets/images/building_geometrized.png", "<i>460 Circles</i>"),
		new GalleryItem("assets/images/flowers.png", "assets/images/flowers_geometrized.png", "<i>200 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/lake_with_pier.png", "assets/images/lake_with_pier_geometrized.png", "<i>430 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/skyscrapers.png", "assets/images/skyscrapers_geometrized.png", "<i>470 Triangles</i>"),
		new GalleryItem("assets/images/train.png", "assets/images/train_geometrized.png", "<i>260 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/lake.png", "assets/images/lake_geometrized.png", "<i>300 Triangles</i>"),
		new GalleryItem("assets/images/flower.png", "assets/images/flower_geometrized.png", "<i>315 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/borrowdale_autumn.png", "assets/images/borrowdale_autumn_geometrized.png", "<i>500 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/mountain.png", "assets/images/mountain_geometrized.png", "<i>350 Circles</i>"),
		new GalleryItem("assets/images/sunset.png", "assets/images/sunset_geometrized.png", "<i>350 Triangles</i>"),
		new GalleryItem("assets/images/rolling_hills.png", "assets/images/rolling_hills_geometrized.png", "<i>470 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/tree_under_clouds.png", "assets/images/tree_under_clouds_geometrized.png", "<i>200 Ellipses</i>"),
	];
	
	// All the required references to the HTML page elements
	private static var galleryItemContainer = getElement(ID.galleryitems);
	
	private static inline function getElement(id:String):Dynamic {
		return Browser.document.getElementById(id);
	}

	private static function main():Void {
		var main = new Main();
	}

	private inline function new() {
		// Wait for the window to load before creating the sliders, listening for input etc
		Browser.window.onload = onWindowLoaded;
	}
	
	private inline function init():Void {
		for (item in galleryItems) {
			addGalleryItem(item);
		}
		
		var nodes = js.Browser.document.querySelectorAll('.twentytwenty');
		for (node in nodes) {
			new TwentyTwenty(cast node);
		}
	}
	
	private inline function addGalleryItem(item:GalleryItem):Void {
		var container = js.Browser.document.createDivElement();
		container.className = "container stitched";
		
		var twentyTwenty = js.Browser.document.createDivElement();
		twentyTwenty.className = "twentytwenty";
		
		container.appendChild(twentyTwenty);
		
		var caption = js.Browser.document.createParagraphElement();
		caption.innerHTML = item.descriptionText;
		
		var beforeImage = js.Browser.document.createImageElement();
		beforeImage.src = item.beforeImagePath;
		
		var afterImage = js.Browser.document.createImageElement();
		afterImage.src = item.afterImagePath;
		
		twentyTwenty.appendChild(beforeImage);
		twentyTwenty.appendChild(afterImage);
		
		var anchor = js.Browser.document.createAnchorElement();
		anchor.href = item.link;
		anchor.target = "_blank";
			
		anchor.appendChild(twentyTwenty);
		container.appendChild(anchor);
		container.appendChild(caption);
	
		galleryItemContainer.appendChild(container);
		
		galleryItemContainer.appendChild(js.Browser.document.createDivElement());
	}

	private inline function onWindowLoaded():Void {
		init();
	}
}