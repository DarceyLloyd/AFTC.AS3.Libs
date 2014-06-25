package com.darcey.debug
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class FTrace extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var bg:Sprite;
		private var tf1:TextFormat;
		private var txtTitle:TextField;
		
		private var tf2:TextFormat;
		private var txtValue:TextField;
		
		private var label:String;
		private var caller:Object;
		private var varLevel1:*;
		private var varLevel2:*;
		private var traceToConsole:Boolean = false;
		
		private var updateInterval:Number = 300;
		private var timer:Timer;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function FTrace(label:String,caller:Object,varLevel1:String,varLevel2:String=null,updateInterval:Number = 300,traceToConsole:Boolean=false)
		{			
			this.label = label;
			this.caller = caller;
			this.varLevel1 = varLevel1;
			this.varLevel2 = varLevel2;
			this.updateInterval = updateInterval;
			this.traceToConsole = traceToConsole;
			
			// CHECK VARIABLE CAN BE ACCESSED!
			try {
				if (varLevel2 != null){
					trace("FTrace: label = " + caller[varLevel1][varLevel2]);
				} else {
					trace("FTrace: label = " + caller[varLevel1]);
				}
			} catch (e:Error) {
				trace("########################################################################");
				trace("FTrace error:");
				trace("\t" + "varLevel1 = " + varLevel1);
				trace("\t" + "varLevel2 = " + varLevel2);
				trace("########################################################################");
				return;
			}
			
			
			if (varLevel2 != null){
				trace("FTrace: " + caller[varLevel1][varLevel2]);
			} else {
				trace("FTrace: " + caller[varLevel1]);
			}
			trace("FTrace: waiting to be attached to stage");
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			this.buttonMode = true;
			this.useHandCursor = true;
			
			bg = new Sprite();
			addChild(bg);
			
			tf1 = new TextFormat();
			tf1.color = 0xFFFFFF;
			
			txtTitle = new TextField();
			txtTitle.autoSize = TextFieldAutoSize.LEFT;
			txtTitle.height = 25;
			txtTitle.selectable = false;
			txtTitle.mouseEnabled = false;
			txtTitle.x = 3;
			txtTitle.y = 3;
			txtTitle.text = label;
			txtTitle.defaultTextFormat = tf1;
			txtTitle.setTextFormat(tf1);
			addChild(txtTitle);
			
			txtValue = new TextField();
			txtValue.autoSize = TextFieldAutoSize.LEFT;
			txtValue.height = 25;
			txtValue.selectable = true;
			txtValue.mouseEnabled = true;
			txtValue.x = txtTitle.x + txtTitle.width + 5;
			txtValue.y = 3;
			txtValue.border = true;
			txtValue.background = true;
			
			if (varLevel2 != null){
				txtValue.text = caller[varLevel1][varLevel2] + " ";
			} else {
				txtValue.text = caller[varLevel1] + " ";
			}
			
			
			//txtValue.defaultTextFormat = tf1;
			//txtValue.setTextFormat(tf1);
			addChild(txtValue);
						
			bg.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			bg.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			bg.addEventListener(MouseEvent.MOUSE_UP,mouseOutHandler);
			stage.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			
			
			timer = new Timer(updateInterval);
			timer.addEventListener(TimerEvent.TIMER,update);
			timer.start();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseDownHandler(e:MouseEvent):void
		{
			this.startDrag();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseOutHandler(e:MouseEvent):void
		{
			this.stopDrag();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var w:Number = 0;
		private var h:Number = 25;
		private function update(e:TimerEvent):void
		{
			if (varLevel2 != null){
				switch (typeof(caller[varLevel1][varLevel2])){
					case "string":
						txtValue.text = caller[varLevel1][varLevel2] + " ";
						break;
					
					case "number":
						txtValue.text = Number(caller[varLevel1][varLevel2]).toFixed(2);
						break;
				}
			} else {
				switch (typeof(caller[varLevel1])){
					case "string":
						txtValue.text = caller[varLevel1] + " ";
						break;
					
					case "number":
						txtValue.text = Number(caller[varLevel1]).toFixed(2);
						break;
				}
			}
			
			
			
			
			w = txtTitle.width + 10 + txtValue.width;
			
			bg.graphics.clear();
			bg.graphics.beginFill(0x000000,1);
			bg.graphics.drawRect(0,0,w+5,h);
			//bg.graphics.beginFill(Math.random()*0xFFFFFF,1);
			bg.graphics.beginFill(0x000000,1);
			bg.graphics.drawRect(0,0,txtTitle.width+5,h);
			bg.graphics.endFill();
			
			
			if (varLevel2 != null){
				trace("FT: " + label + " = " + caller[varLevel1][varLevel2]);
			} else {
				trace("FT: " + label + " = " + caller[varLevel1] + " ");
			}			
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function dispose():void
		{
			timer.removeEventListener(TimerEvent.TIMER,update);
			timer.stop();
			
			//this.removeEventListener(Event.EXIT_FRAME,generate);
			new RemoveAllChildrenIn(this);
			
			bg.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			bg.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			bg.removeEventListener(MouseEvent.MOUSE_UP,mouseOutHandler);
			stage.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}