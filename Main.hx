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
	// TODO
	var galleryItems:Array<GalleryItem> = [
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>"),
		new GalleryItem("assets/images/before.jpg", "assets/images/after.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into...</i>")
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
	}

	private inline function onWindowLoaded():Void {
		init();
	}
}