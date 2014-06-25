package com.darcey.debug
{
	// ---------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.DebugBox;
	// ---------------------------------------------------------------------------------------------------------------------------
	
	// ---------------------------------------------------------------------------------------------------------------------------
	public class TtraceVO
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		// Variables
		
		public static var applicationName:String = ""; // For when having multiple application modules
		
		public static var debugBox:DebugBox;
		public static var debugBoxTitle:String = "";
		public static var useDebugBox:Boolean;
		public static var debugBoxVisible:Boolean = true;
		public static var debugBoxWidth:Number = 300;
		public static var debugBoxHeight:Number = 300;
		
		public static var enabled:Boolean = true;
		
		public static var variablesSet:Boolean = false;
		// ---------------------------------------------------------------------------------------------------------------------------
	}
	// ---------------------------------------------------------------------------------------------------------------------------
}