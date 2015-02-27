package com.darcey.audio
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.utils.DTools;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.net.URLRequest;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class PlaySound extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
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
		public static function fromFile(path:String):void
		{
			//var file:File = File.applicationStorageDirectory;
			//traceArray(file.getDirectoryListing());
			
			var file:File = File.applicationDirectory;
			//traceArray(file.getDirectoryListing());
			
			file = file.resolvePath(path);
			//trace("file.exists = " + file.exists);
			//trace(file.url);
			
			var urlRequest:URLRequest = new URLRequest(file.url); 
			var sound:Sound = new Sound(urlRequest); 
			sound.play();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}