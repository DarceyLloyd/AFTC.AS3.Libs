package com.darcey.air
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class AIRTools extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function traceArray(arr:Array):void
		{
			trace("-----------------------");
			for (var s:String in arr){
				var f:File = arr[s];
				//trace(s + " = " + arr[s]);
				trace(f.url);
			}
			trace("_______________________");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function playSoundFromFile(path:String):void
		{
			var file:File = File.applicationDirectory;
			//traceArray(file.getDirectoryListing());
			file = file.resolvePath(path);
			
			var urlRequest:URLRequest = new URLRequest(file.url); 
			var sound:Sound = new Sound(urlRequest); 
			sound.play();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var imageLoader:Loader;
		private var imageURLRequest:URLRequest;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function loadImageFromURL(url:String):void
		{
			imageLoader = new Loader();
			imageURLRequest = new URLRequest(url);
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageFromURLCompleteHandler);
			imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadImageFromURLIOErrorHandler);
			imageLoader.load(imageURLRequest);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function loadImageFromURLCompleteHandler(e:Event):void
		{
			try {
				imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadImageFromURLIOErrorHandler);
			} catch (e:Error) {}
			
			try {
				imageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadImageFromURLIOErrorHandler);
			} catch (e:Error) {}
			
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function loadImageFromURLIOErrorHandler(e:IOErrorEvent):void
		{
			trace("#### ERROR LOADING IMAGE FROM URL: " + imageURLRequest.url);
			trace(e);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}