package com.darcey.utils.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class LoadImageAndProcessBitmapData extends EventDispatcher
	{
		public var ldr:Loader;
		
		private var target:*;
		private var path:String;
		private var rotation:Number = 0;
		private var flipH:Boolean = false;
		private var flipV:Boolean = false;
		
		public var loaded:Boolean = false;
		public var error:Boolean = false;
		
		public var bitmap:Bitmap;
		public var bitmapData:BitmapData;
		
		public function LoadImageAndProcessBitmapData(applyTo:*,path:String,rotation:Number=0, filpH:Boolean=false, flipV:Boolean=false)
		{
			/*
			trace("LoadImageAndProcessBitmapData()");
			trace("LoadImageAndProcessBitmapData(): applyTo = [" + applyTo + "]");
			trace("LoadImageAndProcessBitmapData(): path = [" + path + "]");
			trace("LoadImageAndProcessBitmapData(): rotation = [" + rotation + "]");
			trace("LoadImageAndProcessBitmapData(): filpH = [" + filpH + "]");
			trace("LoadImageAndProcessBitmapData(): flipV = [" + flipV + "]");
			*/
			
			this.target = applyTo;
			this.path = path;
			this.rotation = rotation;
			this.flipH = this.flipH;
			this.flipV = this.flipV;
			
			ldr = new Loader();
			ldr.addEventListener(Event.COMPLETE,imageLoadedHandler);
			ldr.addEventListener(IOErrorEvent.IO_ERROR,IOErrorHandler);
			ldr.load( new URLRequest(path) );
		}
		
		
		private function IOErrorHandler(e:IOErrorEvent):void
		{
			trace("### LoadImageAndProcessBitmapData(): IO Error " + e);
			error = true;
		}
		
		
		private function imageLoadedHandler(e:Event):void
		{
			loaded = true;
			bitmap = ldr.content as Bitmap;
			bitmapData = bitmap.bitmapData;
			
			dispatchEvent( new Event(Event.COMPLETE) );
		}
	}
}