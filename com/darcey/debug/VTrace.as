/*
Author: Darcey@AllForTheCode.co.uk
Usage:
	var myObject:Object;
	myObject = new Object();
	myObject.age = 3;

	var vt1:VTrace;
	vt1 = new VTrace(this,"myObject","age");
	// vt1 = new VTrace(caller:object,var name in caller:String,sub paramater name on caller var:String,refreshRate:Number);
	vt1.x = 10;
	vt1.y = 100;
	addChild(vt1);

	// To clean up use vt1.dispose();

*/
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
	public class VTrace extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var dragBox:Sprite;
		private var tfTitle:TextFormat;
		private var tfValue:TextFormat;
		private var txtTitle:TextField;
		private var txtValue:TextField;
		
		private var timer:Timer;
		private var refreshRate:Number = 500;
		
		private var type:String;
		
		public var caller:Object;
		public var p1:*;
		public var p2:*;
		public var value:String;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function VTrace(caller:Object,p1:String,p2:String="",refreshRate:Number = 500)
		{
			this.caller = caller;
			this.p1 = p1;
			this.p2 = p2;
			this.refreshRate = refreshRate;
			
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			
			getValue();
			
			if (type == null){
				trace("VTrace(): WARNING type = null");
				return;
			}
			
			if (value == undefined){
				trace("VTrace(): WARNING value = undefined");
				return;
			}
			
			buildUI();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function getValue():void
		{
			var temp:*;
			
			
			//trace(typeof(caller[p1]));
			switch(typeof(caller[p1]))
			{
				case "string":
					type="string";
					value = String(caller[p1]);
					break;
				
				case "boolean":
					type="boolean";
					temp = ([caller+"."+p1]);
					value = String( Boolean( caller[p1] ) );
					break;
				
				case "number":
					type="number";
					value = parseFloat( caller[p1] ).toFixed(2);
					break;
				
				case "object":
					type="object";
					try {
						if (typeof(caller[p1][p2])=="number")
						{
							value = parseFloat( caller[p1][p2] ).toFixed(2);
						} else {
							value = String(caller[p1][p2]);
						}
					} catch (e:Error) {
						value = "NA";
					}
					break;
				
				case "object Dictionary":
					type="dictionary";
					try {
						if (typeof(caller[p1][p2])=="number")
						{
							value = parseFloat( caller[p1][p2] ).toFixed(2);
						} else {
							value = String(caller[p1][p2]);
						}
					} catch (e:Error) {
						value = "NA";
					}
					break;
			}
			
			
			//trace("VTrace(): type = " + type);
			//trace("VTrace(): value = " + value);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function dragBoxMouseDownHandler(e:MouseEvent):void
		{
			this.startDrag();
		}
		private function stopDragHandler(e:*):void
		{
			this.stopDrag();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function buildUI():void
		{
			if (!dragBox){
				dragBox = new Sprite();
				dragBox.useHandCursor = true;
				dragBox.buttonMode = true;
				addChild(dragBox);
				dragBox.y = -1;
				
				dragBox.addEventListener(MouseEvent.MOUSE_DOWN,dragBoxMouseDownHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP,stopDragHandler);
				//dragBox.addEventListener(MouseEvent.MOUSE_OUT,stopDragHandler);
				stage.addEventListener(Event.MOUSE_LEAVE,stopDragHandler);
				
			}
			
			// Text title
			tfTitle = new TextFormat();
			tfTitle.color = 0x000000;
			tfTitle.bold = true;
			
			if (!txtTitle){
				txtTitle = new TextField();
				txtTitle.autoSize = TextFieldAutoSize.LEFT;
				txtTitle.x = 25;
				txtTitle.y = 2;
				addChild(txtTitle);
			}
			if (p1 != null && p2 != null){
				txtTitle.text = caller + "." + p1 + "." + p2 + " = ";
			} else if (p1 != null && p2 == null){
				txtTitle.text = caller + "." + p1 + " = ";
			}
			txtTitle.setTextFormat(tfTitle);
			
			
			// Text value
			tfValue = new TextFormat();
			tfValue.color = 0x000000;
			tfValue.bold = false;
			
			if (!txtValue){
				txtValue = new TextField();
				txtValue.autoSize = TextFieldAutoSize.LEFT;
				txtValue.border = true;
				txtValue.x = txtTitle.x + txtTitle.width + 3;
				txtValue.y = 2;
				addChild(txtValue);
			}
			txtValue.text = value;
			txtValue.setTextFormat(tfValue);
			
			
			update();
			updateUsingTimer()
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function update():void
		{
			getValue();
			txtValue.text = value;
			txtValue.setTextFormat(tfValue);
			
			dragBox.graphics.clear();
			dragBox.graphics.beginFill(0x5555CC,1);
			dragBox.graphics.drawRect(0,0,20,27);
			dragBox.graphics.endFill();
			
			this.graphics.clear();
			this.graphics.beginFill(0xFFFFFF,1);
			this.graphics.lineStyle(1,0x000066);
			this.graphics.drawRect(0,0,this.width+5,24);
			this.graphics.endFill();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function updateUsingTimer():void
		{			
			if (timer){
				try {
					timer.removeEventListener(TimerEvent.TIMER,timerEventHandler);
				} catch (e:Error) {}
				timer.stop();
				timer = null;
			}
			
			timer = new Timer(refreshRate);
			timer.addEventListener(TimerEvent.TIMER,timerEventHandler);
			timer.start();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function timerEventHandler(e:TimerEvent):void
		{
			update();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function stopTimerUpdate():void
		{
			if (timer){
				try {
					timer.removeEventListener(TimerEvent.TIMER,timerEventHandler);
				} catch (e:Error) {}
				timer.stop();
				timer = null;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			if (timer){
				try {
					timer.removeEventListener(TimerEvent.TIMER,timerEventHandler);
				} catch (e:Error) {}
				timer.stop();
				timer = null;
			}
			
			try {
				dragBox.removeEventListener(MouseEvent.MOUSE_DOWN,dragBoxMouseDownHandler);
			} catch (e:Error) {}
			try {
				stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragHandler);
			} catch (e:Error) {}
			try {
				stage.removeEventListener(Event.MOUSE_LEAVE,stopDragHandler);
			} catch (e:Error) {}
			
			
			new RemoveAllChildrenIn(this);
			dragBox.graphics.clear();
			this.graphics.clear();
			
			dragBox = null;
			caller = null;
			p1 = null;
			p2 = null;
			txtTitle = null;
			tfTitle = null;
			txtValue = null;
			tfValue = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}