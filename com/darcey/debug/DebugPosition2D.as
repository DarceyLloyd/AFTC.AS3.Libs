package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com
	
	// ----------------------------------------------------------------------------------------------------
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	// ----------------------------------------------------------------------------------------------------
	
	
	// ----------------------------------------------------------------------------------------------------
	public class DebugPosition2D
	{
	// ----------------------------------------------------------------------------------------------------
		private var stage:Stage;
		private var target:*;
		private var debugBox:DebugBox;
		
		private var shiftKeyPressed:Boolean = false;
		private var nStep:Number = 1;
		private var scaleStep:Number = 0.01;
		private var msg:String;
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
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
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		private function keyDownHandler( e:KeyboardEvent ):void
		{
			var keyCodeRecognised:Boolean = false;
			
			if (shiftKeyPressed){
				
			}
			
			switch (e.keyCode)
			{
				case 72: // h
					traceHelp();
					break;
				
				case 38: // up
					target.y -= nStep;
					keyCodeRecognised = true;
					break;
				case 40: // down
					target.y += nStep;
					keyCodeRecognised = true;
					break;
				case 37: // left
					target.x -= nStep;
					keyCodeRecognised = true;
					break;
				case 39: // right
					target.x += nStep;
					keyCodeRecognised = true;
					break;
				
				case 16: // shift key
					shiftKeyPressed = true;
					break;
				
				case 107: // keypad +
					nStep++;
					keyCodeRecognised = true;
					break;
				
				case 109: // keypad -
					nStep--;
					keyCodeRecognised = true;
					break;
				
				
				case 187: // +
					target.alpha += 0.1;
					nStep++;
					keyCodeRecognised = true;
					break;
				
				case 189: // -
					target.alpha -= 0.1;
					keyCodeRecognised = true;
					break;
				
				
				case 90: // z
					target.width += 1;
					keyCodeRecognised = true;
					break;
				
				case 88: // x
					target.width -= 1;
					keyCodeRecognised = true;
					break;
				
				case 67: // c
					target.height += 1;
					keyCodeRecognised = true;
					break;
				
				case 86: // v
					target.height -= 1;
					keyCodeRecognised = true;
					break;
				
				
				case 87: // w
					target.scaleX = target.scaleY += scaleStep;
					keyCodeRecognised = true;
					break;
				
				case 83: // s
					target.scaleX = target.scaleY -= scaleStep;
					keyCodeRecognised = true;
					break;
				
				case 65: // a
					target.scaleX -= scaleStep;
					keyCodeRecognised = true;
					break;
				
				case 68: // d
					target.scaleX += scaleStep;
					keyCodeRecognised = true;
					break;
			}
			
			if (keyCodeRecognised){
				msg = "DebugPosition2D [" + nStep + "]: ";
				msg += "[ x:" + target.x.toFixed(1) + "   y:" + target.y.toFixed(1) + " ]\t";
				msg += "[ scale:" + target.scaleX.toFixed(2) + " ]\t";
				msg += "[ width:" + target.width.toFixed(1) + "   height:" + target.height.toFixed(1) + " ]\t";
				msg += "[ alpha:" + target.alpha.toFixed(1) + "]";
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
		// ----------------------------------------------------------------------------------------------------
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function traceHelp():void
		{
			trace("#################################################################");
			trace("DebugPosition2D() usage:");
			trace("#################################################################");
			trace("help = h");
			trace("move x,y = arrow keys");
			trace("move step +1 = keypad +");
			trace("move step -1 = keypad -");
			trace("alpha +1 = +     alpha -1 = -");
			trace("width +1 = z     width -1 = x");
			trace("height +1 = c     height -1 = v");
			trace("scale +1 = w     scale -1 = s");
			trace("#################################################################");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// ----------------------------------------------------------------------------------------------------
		private function keyUpHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 16: // shift key
					shiftKeyPressed = false;
					break;
			}
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function dispose():void
		{
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDownHandler );
			stage.removeEventListener( KeyboardEvent.KEY_UP, keyUpHandler );
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		
		// ----------------------------------------------------------------------------------------
		private function addToDebugBox(str:String):void
		{
			if (debugBox)
			{
				debugBox.add(str);				
			}
		}
		// ----------------------------------------------------------------------------------------
	}
}