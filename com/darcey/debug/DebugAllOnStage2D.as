package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	// ------------------------------------------------------------------------------------------------------------
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	// ------------------------------------------------------------------------------------------------------------
	
	// ------------------------------------------------------------------------------------------------------------
	public class DebugAllOnStage2D
	{
		// ------------------------------------------------------------------------------------------------------------
		private var stage:Stage;
		private var container:DisplayObjectContainer;
		public var reverseY:Boolean = false;
		private var nStep:Number = 1;
		private var shiftDown:Boolean = false;
		
		private var target:*;
		// ------------------------------------------------------------------------------------------------------------
		
		
		
		// ------------------------------------------------------------------------------------------------------------
		public function DebugAllOnStage2D(stage:Stage,container:DisplayObjectContainer,reverseY:Boolean = true)
		{
			trace("");
			trace("################################################################################################################");
			trace("DebugAllOnStage2D(container:"+container+"): PRESS LEFT SHIFT AND MOUSE DOWN TO SELECT ITEM TO DEBUG POSITION");
			trace("DebugAllOnStage2D: PRESS h for help.");
			trace("");
			trace("DebugAllOnStage2D: Attaching itself to the following display objects:");
			this.stage = stage;
			this.container = container;
			this.reverseY = reverseY;
			
			// Loop through everything on the stage and attach an event listener to it (mouse down so we can drag off to prevent click)
			var level0:Array = new Array();
			var level1:Array = new Array();
			var items:Array = new Array();
			
			var i:uint;
			
			for (i = 0; i <= container.numChildren-1; i++)
			{
				//level0.push(container.getChildAt(i));
				items.push(container.getChildAt(i));
				trace("DebugAllOnStage2D: container.getChildAt("+i+") = " + container.getChildAt(i) );
				
			}
			
			/*
			for (i = 0; i <= level0.length-1; i++)
			{
				//level1.push(level0[i].getChildAt(i));
				//trace("level0["+i+"].getChildAt("+i+") = " + level0[i].getChildAt(i) );
				
				try { 
					level1.push(level0[i].getChildAt(i));
					trace("DebugAllOnStage2D: " + "level0["+i+"].getChildAt("+i+") = " + level0[i].getChildAt(i) );
				} catch (e:Error) { 
					items.push(container.getChildAt(i)); 
				}
				
			}
			
			
			for (i = 0; i <= level1.length-1; i++)
			{
				try { 
					level1.push(level1[i].getChildAt(i));
					trace("\t\t" + "level1["+i+"].getChildAt("+i+") = " + level1[i].getChildAt(i) );
				} catch (e:Error) { 
					items.push(level0[i].getChildAt(i)); 
				}
			}
			*/
			
			for each (var item:* in items)
			{
				item.addEventListener(MouseEvent.MOUSE_DOWN,selectionHandler);
			}
			
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,handleKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,handleKeyUp);
			
			
			traceHelp();
			
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function selectionHandler(e:MouseEvent):void
		{
			if (this.shiftDown){
				target = e.currentTarget;
				trace("");
				trace("DebugAllOnStage2D: Target has been set to [" + e.currentTarget + "]");
				trace("");
			}
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function handleKeyUp(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.SHIFT: this.shiftDown = false; break;
				case 72: traceHelp(); break;
			}
			
			
			
			
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
			72 = h
			*/
			
			switch (e.keyCode)
			{
				case Keyboard.SHIFT: this.shiftDown = true; return; break;
			}
			
			
			if (target == null){
				//trace("DebugAllOnStage2D(): TARGET IS NULL!");
				return;
			}
			
			switch (e.keyCode){
				
				//case 17: break; // shift
				
				case 90: target.width -= nStep; traceout(); break; // dec width
				case 88: target.width += nStep; traceout(); break; // inc width
				
				case 67: target.height -= nStep; traceout(); break; // dec width
				case 86: target.height += nStep; traceout(); break; // inc width
				
				
				
				case 32: target.rotationX = 0; target.rotationY = 0; target.rotationZ = 0; break;
				
				case 81: target.rotationX += nStep; traceout(); break;
				case 65: target.rotationX -= nStep; traceout(); break;
				
				case 87: target.rotationY += nStep; traceout(); break;
				case 83: target.rotationY -= nStep; traceout(); break;
				
				case 69: target.rotationZ += nStep; traceout(); break;
				case 68: target.rotationZ -= nStep; traceout(); break;
				
				case 38: target.y += reverseY? -nStep: nStep; traceout(); break;
				case 40: target.y -= reverseY? -nStep: nStep; traceout(); break;
				case 37: target.x -= nStep; traceout(); break;
				case 39: target.x += nStep; traceout(); break;
				case 107: target.z += nStep; traceout(); break;
				case 189: target.z -= nStep; traceout(); break;
				
				case 82: nStep += 1; traceout(); break;
				case 70: nStep -= 1; traceout(); break;
				
				
				
				default:
					trace("DebugAllOnStage2D: Unhandled key code [" + e.keyCode + "]");
					break;
			}
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function traceHelp():void
		{
			trace("");
			trace("################################################################################################################");
			trace("DebugAllOnStage2D: HELP - The keys are");
			
			trace("DebugAllOnStage2D: up = move up (- value step)");
			trace("DebugAllOnStage2D: down = move down (+ value step)");
			trace("DebugAllOnStage2D: left = move left (- value step)");
			trace("DebugAllOnStage2D: right = move right (+ value step)");
			
			trace("DebugAllOnStage2D: q = rotationX + value step");
			trace("DebugAllOnStage2D: a = rotationX - value step");
			trace("DebugAllOnStage2D: w = rotationY + value step");
			trace("DebugAllOnStage2D: s = rotationY - value step");
			trace("DebugAllOnStage2D: e = rotationZ + value step");
			trace("DebugAllOnStage2D: d = rotationZ - value step");
			
			trace("DebugAllOnStage2D: z = width + value step");
			trace("DebugAllOnStage2D: x = width - value step ");
			trace("DebugAllOnStage2D: c = height + value step ");
			trace("DebugAllOnStage2D: v = height - value step ");
			
			trace("DebugAllOnStage2D: r = value step +1");
			trace("DebugAllOnStage2D: f = value step -1");
			
			trace("DebugAllOnStage2D: space = Reset rotations to 0 ");
			trace("DebugAllOnStage2D: Selection = LEFT SHIFT & LEFT MOUSE DOWN");
			trace("################################################################################################################");
			trace("");
			
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function limitDegreesTo360(degrees:Number):Number
		{
			var rotations:Number = Math.floor(Math.abs(degrees)/360);
			return Math.round(Math.abs(degrees) - (rotations * 360));
		}
		// ------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------
		private function traceout():void
		{
			var msg:String = "";
			
			try {
				msg += "" + target.name + ": ";
			} catch (e:Error) {}; 
			
			try {
				msg += "\t" + "w:" + target.width;
				msg += "\t" + "h:" + target.height;
			} catch (e:Error) {};
			
			msg += "\t" + "x:" + target.x;
			msg += "\t" + "y:" + target.y;
			msg += "\t" + "z:" + target.z;
			
			//msg += "\n";
			msg += "\t" + "rx:" + Math.round(target.rotationX);
			msg += "\t" + "ry:" + Math.round(target.rotationY);
			msg += "\t" + "rz:" + Math.round(target.rotationZ);
			
			//msg += "\n";
			
			msg += "\t" + "nStep:" + nStep;
			trace(msg);
		}
		// ------------------------------------------------------------------------------------------------------------
	}
	// ------------------------------------------------------------------------------------------------------------
}