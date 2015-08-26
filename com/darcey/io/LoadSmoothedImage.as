package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class LoadSmoothedImage extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		public var url:String = "";
		public var loader:Loader;
		public var bmp:Bitmap;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function LoadSmoothedImage()
		{
			// Setup class specific tracer
			t = new Ttrace(false);
			t.string("LoadSmoothedImage()");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function load(url:String):void
		{
			this.url = url;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, imageLoadErrorHandler);
			loader.load(new URLRequest(url));
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function imageLoadErrorHandler(e:IOErrorEvent):void
		{
			t.warn("LoadSmoothedImage.imageLoadErrorHandler(e): url = " + url);
			t.warn("LoadSmoothedImage.imageLoadErrorHandler(e): e = " + e);
			t.warn("LoadSmoothedImage.imageLoadErrorHandler(e): e.text = " + e.text);
			
			dispose();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function imageLoadCompleteHandler(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadCompleteHandler);
			
			bmp = e.target.content;
			if (bmp != null){
				bmp.smoothing=true;
			}
			
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			loader = null;
			bmp = null;
			
			try {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadCompleteHandler);
			}catch (e:Error) {}
			
			try {
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, imageLoadErrorHandler);
			}catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}