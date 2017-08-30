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
		new GalleryItem("assets/images/stanczyk.jpg", "assets/images/stanczyk.svg", "<i>Stańczyk, Jan Matejko, oil on canvas, 1862. Geometrized into 100 ellipses and rectangles. With such a low number of shapes, most detail is lost but abstract forms are preserved.</i>"),
		new GalleryItem("assets/images/peacock.jpg", "assets/images/peacock.svg", "<i>Royal Peacock, Elena Walker, photograph, 2013. Geometrized into 350 triangles. The intricate patterns do not geometrize easily, but a stylized form is reproduced quickly.</i>"),
		new GalleryItem("assets/images/the_desperate_man.jpg", "assets/images/the_desperate_man.svg", "<i>The Desperate Man, Gustave Courbet, oil on canvas, 1843. Geometrized into 1000 shapes of various types. Faces geometrize quite well. The Geometrize app includes a mode that lets users focus on areas of interest, which was not used here.</i>"),
		new GalleryItem("assets/images/midsummer_eve.jpg", "assets/images/midsummer_eve.svg", "<i>Midsummer Eve, Edward Robert Hughes, oil on canvas, 1908. Geometrized into 1000 shapes of various types. Try squinting.</i>"),
		new GalleryItem("assets/images/cinderella.jpg", "assets/images/cinderella.svg", "<i>Cinderella, John Everett Millais, oil on canvas, 1870. Geometrized into 1000 shapes of various types, mostly circles.</i>"),
		new GalleryItem("assets/images/circe_invidiosa.jpg", "assets/images/circe_invidiosa.svg", "<i>Circe Invidiosa, John William Waterhouse, oil on canvas, 1892. Geometrized into 1000 ellipses, rectangles and triangles.</i>")
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