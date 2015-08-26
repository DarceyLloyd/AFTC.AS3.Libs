package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.debug.VTrace;
	import com.darcey.utils.DTools;
	
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.EventDispatcher;
	import flash.sensors.Accelerometer;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Accelerometer extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		public var supported:Boolean = false;
		public var acc:flash.sensors.Accelerometer;
		public var rx:Number = 0;
		public var rz:Number = 0;
		public var ry:Number = 0;
		
		private var debug:Boolean = false;
		private var stage:Stage;
		
		private var vt1:VTrace;
		private var vt2:VTrace;
		private var vt3:VTrace;
		private var vt4:VTrace;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Accelerometer(debug:Boolean=false,stage:Stage=null)
		{
			// Setup class specific tracer
			t = new Ttrace(debug);
			t.string("Accelerometer()");
			
			this.stage = stage;
			supported = flash.sensors.Accelerometer.isSupported;
			
			if (supported){
				acc = new flash.sensors.Accelerometer();
				acc.addEventListener(AccelerometerEvent.UPDATE, updateHandler);
				
				if (debug && stage){
					vt1 = new VTrace(this,"rx");
					DTools.scale(vt1,3);
					vt1.y = 5;
					stage.addChild(vt1);
					
					vt2 = new VTrace(this,"rz");
					DTools.scale(vt2,3);
					vt2.y = vt1.y + vt1.height + 20;
					stage.addChild(vt2);
					
					vt3 = new VTrace(this,"ry");
					DTools.scale(vt3,3);
					vt3.y = vt2.y + vt1.height + 20;
					stage.addChild(vt3);
					
					vt4 = new VTrace(this,"supported");
					DTools.scale(vt4,3);
					vt4.y = vt3.y + vt1.height + 20;
					stage.addChild(vt4);
				}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function updateHandler(e:AccelerometerEvent):void {
			//myTextField.text = String("at: " + evt.timestamp + "\n" + "acceleration X: " + evt.accelerationX + "\n" + "acceleration Y: " + evt.accelerationY + "\n" + "acceleration Z: " + evt.accelerationZ);
			//t.string("Accelerometer.updateHandler(e): eX:" + e.accelerationX + "  eZ:" + e.accelerationZ + "  eY:" + e.accelerationY);
			
			
			rx = e.accelerationX;
			ry = e.accelerationY;
			rz = e.accelerationZ;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			t.string("Accelerometer.dispose()");
			
			try {
				acc.removeEventListener(AccelerometerEvent.UPDATE, updateHandler);
			} catch (e:Error) {}
			
			try {
				stage.removeChild(vt1);
			} catch (e:Error) {}
			
			try {
				stage.removeChild(vt2);
			} catch (e:Error) {}
			
			try {
				stage.removeChild(vt3);
			} catch (e:Error) {}
			
			try {
				stage.removeChild(vt4);
			} catch (e:Error) {}
			
			acc = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}