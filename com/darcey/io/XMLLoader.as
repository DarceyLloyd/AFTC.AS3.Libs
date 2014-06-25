package com.darcey.io
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.Ttrace;
	import com.darcey.events.CustomEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class XMLLoader extends EventDispatcher
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		private var urlLoader:URLLoader;
		private var file:String;
		public var xmlData:XML;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function XMLLoader()
		{
			// Setup class specific tracer
			t = new Ttrace(false);
			t.ttrace("XMLLoader()");
			
			// Setup the loader
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onCompleteHandler);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			//_loader.addEventListener(IOErrorEvent.IO_ERROR, onDataFiledToLoad);
			//_loader.addEventListener(IOErrorEvent.NETWORK_ERROR, onDataFiledToLoad);
			//_loader.addEventListener(IOErrorEvent.VERIFY_ERROR, onDataFiledToLoad);
			//_loader.addEventListener(IOErrorEvent.DISK_ERROR, onDataFiledToLoad);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function load(file:String):void
		{
			this.file = file;
			urlLoader.load(new URLRequest(file));			
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		private function onIOError(e:IOErrorEvent):void
		{
			t.error("LoadXMLFile(): ERROR unable to load file [" + file + "]");
			dispatchEvent( e );
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		private function onCompleteHandler(e:Event):void
		{
			t.ttrace("com.darcey.io.LoadXMLFile.onCompleteHandler(e)");
			
			xmlData = new XML(e.target.data);
			dispatchEvent( e );
			
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function dispose():void
		{
			try {
				urlLoader.removeEventListener(Event.COMPLETE, onCompleteHandler);
			} catch (e:Error) {}
			
			try {
				urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			} catch (e:Error) {}
			
			urlLoader = null;
			file = null;
			xmlData = null;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}