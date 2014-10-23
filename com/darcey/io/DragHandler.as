package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class DragHandler extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var stage:Stage;
		private var target:*;
		private var lockCenter:Boolean = false;
		private var rect:Rectangle;
		private var useStageEvents:Boolean = false;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function DragHandler(stage:Stage,target:*,lockCenter:Boolean=false,rect:Rectangle=null,useStageEvents:Boolean=true)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.ttrace("DragHandler()");
			
			
			t.div();
			t.div();
			trace("typeof(target) = " + typeof(target));
			t.div();
			t.div();
			
			
			this.stage = stage;
			this.target = target;
			
			this.lockCenter = lockCenter;
			this.rect = rect;
			
			this.useStageEvents = useStageEvents;
			
			attachListeners();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function attachListeners():void
		{
			t.ttrace("DragHandler.attachListeners()");
			
			target.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			target.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			target.addEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler);
			
			if (useStageEvents){
				stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
				stage.addEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function detachListeners():void
		{
			t.ttrace("DragHandler.detachListeners()");
			
			try {
				target.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			} catch (e:Error) {}
			
			try {
				target.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			} catch (e:Error) {}
			
			try {
				target.removeEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler);
			} catch (e:Error) {}
			
			
			
			try {
				stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			} catch (e:Error) {}
			
			try {
				stage.removeEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler);
			} catch (e:Error) {}
			
			
			
			try {
				target.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseDownHandler(e:MouseEvent):void
		{
			t.ttrace("DragHandler.mouseDownHandler(e)");
			
			
			//mcMagnifyingGlass.startDrag(false,new Rectangle(-1100,-600,1800,1400));
			target.startDrag(lockCenter,rect);
			target.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseUpHandler(e:MouseEvent):void
		{
			t.ttrace("DragHandler.mouseUpHandler(e)");
			
			target.stopDrag();
			try {
				target.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseMoveHandler(e:MouseEvent=null):void
		{
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function stopDrag():void
		{
			target.stopDrag();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			t.ttrace("DragHandler.dispose()");
			
			detachListeners();
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}