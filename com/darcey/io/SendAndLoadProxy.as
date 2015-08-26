package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class SendAndLoadProxy extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var loader:URLLoader;
		private var urlreq:URLRequest;
		private var urlvars:URLVariables;
		
		public var response:Object;
		public var responseURLLoader:URLLoader;
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function SendAndLoadProxy(showTrace:Boolean=true)
		{
			// Setup class specific tracer
			t = new Ttrace(showTrace);
			t.string("SendAndLoadProxy()");
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function sendAndLoad(script:String,vars:Object,method:String="post",varFormat:String="variables"):void
		{
			t.div();
			t.string("SendAndLoadProxy.sendAndLoad(script:"+script+", vars:"+vars+", method:"+method+", varFormat:"+varFormat+")");
			
			loader = new URLLoader;
			urlreq = new URLRequest(script);
			urlvars = new URLVariables;
			
			switch (varFormat.toLocaleLowerCase()){
				case "variables":
					loader.dataFormat = URLLoaderDataFormat.VARIABLES;
					break;
				
				case "binary":
					loader.dataFormat = URLLoaderDataFormat.BINARY;
					break;
				
				default:
					loader.dataFormat = URLLoaderDataFormat.TEXT;
					break;
			}
			
			switch (method.toLocaleLowerCase()){
				case "get":
					urlreq.method = URLRequestMethod.GET;
					break;
				
				default:
					urlreq.method = URLRequestMethod.POST;
					break;
			}
			
			
			// Parse vars object into
			for (var index:String in vars){
				urlvars[index] = vars[index];
				//trace(index + " = " + vars[index]);
				t.string("SendAndLoadProxy.sendAndLoad() vars: " + index + " = " + vars[index]);
			}
			
			
			urlreq.data = urlvars;
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(Event.OPEN, openHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(urlreq);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function ioErrorHandler(e:IOErrorEvent):void {
			t.warn("SendAndLoadProxy.ioErrorHandler(e): " + e);
			
			removeEventListeners();
			
			var msg:String = "";
			msg += "";
			msg += "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n";
			msg += "PROXY IOError: Please email Darcey@AllForTheCode.com detailing how you got this error message.\n";
			msg += "Error text: " + e.text + "\n";
			msg += "Error type: " + e.type + "\n";
			msg += "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n";
			t.warn(msg);
			throw new Error(msg);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function securityErrorHandler(e:SecurityErrorEvent):void {
			t.string("SendAndLoadProxy.securityErrorHandler(e): " + e);
			
			removeEventListeners();
			
			var msg:String = "";
			msg += "";
			msg += "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n";
			msg += "PROXY SecurityError: Please email Darcey@AllForTheCode.com detailing how you got this error message.\n";
			msg += "Error text: " + e.text + "\n";
			msg += "Error type: " + e.type + "\n";
			msg += "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #\n";
			t.warn(msg);
			throw new Error(msg);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function httpStatusHandler(e:HTTPStatusEvent):void {
			t.string("SendAndLoadProxy.httpStatusHandler(e): e = " + e);
			t.string("SendAndLoadProxy.httpStatusHandler(e): status = " + e.status);
			//removeEventListeners();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function openHandler(e:Event):void {
			t.string("SendAndLoadProxy.openHandler(e): " + e);
			//removeEventListeners();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function progressHandler(e:ProgressEvent):void {
			t.string("SendAndLoadProxy.progressHandler(e): Loaded = " + e.bytesTotal.toFixed(1) + "/" + e.bytesLoaded.toFixed(1));
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		

		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function completeHandler(e:Event):void
		{
			t.string("SendAndLoadProxy.completeHandler(e)");
			
			removeEventListeners();
			
			this.response = e.target.data;
			
			responseURLLoader = URLLoader(e.target);
			
			switch(responseURLLoader.dataFormat) {
				case URLLoaderDataFormat.TEXT :
					t.string("SendAndLoadProxy.completeHandler(e): Data format = TEXT");
					t.string("\t" + responseURLLoader.data);
					break;
				case URLLoaderDataFormat.BINARY :
					t.string("SendAndLoadProxy.completeHandler(e): Data format = BINARY");
					t.string("\t" + responseURLLoader.data);
					break;
				case URLLoaderDataFormat.VARIABLES :
					t.string("SendAndLoadProxy.completeHandler(e): Data format = VARIABLES");
					t.string("\t" + unescape(responseURLLoader.data));
					break;
			}
			
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function removeEventListeners():void
		{
			t.string("SendAndLoadProxy.removeEventListeners()");
			
			try {
				loader.removeEventListener(Event.COMPLETE, completeHandler);
			} catch (e:Error) {}
			
			try {
				loader.removeEventListener(Event.OPEN, openHandler);
			} catch (e:Error) {}
			
			try {
				loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			} catch (e:Error) {}
			
			try {
				loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			} catch (e:Error) {}
			
			try {
				loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			} catch (e:Error) {}
			
			try {
				loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			t.string("SendAndLoadProxy.dispose()");
			
			removeEventListeners();
			
			response = null;
			responseURLLoader = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}