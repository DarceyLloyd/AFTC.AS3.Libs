package com.darcey.debug
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.utils.describeType;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Log
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		private static var stage:Stage;
		public static var appName:String = "";
		public static var author:String = "Darcey@AllForTheCode.co.uk1";
		
		public static var log:String = "";
		
		public static var enabled:Boolean = true;
		
		private static var logWindow:Sprite;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function msg(arg:*):void
		{
			// Check if class specific tracing has been enabled (keeps things clean)
			if (enabled)
			{
				var inputType:String = typeof arg;
				//trace("---------------------------" + inputType + "-------------------------");
				
				switch (inputType)
				{
					// ------------------------------------------------------------
					default:
						log += appName + arg;
						
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "xml":
						log += appName + arg;
						
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case null:
						log += appName + "TTrace got a NULL input";
						
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "string":
						log += appName + arg;
						
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "object":
						// Sometimes an error can occur here due to length not being defined to an xml object
						var lengthAvailable:Boolean = true;
						try {
							if (arg.length > 0){
								
							}
						} catch (e:Error) {
							lengthAvailable = false;
						}
						
						if (!lengthAvailable){
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							log += appName + "Object:" + "\n";
							
							try {
								log += describeType( arg ).toXMLString() + "\n";
							} catch (e:Error) {}
							
							for(var id:String in arg) {
								var value:Object = arg[id];
								
								log += "\t" + id + " = " + value + "\n";
							}
							
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							
							
							trace(msg);
							return;
						}
						
						if (arg.length)
						{
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							log += appName + "Array:\t" + "Length:(" + arg.length + "): [" + arg + "]" + "\n";
							
							for (var ii:String in arg){
								log += "\t" + "Index[" + ii + "] = " + arg[ii] + "\n";
							}
							
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							
							
							trace(msg);
						} else {
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							log += appName + "Object:" + "\n";
							
							try {
								log += describeType( arg ).toXMLString() + "\n";
							} catch (e:Error) {}
							
							for(var ida:String in arg) {
								var valuea:Object = arg[ida];
								
								log += "\t" + ida + " = " + valuea + "\n";
							}
							
							log += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" + "\n";
							
							
							trace(msg);
						}
						break;
					// ------------------------------------------------------------
				} // End switch
			} // End if
			
			logToClipboard();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function clear():void
		{
			log = "";
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function logToClipboard():void
		{
			Clipboard.generalClipboard.clear();
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, log);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}