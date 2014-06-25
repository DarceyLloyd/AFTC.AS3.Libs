package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com
	
	// ----------------------------------------------------------------------------------------------------
	import away3d.sprites.MovieClipSprite;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	// ----------------------------------------------------------------------------------------------------
	
	// ------------------------------------------------------------------------------------------------------------
	public class DebugSpritePosition3D
	{
		// ------------------------------------------------------------------------------------------------------------
		private var stage:Stage;
		public var target:*;
		private var nStep:Number = 10;
		private var msg:String = "";
		// ------------------------------------------------------------------------------------------------------------
		
		
	
		
		// ------------------------------------------------------------------------------------------------------------
		public function DebugSpritePosition3D(
			stage:Stage,
			target:MovieClipSprite
		)
		{
			this.stage = stage;
			this.target = target;
			
		
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,handleKeyDown);
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function handleKeyDown(e:KeyboardEvent):void
		{
			//trace("handleKeyDown");			
			
			
			/*
			81  = q					87 = w				69 = e				82 = r
			65 = a					83 = s				68 = d				70 = f
			38 = up					40 = down			37 = left			39 = right
			189 = keypad -			107 = keypad +
			32 = space
			90 = z
			88 = x
			67 = c
			86 = v
			*/
			

			
			//trace(e.keyCode);
			
			/*
			switch (e.keyCode)
			{
				
				case 38: target.y += 1;  break;
				case 40: target.y -= 1;  break;
				case 37: target.x -= 1; break;
				case 39: target.x += 10; break;
				case 107: target.z += 1; break;
				case 189: target.z -= 1; break;
				
				case 82: nStep += 1; break;
				case 70: nStep -= 1; break;
				
			
				
				default:
					trace("UNHANDLED KEY CODE: " + e.keyCode);
					//msg = "Key press = " + e.keyCode;
					//trace(msg);
					break;
			}
			*/
			
			
			
			target.z += 10;
			traceout();
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// ----------------------------------------------------------------------------------------
		private function traceout():void
		{
			msg = "";
			msg += "target:" + target + "\t";
			msg += "\t" + "x:" + target.x.toFixed(1);
			msg += "\t\t" + "y:" + target.y.toFixed(1);
			msg += "\t\t" + "z:" + target.z.toFixed(1);
			
			
			msg += "\t\t" + "step:" + nStep;
			trace(msg);
		}
		// ----------------------------------------------------------------------------------------
		
		

		
		
		
		
	}
	// ------------------------------------------------------------------------------------------------------------
	
	
	
	
}