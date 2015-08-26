package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
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
		private var target:MovieClip;
		private var lockCenter:Boolean = false;
		private var rect:Rectangle;
		private var useStageEvents:Boolean = false;
		private var targetArea:Rectangle;
		
		private var debug:Boolean = false;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function DragHandler(stage:Stage,target:MovieClip,lockCenter:Boolean=false,rect:Rectangle=null,useStageEvents:Boolean=true,targetArea:Rectangle=null,debug:Boolean=false)
		{
			// Setup class specific tracer
			t = new Ttrace(debug);
			t.string("DragHandler()");
			
			
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
			
			this.targetArea = targetArea;
			
			this.debug = debug;
			
			attachListeners();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function attachListeners():void
		{
			t.string("DragHandler.attachListeners()");
			
			target.buttonMode = true;
			target.useHandCursor = true;
			
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
		private function mouseDownHandler(e:MouseEvent):void
		{
			t.string("DragHandler.mouseDownHandler(e)");
			
			target.startDrag(lockCenter,rect);
			target.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseUpHandler(e:MouseEvent):void
		{
			t.string("DragHandler.mouseUpHandler(e)");
			
			target.stopDrag();
			try {
				target.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseMoveHandler(e:MouseEvent=null):void
		{
			if (debug){
				t.string("x:" + target.x + " y:" + target.y);
			}
			
			if (targetArea){
				if ((target.x >= targetArea.x) && (target.x <= targetArea.width))
				{
					if ((target.y >= targetArea.y) && (target.y <= targetArea.height))
					{
						dispatchEvent( new Event(Event.COMPLETE) );
					}
				}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function stopDrag():void
		{
			target.stopDrag();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function detachListeners():void
		{
			t.string("DragHandler.detachListeners()");
			
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
		public function dispose():void
		{
			t.string("DragHandler.dispose()");
			
			detachListeners();
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}