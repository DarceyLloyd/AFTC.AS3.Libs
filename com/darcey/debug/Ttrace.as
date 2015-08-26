package com.darcey.debug
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import flash.display.Stage;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Ttrace
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public var enabled:Boolean = true;
		private var log:Log;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Ttrace(enabled:Boolean,argStage:Stage=null,argWidth:Number=600,argHeight:Number=400):void
		{
			this.enabled = enabled;
			log = Log.getInstance();
			
			if (argStage!=null){
				stage = argStage;
			}
			
			if (argWidth>0){
				width = argWidth;
			}
			
			if (argHeight>0){
				height = argHeight;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set width(value:Number):void {
			log.visualDebugWidth = value;
		}
		public function get width():Number {
			return log.visualDebugWidth;
		}
		public function set height(value:Number):void {
			log.visualDebugHeight = value;
		}
		public function get height():Number {
			return log.visualDebugHeight;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set stage(stage:Stage):void {
			log.stage = stage;
		}
		public function get stage():Stage {
			return log.stage;
		}
		public function globalDisable(arg:Boolean):void {
			log.globalDisable = arg;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		

		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function s(arg:String):void { if (!enabled){ return; } log.string(arg); }
		public function str(arg:String):void { if (!enabled){ return; } log.string(arg); }
		public function string(arg:String):void { if (!enabled){ return; } log.string(arg); }
		
		public function a(arg:Array):void { if (!enabled){ return; } log.array(arg); }
		public function arr(arg:Array):void { if (!enabled){ return; } log.array(arg); }
		public function array(arg:Array):void { if (!enabled){ return; } log.array(arg); }
		
		public function o(arg:Object):void { if (!enabled){ return; } log.object(arg); }
		public function obj(arg:Object):void { if (!enabled){ return; } log.object(arg); }
		public function object(arg:Object):void { if (!enabled){ return; } log.object(arg); }
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function ttrace(arg:String):void { if (!enabled){ return; } log.string(arg); } // For compat
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function div():void { if (!enabled){ return; } log.div(); }
		public function error(arg:String):void { if (!enabled){ return; } log.warn(arg); }
		public function warn(arg:String):void { if (!enabled){ return; } log.warn(arg); }
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function show():void { log.show(); }
		public function hide():void { log.hide(); }
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function clear():void { log.clear(); }
		public function dispose():void { log.clear(); log.dispose; log = null; }
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
}