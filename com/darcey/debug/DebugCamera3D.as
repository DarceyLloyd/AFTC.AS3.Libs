package com.plantapledge.utils
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import away3d.cameras.Camera3D;
	
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.JavaScriptNotification;
	import com.plantapledge.model.Variables;
	import com.plantapledge.views.away3dscene.Away3DScene;
	import com.plantapledge.views.stage1.Stage1;
	import com.plantapledge.views.stage1.Stage1Pledge;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	
	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class DebugCamera3D extends Sprite
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		
		private var camera3D:Camera3D;
		
		private var bLeft:Boolean = false;
		private var bRight:Boolean = false;
		private var bUp:Boolean = false;
		private var bDown:Boolean = false;
		private var zp:Boolean = false;
		private var zn:Boolean = false;
		
		private var nStep:Number = 1;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function DebugCamera3D(nStep:Number=1,camera3D:Camera3D)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.string("DebugCamera3D(nStep)");
			
			this.nStep= nStep;
			
			// Keyboard event listeners
			Variables.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			Variables.stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			
			Variables.stage.addEventListener(Event.ENTER_FRAME,animate);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		protected function keyUpHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 37://left
					bLeft = false;
					break;
				case 39://right
					bRight = false;
					break;
				case 38://up
					bUp = false;
					break;
				case 40://down
					bDown = false;
					break;
				case 107://z+
					zp = false;
					break;
				case 109://z-
					zn = false;
					break;
			}
			
			var msg:String = "";
			msg = 'cX="' + Math.round(camera3D.x) + '" cY="' + Math.round(camera3D.y) + '" cZ="' + Math.round(camera3D.z);
			msg + = 'cRX="' + Math.round(camera3D.rotationX) + '" cRY="' + Math.round(camera3D.rotationY) + '" cRZ="' + Math.round(camera3D.rotationZ);
			t.string(msg);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		protected function keyDownHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 37://left
					bLeft = true;
					break;
				case 39://right
					bRight = true;
					break;
				case 38://up
					bUp = true;
					break;
				case 40://down
					bDown = true;
					break;
				case 107://z+
					zp = true;
					break;
				case 109://z-
					zn = true;
					break;
			}
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		protected function animate(e:Event):void
		{
			/*
			Variables.da.text = "C2X: " + camera3D.x.toFixed(2);
			Variables.db.text = "C2Y: " + camera3D.y.toFixed(2);
			Variables.dc.text = "C2Z: " + camera3D.z.toFixed(2);
			
			Variables.df.text = "C2RX: " + camera3D.rotationX.toFixed(2);
			Variables.dg.text = "C2RY: " + camera3D.rotationY.toFixed(2);
			Variables.dh.text = "C2RZ: " + camera3D.rotationZ.toFixed(2);
			*/
			
			if (bLeft){
				camera3D.z += nStep;
				lookAtZero();
			}
			
			if (bRight){
				camera3D.z -= nStep;
				lookAtZero();
			}
			
			if (bUp){
				camera3D.x -= nStep;
				lookAtZero();
			}
			
			if (bDown){
				camera3D.x += nStep;
				lookAtZero();
			}
			
			if (zp){
				camera3D.y -= nStep;
				lookAtZero();
			}
			
			if (zn){
				camera3D.y += nStep;
				lookAtZero();
			}
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------------------------
		private function lookAtZero():void
		{
			camera3D.lookAt( new Vector3D(0,0,0) );
		}
		// --------------------------------------------------------------------------------------------------------------
		
		
		
		
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}