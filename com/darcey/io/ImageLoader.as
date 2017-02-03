package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class ImageLoader extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		private var loader:Loader;
		private var urlRequest:URLRequest;
		public var url:String = "";
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function ImageLoader()
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.ttrace("ImageLoader()");
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function load(url):void
		{
			t.ttrace("ImageLoader.load(url:"+url+")");
			
			this.url = url;
			
			loader = new Loader();
			urlRequest = new URLRequest(url);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadedHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(urlRequest);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function imageLoadedHandler(e:Event):void
		{
			t.ttrace("ImageLoader.imageLoadedHandler(e)");
			
			try {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadedHandler);
			} catch(error:Error) {}
			
			try {
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			} catch(error:Error) {}
			
			dispatchEvent( new Event( Event.COMPLETE ) );
			
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			t.div();
			t.warn("ImageLoader.ioErrorHandler(e:IOErrorEvent):\n" + e);
			
			try {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadedHandler);
			} catch(error:Error) {}
			
			try {
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			} catch(error:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function getBitmap():Bitmap
		{
			t.ttrace("ImageLoader.getBitmap()");
			
			var bd:BitmapData = new BitmapData(loader.content.width,loader.content.height,true,0x00000000);
			bd.draw(loader.content);
			var bm:Bitmap = new Bitmap(bd);
			return bm;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			try {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadedHandler);
			} catch(error:Error) {}
			
			try {
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			} catch(error:Error) {}
			
			urlRequest = null;
			loader = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}