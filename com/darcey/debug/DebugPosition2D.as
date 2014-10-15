package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class DebugPosition2D
	{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var stage:Stage;
		private var target:*;
		private var debugBox:DebugBox;
		
		private var ctrlKeyPressed:Boolean = false;
		private var shiftKeyPressed:Boolean = false;
		private var altKeyPressed:Boolean = false;
		
		private var nStep:Number = 1;
		private var scaleStep:Number = 0.01;
		private var msg:String;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function DebugPosition2D(stage:Stage,target:*,debugBox:DebugBox=null)
		{
			this.stage = stage;
			this.target = target;
			this.debugBox = debugBox;
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			stage.addEventListener( KeyboardEvent.KEY_UP, keyUpHandler );
			
			trace("DebugPosition2D(): Attached to [" + target + "] name: [" + target.name + "]");
			addToDebugBox("DebugPosition2D(): Attached to [" + target + "] name: [" + target.name + "]");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function keyDownHandler( e:KeyboardEvent ):void
		{
			var keyCodeRecognised:Boolean = false;
			
			//trace("e.keyCode = " + e.keyCode);
			
			// shift = 16
			// ctrl = 17
			// alt = 18
			
			// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			switch (e.keyCode)
			{
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				// Key modifiers
				case 16: // shift key
					shiftKeyPressed = true;
					keyCodeRecognised = true;
					break;
				
				case 17: // ctrl key
					ctrlKeyPressed = true;
					keyCodeRecognised = true;
					break;
				
				case 18: // alt key
					altKeyPressed = true;
					keyCodeRecognised = true;
					break;
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				//trace("Help (Show this message)" + "   =   " + "h");
				case 72: // h
					traceHelp();
					break;
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				//trace("Movement distance       " + "   =   " + "Keypad: " + "+ & -");
				case 107: // keypad +
					nStep++;
					keyCodeRecognised = true;
					break;
				
				case 109: // keypad -
					nStep--;
					keyCodeRecognised = true;
					break;
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				case 38: // up
					//trace("Movement x & y          " + "   =   " + "Arrow keys");
					if (!shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.y -= nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Width & Height          " + "   =   " + "Shift + Arrow keys (+/- Movement distance)");
					if (shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.height += nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Scale                   " + "   =   " + "ALT + Arrow keys (+/- 0.1)");
					if (!shiftKeyPressed && !ctrlKeyPressed && altKeyPressed){
						target.scaleY += 0.01;
						keyCodeRecognised = true;
					}
				
					//trace("Alpha                   " + "   =   " + "CTRL + Arrow keys Up & Down (+/- 0.1)");
					if (!shiftKeyPressed && ctrlKeyPressed && !altKeyPressed){
						target.alpha += 0.01;
						keyCodeRecognised = true;
					}
					break;
				case 40: // down
					//trace("Movement x & y          " + "   =   " + "Arrow keys");
					if (!shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.y += nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Width & Height          " + "   =   " + "Shift + Arrow keys (+/- Movement distance)");
					if (shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.height -= nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Scale                   " + "   =   " + "ALT + Arrow keys (+/- 0.1)");
					if (!shiftKeyPressed && !ctrlKeyPressed && altKeyPressed){
						target.scaleY -= 0.01;
						keyCodeRecognised = true;
					}
				
					//trace("Alpha                   " + "   =   " + "CTRL + Arrow keys Up & Down (+/- 0.1)");
					if (!shiftKeyPressed && ctrlKeyPressed && !altKeyPressed){
						target.alpha -= 0.01;
						keyCodeRecognised = true;
					}
					break;
				case 37: // left
					//trace("Movement x & y          " + "   =   " + "Arrow keys");
					if (!shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.x -= nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Width & Height          " + "   =   " + "Shift + Arrow keys (+/- Movement distance)");
					if (shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.width -= nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Scale                   " + "   =   " + "ALT + Arrow keys (+/- 0.1)");
					if (!shiftKeyPressed && !ctrlKeyPressed && altKeyPressed){
						target.scaleX -= 0.01;
						keyCodeRecognised = true;
					}
				
					//trace("Rotation                " + "   =   " + "CTRL + Arrow keys Left & Right (+/- 1)");
					if (!shiftKeyPressed && ctrlKeyPressed && !altKeyPressed){
						target.rotation -= 2;
						keyCodeRecognised = true;
					}
					break;
				case 39: // right
					//trace("Movement x & y          " + "   =   " + "Arrow keys");
					if (!shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.x += nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Width & Height          " + "   =   " + "Shift + Arrow keys (+/- Movement distance)");
					if (shiftKeyPressed && !ctrlKeyPressed && !altKeyPressed){
						target.width += nStep;
						keyCodeRecognised = true;
					}
					
					//trace("Scale                   " + "   =   " + "ALT + Arrow keys (+/- 0.1)");
					if (!shiftKeyPressed && !ctrlKeyPressed && altKeyPressed){
						target.scaleX += 0.01;
						keyCodeRecognised = true;
					}
				
					//trace("Rotation                " + "   =   " + "CTRL + Arrow keys Left & Right (+/- 1)");
					if (!shiftKeyPressed && ctrlKeyPressed && !altKeyPressed){
						target.rotation += 2;
						keyCodeRecognised = true;
					}
					break;
				// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
				
				
				
				
			}
			// END SWITCH STATEMENT
			// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
			
			
			if (keyCodeRecognised){
				msg = "DebugPosition2D [Step:" + nStep + "]: ";
				//msg += "[ ctrl:" + ctrlKeyPressed + "] " + "[ shift:" + shiftKeyPressed + "] " + "[ alt:" + altKeyPressed + "]   ";
				msg += "[ x:" + target.x.toFixed(1) + "   y:" + target.y.toFixed(1) + " ]   ";
				msg += "[ width:" + target.width.toFixed(1) + "   height:" + target.height.toFixed(1) + " ]   ";
				msg += "[ scaleX:" + target.scaleX.toFixed(2) + "   scaleY:" + target.scaleY.toFixed(2) + " ]   ";
				msg += "[ rotation:" + target.rotation.toFixed(2) + "]   ";
				msg += "[ alpha:" + target.alpha.toFixed(2) + "]";
				trace(msg);
				addToDebugBox(msg);
				if (!target.visible)
				{
					msg = "Warning: " + target + " visible = false";
					trace(msg);
					addToDebugBox(msg);
				}
			} else {
				msg = "##### DebugPosition2D(): key code not recognised keycode = " + e.keyCode;
				trace(msg);
				addToDebugBox(msg);
			}
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function traceHelp():void
		{
			trace("##########################################################################################");
			trace("DebugPosition2D() usage:");
			trace("##########################################################################################");
			trace("Help (Show this message)" + "   =   " + "h");
			trace("Movement distance       " + "   =   " + "Keypad: " + "+ & -");
			trace("Movement x & y          " + "   =   " + "Arrow keys");
			trace("Width & Height          " + "   =   " + "Shift + Arrow keys (+/- Movement distance)");
			trace("Scale                   " + "   =   " + "ALT + Arrow keys (+/- 0.01)");
			trace("Rotation                " + "   =   " + "CTRL + Arrow keys Left & Right (+/- 1)");
			trace("Alpha                   " + "   =   " + "CTRL + Arrow keys Up & Down (+/- 0.01)");
			trace("##########################################################################################");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function keyUpHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{				
				case 16: // shift key
					shiftKeyPressed = false;
					break;
				
				case 17: // ctrl key
					ctrlKeyPressed = false;
					break;
				
				case 18: // alt key
					altKeyPressed = false;
					break;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			stage.removeEventListener( KeyboardEvent.KEY_UP, keyUpHandler );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function addToDebugBox(str:String):void
		{
			if (debugBox)
			{
				debugBox.add(str);				
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
}