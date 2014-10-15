package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	// ----------------------------------------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	// ----------------------------------------------------------------------------------------------------

	
	// ----------------------------------------------------------------------------------------------------
	public class DebugBox extends Sprite
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var debugBoxTitle:String = "";
		private var debugBoxDefaultTitle:String = "Darcey@AllForTheCode.co.uk - DebugBox v1.4 - Click here to drag";
		private var grabBar:Sprite;
		private var closeButton:Sprite;
		public var txtArea:TextField;
		private var ctrlKeyDown:Boolean = false;
		private var shiftKeyDown:Boolean = false;
		private var tf1:TextFormat;
		private var tf2:TextFormat;
		private var txt:TextField;
		private var leftCtrlDown:Boolean = false;
		private var shiftDown:Boolean = false;
		private var fontSize:Number = 11;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// Singleton -----------------------------------------------------------------------------------------------------------------
		public static var Singleton:DebugBox;
		public static function getInstance():DebugBox { if ( Singleton == null ){ Singleton = new DebugBox(); } return Singleton;}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function DebugBox()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function addedToStageHandler(e:Event):void
		{
			//trace("DebugBox: added to stage");
			
			grabBar.useHandCursor = true;
			grabBar.buttonMode = true;
			grabBar.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler,false,0,true);
			//stage.addEventListener(MouseEvent.MOUSE_OUT,mouseUpHandler,false,0,true);
			stage.addEventListener(Event.MOUSE_LEAVE,mouseStageLeaveHandler,false,0,true);
			
			// Listen for key presses to show debug box
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		// ---------------------------------------------------------------------------------------------------------------------------
		public function removedFromStageHandler(e:Event):void
		{
			//trace("DebugBox: removed from stage");
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function init(w:Number = 300,h:Number = 200,visibleByDefault:Boolean=true,debugBoxTitle:String=""):void
		{
			// Ini pos
			this.x = 10;
			this.y = 10;
			this.debugBoxTitle = debugBoxTitle;
			
			// DrawBg to full box
			this.graphics.beginFill(0x000033,0.6);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			
			// Top bar
			grabBar = new Sprite();
			grabBar.graphics.beginFill(0x000000,1);
			grabBar.graphics.drawRect(0,0,w,20);
			grabBar.graphics.endFill();
			grabBar.buttonMode = true;
			grabBar.useHandCursor = true;
			this.addChild(grabBar);
			
			
			
			// Close button
			closeButton = new Sprite();
			closeButton.graphics.beginFill(0x666666,1);
			closeButton.graphics.drawRect(0,0,20,20);
			closeButton.graphics.endFill();
			closeButton.graphics.lineStyle(2,0xFFFFFF,1);
			closeButton.graphics.moveTo(5,5);
			closeButton.graphics.lineTo(15,15);
			closeButton.graphics.moveTo(15,5);
			closeButton.graphics.lineTo(5,15);
			closeButton.x = w - closeButton.width;
			closeButton.buttonMode = true;
			closeButton.mouseEnabled = true;
			closeButton.useHandCursor = true;
			closeButton.addEventListener(MouseEvent.CLICK,closeButtonClickHandler);
			addChild(closeButton);
			
			
			
			// Top bar title
			tf1 = new TextFormat();
			tf1.size = 13;
			tf1.color = 0xFFFFFF;
			//tf.font = "PF Ronda Seven";
			//tf.font = "system";
			
			txt = new TextField();
			txt.embedFonts = false;
			txt.border = false;
			txt.borderColor = 0xFF0000;
			txt.multiline = false;
			txt.background = false;
			txt.width = w - closeButton.width;
			txt.height = 20.5;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.selectable = false;
			if (debugBoxTitle == ""){
				txt.text = debugBoxDefaultTitle;
			} else {
				txt.text = debugBoxTitle;
			}
			txt.defaultTextFormat = tf1;
			txt.setTextFormat(tf1);
			txt.mouseEnabled = false;
			txt.y = 0.5;
			this.addChild(txt);
			
			
			// Debug text box
			tf2 = new TextFormat();
			tf2.size = fontSize;
			tf2.color = 0xFFFFFF;
			
			txtArea = new TextField();
			txtArea.background = false;
			txtArea.border = true;
			txtArea.borderColor = 0x000000;
			txtArea.y = grabBar.y + grabBar.height;
			txtArea.width = w - 1;
			txtArea.height = h - txt.height;
			txtArea.defaultTextFormat = tf2;
			txtArea.setTextFormat(tf2);
			this.addChild(txtArea);
			
			
			
			// Show help
			//help();
			
			// Handle visibility
			this.visible = visibleByDefault;
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		protected function closeButtonClickHandler(event:MouseEvent):void
		{
			this.hide();
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function add(str:String):void
		{
			//txtArea.text += str + "\n";
			txtArea.appendText(str + "\n");
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function clear():void
		{
			txtArea.text = "";
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		
		// ----------------------------------------------------------------------------------------------------
		private function mouseStageLeaveHandler(e:Event):void
		{
			mouseUpHandler(null);
		}
		// ----------------------------------------------------------------------------------------------------
		
		// ----------------------------------------------------------------------------------------------------
		private function mouseDownHandler(e:MouseEvent):void
		{
			this.startDrag();
		}
		// ----------------------------------------------------------------------------------------------------
		
		// ----------------------------------------------------------------------------------------------------
		private function mouseUpHandler(e:MouseEvent):void
		{
			this.stopDrag();
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		
		
		
		
		
		// ----------------------------------------------------------------------------------------------------
		private function keyDownHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 17: this.leftCtrlDown = true; return; break;
				case 16: this.shiftDown = true; return; break;
			}
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		
		
		// ----------------------------------------------------------------------------------------------------
		private function keyUpHandler(e:KeyboardEvent):void
		{
			//trace(e.keyCode);
			
			switch (e.keyCode)
			{
				case 17: this.leftCtrlDown = false; return; break;
				case 16: this.shiftDown = false; return; break;
				case 82: resetPosition(); return; break; // R
				case 68: toggleVisibility(); return; break; // D
				case 67: userClear(); return; break; // C
				case 72: help(); return; break; // H
			}
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function toggleVisibility():void
		{
			if (this.leftCtrlDown && this.shiftDown)
			{
				if (this.visible)
				{
					hide();
				} else {
					show();
				}
			}
		}
		// ----------------------------------------------------------------------------------------------------

		// ----------------------------------------------------------------------------------------------------
		public function resetPosition():void
		{
			if (this.leftCtrlDown && this.shiftDown)
			{
				this.visible = true;
				this.stopDrag();
				this.x = 10;
				this.y = 10;
			}
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function userClear():void
		{
			if (this.leftCtrlDown && this.shiftDown)
			{
				this.txtArea.text = "";
			}
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function show():void
		{
			this.visible = true;
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		// ----------------------------------------------------------------------------------------------------
		public function hide():void
		{
			this.visible = false;
		}
		// ----------------------------------------------------------------------------------------------------
		
		
		public function setFontSize(n:Number=11):void {
			fontSize = n;
			tf2.size = fontSize;
			txtArea.defaultTextFormat = tf2;
			txtArea.setTextFormat(tf2);
		}
		
		
		
		// ----------------------------------------------------------------------------------------------------
		public function help():void
		{
			var msg:String = "";

			msg = "#########################################################" + "\n";
			msg += "DebugBox(): Usage:" + "\n";
			msg += "\t" + "Press CTRL SHIFT D to toggle visibility" + "\n";
			msg += "\t" + "Press CTRL SHIFT R to reset position" + "\n";
			msg += "\t" + "Press CTRL SHIFT C to clear text" + "\n";
			msg += "\t" + "Press CTRL SHIFT H to for help" + "\n";
			msg += "#########################################################";
			add(msg);
			trace(msg);
		}
		// ----------------------------------------------------------------------------------------------------
		
		
	}
	// ----------------------------------------------------------------------------------------------------
}