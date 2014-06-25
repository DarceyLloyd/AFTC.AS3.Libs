package com.darcey.debug
{		
	// ----------------------------------------------------------------------------------------
	// Author: Darcey.Lloyd@gmail.com
	// ----------------------------------------------------------------------------------------

	// ----------------------------------------------------------------------------------------
	import com.darcey.debug.DebugBox;
	import com.darcey.utils.JavaScriptNotification;
	
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.utils.describeType;
	import flash.xml.*;

	// ----------------------------------------------------------------------------------------
	
	
	// ----------------------------------------------------------------------------------------
	public class Ttrace extends Sprite
	{
		// ----------------------------------------------------------------------------------------
		public var enabled:Boolean;
		public function enable():void { enabled = true; }
		public function disable():void { enabled = false; }
		// ----------------------------------------------------------------------------------------
		
		
		
		
		// ----------------------------------------------------------------------------------------
		
		
		public function Ttrace(enabled:Boolean,applicationName:String="",useDebugBox:Boolean=false,debugBoxVisible:Boolean=true,debugBoxTitle:String="",debugBoxWidth:Number=800,debugBoxHeight:Number=400):void
		{
			// Var ini
			this.enabled = enabled;
			
			// Only set these variable when TtraceVO has not been set
			if (!TtraceVO.variablesSet)
			{
				//trace("############################################################ SETTING VARS #### ");
				if (applicationName != ""){
					TtraceVO.applicationName = applicationName + ": ";
				}
				TtraceVO.debugBoxTitle = debugBoxTitle;
				TtraceVO.useDebugBox = useDebugBox;
				TtraceVO.debugBoxVisible = debugBoxVisible;
				TtraceVO.debugBoxWidth = debugBoxWidth;
				TtraceVO.debugBoxHeight = debugBoxHeight;
				TtraceVO.variablesSet = true;
			}

			
			
			
			//trace("############################################################ TtraceVO.applicationName = " + TtraceVO.applicationName);
			
			
			// Check for debug box even though it may be set to false
			if (DebugBox.Singleton == null)
			{
				// There is no singleton of debug box so we create one if asked to 
				if (TtraceVO.useDebugBox){
					if (TtraceVO.debugBox == null){
						TtraceVO.debugBox = DebugBox.getInstance();
						TtraceVO.debugBox.init(TtraceVO.debugBoxWidth,TtraceVO.debugBoxHeight,debugBoxVisible,debugBoxTitle);
						addChild(TtraceVO.debugBox);
					}
				}					
			} else {
				// There is already an instance of debug box so use it
				TtraceVO.debugBox = DebugBox.getInstance();
			}
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		
		// ----------------------------------------------------------------------------------------
		public function error(param:Object=null):void
		{
			var inputType:String = typeof param;
			var msg:String = "\n######## ERROR ON APPLICATION " + TtraceVO.applicationName + " ########" + "\n";
			
			switch (inputType)
			{
				// ------------------------------------------------------------
				default:
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					throw new Error(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "xml":
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					throw new Error(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case null:
					msg += TtraceVO.applicationName + "TTrace got a NULL input";
					addToDebugBox(msg);
					throw new Error(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "string":
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					throw new Error(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "object":
					
					if (param.length)
					{
						msg += TtraceVO.applicationName + "Array:\t" + "Length:(" + param.length + "): [" + param + "]" + "\n";
						
						for (var ii:String in param){
							msg += "\t" + TtraceVO.applicationName + "Index[" + ii + "] = " + param[ii] + "\n";
						}
						
						msg += "------------------------------------------------------------------------" + "\n";
						
						addToDebugBox(msg);
						throw new Error(msg);
					} else {
						msg += TtraceVO.applicationName + "Object:" + "\n";
						
						try {
							msg += describeType( param ).toXMLString() + "\n";
						} catch (e:Error) {}
						
						for(var id:String in param) {
							var value:Object = param[id];
							
							msg += "\t" + id + " = " + value + "\n";
						}
						
						msg += "-------------------------------------------------------------------------" + "\n";
						
						addToDebugBox(msg);
						throw new Error(msg);
					}
					break;
				// ------------------------------------------------------------
			} // End switch
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		
		// ----------------------------------------------------------------------------------------
		public function warn(param:Object=null):void
		{
			var inputType:String = typeof param;
			var msg:String = "#################################################################################\n######## WARNING ON APPLICATION: " + TtraceVO.applicationName + " ########" + "\n";
			
			switch (inputType)
			{
				// ------------------------------------------------------------
				default:
					msg += TtraceVO.applicationName + param;
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "xml":
					msg += TtraceVO.applicationName + param;
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case null:
					msg += TtraceVO.applicationName + "TTrace got a NULL input";
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "string":
					msg += TtraceVO.applicationName + param;
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "object":
					
					if (param.length)
					{
						msg += TtraceVO.applicationName + "Array:\t" + "Length:(" + param.length + "): [" + param + "]" + "\n";
						
						for (var ii:String in param){
							msg += "\t" + "Index[" + ii + "] = " + param[ii] + "\n";
						}
						
						msg += "------------------------------------------------------------------------" + "\n";
					} else {
						msg += TtraceVO.applicationName + "Object:" + "\n";
						
						try {
							msg += describeType( param ).toXMLString() + "\n";
						} catch (e:Error) {}
						
						for(var id:String in param) {
							var value:Object = param[id];
							
							msg += "\t" + id + " = " + value + "\n";
						}
						
						msg += "-------------------------------------------------------------------------" + "\n";
					}
					break;
				// ------------------------------------------------------------
			} // End switch
			
			
			msg += "\n#################################################################################";
			
			addToDebugBox(msg);
			trace(msg);
		}
		// ----------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------
		public function div():void
		{
			if (enabled)
			{
				var msg:String = "#################################################################################";
				addToDebugBox(msg);
				trace(msg);
			}
		}
		// ----------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------
		public function wdiv():void
		{
			var msg:String = "#################################################################################";
			addToDebugBox(msg);
			trace(msg);
		}
		// ----------------------------------------------------------------------------------------
		
		// ----------------------------------------------------------------------------------------
		public function ttrace(param:Object=null):void
		{			
			// Check if class specific tracing has been enabled (keeps things clean)
			if (enabled)
			{
				var inputType:String = typeof param;
				//trace("---------------------------" + inputType + "-------------------------");
				var msg:String = "";
				
				switch (inputType)
				{
					// ------------------------------------------------------------
					default:
						msg += TtraceVO.applicationName + param;
						addToDebugBox(msg);
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "xml":
						msg += TtraceVO.applicationName + param;
						addToDebugBox(msg);
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case null:
						msg += TtraceVO.applicationName + "TTrace got a NULL input";
						addToDebugBox(msg);
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "string":
						msg += TtraceVO.applicationName + param;
						addToDebugBox(msg);
						trace(msg);
						//new JavaScriptNotification(msg);
						break;
					// ------------------------------------------------------------
					
					// ------------------------------------------------------------
					case "object":
						// Sometimes an error can occur here due to length not being defined to an xml object
						var lengthAvailable:Boolean = true;
						try {
							if (param.length > 0){
								
							}
						} catch (e:Error) {
							lengthAvailable = false;
						}
						
						if (!lengthAvailable){
							msg += "------------------------------------------------------------------------" + "\n";
							msg += TtraceVO.applicationName + "Object:" + "\n";
							
							try {
								msg += describeType( param ).toXMLString() + "\n";
							} catch (e:Error) {}
							
							for(var id:String in param) {
								var value:Object = param[id];
								
								msg += "\t" + id + " = " + value + "\n";
							}
							
							msg += "-------------------------------------------------------------------------" + "\n";
							
							addToDebugBox(msg);
							trace(msg);
							return;
						}
						
						if (param.length)
						{
							msg += "------------------------------------------------------------------------" + "\n";
							msg += TtraceVO.applicationName + "Array:\t" + "Length:(" + param.length + "): [" + param + "]" + "\n";
							
							for (var ii:String in param){
								msg += "\t" + "Index[" + ii + "] = " + param[ii] + "\n";
							}
							
							msg += "------------------------------------------------------------------------" + "\n";
							
							addToDebugBox(msg);
							trace(msg);
						} else {
							msg += "------------------------------------------------------------------------" + "\n";
							msg += TtraceVO.applicationName + "Object:" + "\n";
							
							try {
								msg += describeType( param ).toXMLString() + "\n";
							} catch (e:Error) {}
							
							for(var ida:String in param) {
								var valuea:Object = param[ida];
								
								msg += "\t" + ida + " = " + valuea + "\n";
							}
							
							msg += "-------------------------------------------------------------------------" + "\n";
							
							addToDebugBox(msg);
							trace(msg);
						}
						break;
					// ------------------------------------------------------------
				} // End switch
			} // End if
			
			msg = "";
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		// ----------------------------------------------------------------------------------------
		public function ttry(param:Object=null):void
		{
			try {
				trace(param);
			} catch (e:Error) {}
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		// ----------------------------------------------------------------------------------------
		public function force(param:Object=null):void
		{			
			var inputType:String = typeof param;
			var msg:String = "";
			
			switch (inputType)
			{
				// ------------------------------------------------------------
				default:
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					trace(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "xml":
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					trace(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case null:
					msg += TtraceVO.applicationName + "TTrace got a NULL input";
					addToDebugBox(msg);
					trace(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "string":
					msg += TtraceVO.applicationName + param;
					addToDebugBox(msg);
					trace(msg);
					break;
				// ------------------------------------------------------------
				
				// ------------------------------------------------------------
				case "object":
					
					if (param.length)
					{
						msg += "------------------------------------------------------------------------" + "\n";
						msg += TtraceVO.applicationName + "Array:\t" + "Length:(" + param.length + "): [" + param + "]" + "\n";
						
						for (var ii:String in param){
							msg += "\t" + "Index[" + ii + "] = " + param[ii] + "\n";
						}
						
						msg += "------------------------------------------------------------------------" + "\n";
						
						addToDebugBox(msg);
						trace(msg);
					} else {
						msg += "------------------------------------------------------------------------" + "\n";
						msg += TtraceVO.applicationName + "Object:" + "\n";
						
						try {
							msg += describeType( param ).toXMLString() + "\n";
						} catch (e:Error) {}
						
						for(var id:String in param) {
							var value:Object = param[id];
							
							msg += "\t" + id + " = " + value + "\n";
						}
						
						msg += "-------------------------------------------------------------------------" + "\n";
						
						addToDebugBox(msg);
						trace(msg);
					}
					break;
				// ------------------------------------------------------------
			} // End switch
			
			msg = "";
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------
		public function traceAvailableFonts():void
		{			
			var msg:String = "---------------------------------------------------------------------------\n";
			msg += "FONTS AVAILABLE to [" + TtraceVO.applicationName + "]\n";			
			
			var fonts:Array = Font.enumerateFonts().sortOn("fontName");
			for (var i:int = 0; i < fonts.length; i++)
			{
				var font:Font = fonts[i];
				msg += "\t" + i + ") fontName: [" + font.fontName + "]   fontStyle: [" + font.fontStyle + "]   fontType: [" + font.fontType + "]\n";
			}
			msg += "---------------------------------------------------------------------------";
			ttrace(msg);
			msg = "";
		}
		// ---------------------------------------------------------------------------------------------------------------------
		
		
		
		
		// ----------------------------------------------------------------------------------------
		public function attachDebugBox(debugBox:DebugBox):void
		{
			TtraceVO.debugBox = debugBox;
		}
		// ----------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------
		private function addToDebugBox(str:String):void
		{
			if (TtraceVO.debugBox)
			{
				TtraceVO.debugBox.add(str);
			}
		}
		// ----------------------------------------------------------------------------------------
		
		
		
		public function get debugbox():DebugBox {
			return TtraceVO.debugBox;	
		}
		
	}
}