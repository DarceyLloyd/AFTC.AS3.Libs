package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	import flash.text.Font;

	public class TraceAvailableFonts
	{

		private var msg:String = "";
		
		// ---------------------------------------------------------------------------------------------------------------------
		public function TraceAvailableFonts(appName:String)
		{
			msg += "---------------------------------------------------------------------------\n";
			msg += "AVAILABLE FONTS to [" + appName + "]:\n";

			var fonts:Array = Font.enumerateFonts().sortOn("fontName");
			for (var i:int = 0; i < fonts.length; i++)
			{
				var font:Font = fonts[i];
				msg += "\t" + i + ") fontName: [" + font.fontName + "]   fontStyle: [" + font.fontStyle + "]   fontType: [" + font.fontType + "]\n";
			}
			msg += "---------------------------------------------------------------------------";
			trace(msg);
		}
		// ---------------------------------------------------------------------------------------------------------------------
		
		
	}
}