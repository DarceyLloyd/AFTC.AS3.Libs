package com.darcey.utils
{
	// Author: Darcey.Lloyd@gmail.com

	// ---------------------------------------------------------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.display.Sprite;
	// ---------------------------------------------------------------------------------------------------------------------------

	// ---------------------------------------------------------------------------------------------------------------------------
	public class RemoveAllChildrenIn
	{
		private var debug:Boolean = false;
		
		// ---------------------------------------------------------------------------------------------------
		public function RemoveAllChildrenIn(target:*,debug:Boolean = false)
		{
			this.debug = debug;
			
			try {
				ttrace("");
				ttrace ("TOOLS: removeAllChildrenIn("+target+" " + target.name + "): numChildren before = " + target.numChildren); 
				while(target.numChildren) 
				{ 
					target.removeChildAt(0); 
				} 
				ttrace ("TOOLS: removeAllChildrenIn(" + target + " " + target.name + "): numChildren before = " + target.numChildren); 
				ttrace("");
			} catch (e:Error) {
				ttrace("");
				ttrace("removeAllChildrenIn(): Unable to remove children from " + target);
				ttrace("");
			}
		}
		// ---------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------
		private function ttrace(o:*):void
		{
			if (!debug){ return; }
			trace(o);
		}
		// ---------------------------------------------------------------------------------------------------
	}
	// ---------------------------------------------------------------------------------------------------------------------------
}