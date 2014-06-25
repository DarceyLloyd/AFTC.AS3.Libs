package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	import flash.display.LoaderInfo;

	public class TraceFlashVars
	{
		public function TraceFlashVars(typeInThisRootLoaderInfoParamaters:Object,txt:*=null)
		{
			if (txt)
			{
				txt.text += "TraceFalshVars():\n"
			}
			trace("TraceFalshVars():");
			var paramObj:Object = typeInThisRootLoaderInfoParamaters;
			if (paramObj)
			{
				for (var keyStr:String in paramObj) {
					//valueStr = String(paramObj[keyStr]);
					//tf.appendText("\t" + keyStr + ":\t" + valueStr + "\n");
					//Variables.txt.appendText(keyStr + " = [" + String(paramObj[keyStr]) + "]" + "\n");
					if (txt)
					{
						txt.text += "\t" + keyStr + " = [" + String(paramObj[keyStr]) + "]" + "\n";
					}
					trace("\t" + keyStr + " = [" + String(paramObj[keyStr]) + "]");
				}
			} else {
				trace("TraceFalshVars(): Failed - this.root.loaderInfo.parameters = null");
			}
		}
	}
}