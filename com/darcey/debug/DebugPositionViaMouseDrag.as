package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	public class DebugPositionViaMouseDrag
	{
		private var stage:Stage;
		private var target:*
		
		public function DebugPositionViaMouseDrag(stage:Stage,target:*)
		{
			this.stage = stage;
			this.target = target;
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		
		private function onMouseDown(event:MouseEvent):void{
			target.startDrag();
		}
		
		private function onMouseUp(event:MouseEvent):void{
			target.stopDrag();
			trace("DEBUG " + target + "    name:" + target.name + "   x:" + target.x + "   y:" + target.y);
		}
		
		
		
		
		
	}
}