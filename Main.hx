package;

import js.Browser;
import js.Cocoen;
import js.html.DivElement;
import js.html.ImageElement;
import js.html.ParagraphElement;

// Automatic HTML code completion, you need to point these to your debug/release HTML
#if debug
@:build(CodeCompletion.buildLocalFile("bin/debug/index.html"))
#else
@:build(CodeCompletion.buildLocalFile("bin/release/index.html"))
#end
//@:build(CodeCompletion.buildUrl("http://gallery.geometrize.co.uk/"))
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
	public var descriptionText(default,null):String;
}

/**
 * A one-page landing site for Geometrize, a tool for geometrizing images into geometric primitives.
 * @author Sam Twidale (http://www.geometrize.co.uk/)
 */
class Main {
	private static inline var WEBSITE_URL:String = "http://gallery.geometrize.co.uk/"; // Hosted site URL
	
	// The items to show in the gallery (note could auto-generate this with a macro)
	var galleryItems:Array<GalleryItem> = [
		new GalleryItem("assets/images/borrowdale_autumn.png", "assets/images/geometrized_borrowdale_autumn.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/resting_shoes.png", "assets/images/geometrized_resting_shoes.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/ridge.png", "assets/images/geometrized_ridge.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/man_and_lake.png", "assets/images/geometrized_man_and_lake.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/sunset.png", "assets/images/geometrized_sunset.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/man.png", "assets/images/geometrized_man.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/rose.png", "assets/images/geometrized_rose.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/lake_with_pier.png", "assets/images/geometrized_lake_with_pier.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/skyscrapers.png", "assets/images/geometrized_skyscrapers.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/lake.png", "assets/images/geometrized_lake.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/flower.png", "assets/images/geometrized_flower.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/mountain.png", "assets/images/geometrized_mountain.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/lake_at_night.png", "assets/images/geometrized_lake_at_night.png", "<i>300 Rotated Ellipses</i>"),
		new GalleryItem("assets/images/rolling_hills.png", "assets/images/geometrized_rolling_hills.png", "<i>300 Rotated Ellipses</i>")
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
		
		var nodes = js.Browser.document.querySelectorAll('.cocoen');
		for (node in nodes) {
			new Cocoen(cast node);
		}
	}
	
	private inline function addGalleryItem(item:GalleryItem):Void {
		var container = js.Browser.document.createDivElement();
		container.className = "container stitched";
		
		var cocoen = js.Browser.document.createDivElement();
		cocoen.className = "cocoen";
		
		container.appendChild(cocoen);
		
		var descriptionText = js.Browser.document.createParagraphElement();
		descriptionText.innerHTML = item.descriptionText;
		
		container.appendChild(descriptionText);
		
		var beforeImage = js.Browser.document.createImageElement();
		beforeImage.src = item.beforeImagePath;
		
		var afterImage = js.Browser.document.createImageElement();
		afterImage.src = item.afterImagePath;
		
		cocoen.appendChild(beforeImage);
		cocoen.appendChild(afterImage);
	
		galleryItemContainer.appendChild(container);
		
		galleryItemContainer.appendChild(js.Browser.document.createDivElement());
	}

	private inline function onWindowLoaded():Void {
		init();
	}
}