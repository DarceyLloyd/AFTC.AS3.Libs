//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/system/ApplicationDomain.html#currentDomain
package com.darcey.io
{
	import com.darcey.debug.Ttrace;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class LoadSWF extends EventDispatcher
	{
		private var t:Ttrace;
		private var ldr:Loader;
		public function get loader():Loader { return ldr; }
		private var percent:Number = 0;
		
		public function LoadSWF()
		{
			// Setup class specific tracer
			t = new Ttrace(false);
			t.ttrace("LoadSWF()");
			
			
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
		}
		
		public function load(url:String):void
		{
			t.ttrace("LoadSWF.load(url)");
			
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain=ApplicationDomain.currentDomain;
			
			ldr.load(new URLRequest(url),context);
		}
		
		private function onIOErrorHandler(e:IOErrorEvent):void
		{
			trace("LoadSWF(ERROR): " + e);
			removeEventListeners();
		}
		
		private function onCompleteHandler(e:Event):void
		{
			t.ttrace("LoadSWF.onCompleteHandler(e)");
			//dispatchEvent( new Event(Event.COMPLETE) );
			dispatchEvent(e);
			
			removeEventListeners();
		}
		
		private function onProgressHandler(e:ProgressEvent):void
		{
			percent = (100/e.target.bytesTotal) * e.target.bytesLoaded ;
			//trace(percent);
		}
		
		
		public function removeEventListeners():void
		{
			t.ttrace("LoadSWF.removeEventListeners()");
			
			try {
				ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
			} catch (e:Error) {}
			
			try {
				ldr.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			} catch (e:Error) {}
			
			try {
				ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			} catch (e:Error) {}
		}
	}
}