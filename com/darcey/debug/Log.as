package com.darcey.debug
{		
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	// Author: Darcey.Lloyd@gmail.com
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.describeType;
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Log
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private static var Singleton:Log;
		public static function getInstance():Log{
			if ( Singleton == null ){ 
				Singleton = new Log(); 
			}
			return Singleton;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var _stage:Stage;
		public var debugText:String = "";
		public var visualDebugWindow:Sprite;
		public var visualDebugWidth:Number = 800;
		public var visualDebugHeight:Number = 400;
		private var dragBar:Sprite;
		private var btnClose:Sprite;
		private var btnScrollBg:Sprite;
		private var btnScroll:Sprite;
		public var textFormatTitle:TextFormat;
		public var visualDebugTitle:TextField;
		public var textFormatBody:TextFormat;
		public var visualDebugBody:TextField;
		
		private var range:Number = 0;
		private var step:Number = 0;
		private var targetScrollV:Number = 0;
		
		public var globalDisable:Boolean = false;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Log():void{}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		

		
		private var ctrlDown:Boolean = false;
		private var shiftDown:Boolean = false;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function get stage():Stage{
			return _stage;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set stage(stage:Stage):void{
			this._stage = stage;
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function keyDownHandler(e:KeyboardEvent):void
		{
			//trace("keyDownHandler()");
			
			switch (e.keyCode)
			{
				case 17: ctrlDown = true; return; break;
				case 16: shiftDown = true; return; break;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function keyUpHandler(e:KeyboardEvent):void
		{
			//trace("keyUpHandler()");
			//trace(e.keyCode);
			
			switch (e.keyCode)
			{
				case 17: ctrlDown = false; break;
				case 16: shiftDown = false; break;
				case 68: // D
					if (ctrlDown && shiftDown){
						//trace("TOGGLE(): ctrlDown:" + ctrlDown + "  shiftDown:" + shiftDown);
						toggleVisibility();
					}
				break;
				case 67:
					if (ctrlDown && shiftDown){
						//trace("COPY(): ctrlDown:" + ctrlDown + "  shiftDown:" + shiftDown);
						copyDebugData();
					}
					break; // C
				
				case 72 :
					help(); 
				break; 
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function toggleVisibility():void
		{
			if (globalDisable){ dispose(); return; }
			
			//trace("toggleVisibility()");
			if (ctrlDown && shiftDown){
				if (!visualDebugWindow){
					show();
				} else {
					hide();
				}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function show():void
		{
			if (globalDisable){ dispose(); return; }
			
			//trace("show()");
			if (_stage == null){
				trace("Log.show(): ERROR: stageRef = null! Please set it to stage");
				return;
			}
			
			if (!visualDebugWindow){
				buildVisualDebug();
			}
			
			if (_stage){
				_stage.addChild(visualDebugWindow);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function hide():void
		{
			if (globalDisable){ dispose(); return; }
			
			//trace("hide()");
			if (_stage == null){
				trace("Log.hide(): ERROR: stageRef = null! Please set it to stage");
				return;
			}
			
			if (visualDebugWindow){
				try {
					_stage.removeChild(visualDebugWindow);
				} catch (e:Error) {}
			}
			
			disposeOfVisualDebug();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function copyDebugData():void
		{
			if (globalDisable){ dispose(); return; }
			
			this.warn("Log(): Debug text has been copied to the OS clipboard!");
			//System.setClipboard(console);
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, debugText);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function help():void
		{
			trace("");
			trace("#############################################################################################");
			trace("######                                TTRACE / LOG USAGE                               ######");
			trace("#############################################################################################");
			trace("USAGE: var t = new Ttrace(enabled:Boolean);");
			trace("USAGE: t.string(arg:String)");
			trace("USAGE: t.show(); // REQUIRES: t.stage = stage;");
			trace("USAGE: t.hide(); // REQUIRES: t.stage = stage;");
			trace("USAGE: t.clear()");
			trace("USAGE: t.disposoe()");
			trace("USAGE: t.help()");
			trace("VARIABLES: enableVisualDebug:Boolean = default:false");
			trace("VARIABLES: stage:Stage = default:null");
			trace("VARIABLES: visualDebugWindowWidth:Number = default:800");
			trace("VARIABLES: visualDebugWindowHeight:Number = default:400");
			trace("");
			trace("KEYS: CTRL + SHIFT + D = SHOW/HIDE VISUAL DEBUG. // see show requirements");
			trace("KEYS: CTRL + SHIFT + C = COPY TRACE LOG TO COPY BUFFER");
			trace("#############################################################################################");
			trace("");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function div():void
		{
			if (globalDisable){ dispose(); return; }
			
			var msg:String = "############################################################################";
			trace(msg);
			update(msg);
			msg = ""; msg = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function warn(arg:String):void
		{	
			if (globalDisable){ dispose(); return; }
			
			var msg:String = "############################################################################\n";
			msg += arg + "\n";
			msg += "############################################################################";
			trace(msg);
			update(msg);
			msg = ""; msg = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function s(arg:String):void { this.string(arg); }
		public function str(arg:String):void { this.string(arg); }
		public function string(arg:String):void
		{
			if (globalDisable){ dispose(); return; }
			
			var msg:String = "";
			msg = arg;
			trace(msg);
			update(msg);
			msg = ""; msg = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function a(arg:Array):void { this.array(arg); }
		public function arr(arg:Array):void { this.array(arg); }
		public function array(arg:Array):void
		{
			if (globalDisable){ dispose(); return; }
			
			var msg:String = "";
			
			msg += "Array length: " + arg.length + "\n"
			for(var s:String in arg){
				msg += "\t" + s + " = " + arg[s] + "\n"; 
			}
			trace(msg);
			
			update(msg);
			msg = ""; msg = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function o(arg:Object):void { this.object(arg); }
		public function obj(arg:Object):void { this.object(arg); }
		public function object(arg:Object):void
		{
			if (globalDisable){ dispose(); return; }
			
			var msg:String = "";
			
			try {
				msg += "Object name: " + arg.name + "\n"
			} catch (e:Error) {}
			msg += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" +  "\n"
			try {
				msg += describeType( arg ).toXMLString() + "\n";
			} catch (e:Error) {}
			msg += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" +  "\n"
			for(var id:String in arg) {
				var value:Object = arg[id];
				
				msg += "\t" + id + " = " + value + "\n";
			}
			msg += "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" +  "\n"
			trace(msg);
			
			update(msg);
			msg = ""; msg = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function update(str:String):void
		{
			if (globalDisable){ dispose(); return; }
			
			debugText += (str + "\n");
			if (visualDebugBody){
				visualDebugBody.text = debugText;
				visualDebugBody.scrollV = visualDebugBody.maxScrollV;
			}
			
			if (btnScroll){
				btnScroll.y = visualDebugHeight - (btnClose.height);
			}
			//trace(visualDebugBody.maxScrollV);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function buildVisualDebug():void
		{
			if (globalDisable){ dispose(); return; }
			
			//trace("buildVisualDebug()");
			
			if (_stage == null){
				trace("Log.buildVisualDebug(): ERROR: stageRef = null! Please set it to stage");
				return;
			}
			
			disposeOfVisualDebug();
			
			visualDebugWindow = new Sprite();
			visualDebugWindow.x = 10;
			visualDebugWindow.y = 10;
			visualDebugWindow.graphics.beginFill(0xFFFFFF,0.9);
			visualDebugWindow.graphics.drawRect(0,0,visualDebugWidth,visualDebugHeight);
			visualDebugWindow.graphics.endFill();
			
			dragBar = new Sprite();
			dragBar.graphics.beginFill(0xFFFFFF,1);
			dragBar.graphics.drawRect(0,0,visualDebugWidth,24);
			dragBar.graphics.endFill();
			visualDebugWindow.addChild(dragBar);
			dragBar.addEventListener(MouseEvent.MOUSE_DOWN,dragBarStartDragHandler);
			dragBar.addEventListener(MouseEvent.MOUSE_UP,dragBarStopDragHandler);
			dragBar.addEventListener(MouseEvent.RELEASE_OUTSIDE,dragBarStopDragHandler);
			dragBar.addEventListener(Event.MOUSE_LEAVE,dragBarStopDragHandler);
			dragBar.addEventListener(Event.REMOVED,dragBarStopDragHandler);
			
			btnClose = new Sprite();
			btnClose.useHandCursor = true;
			btnClose.buttonMode = true;
			btnClose.x = visualDebugWidth - 25;
			btnClose.y = 0;
			btnCloseMouseOutHandler(null);
			visualDebugWindow.addChild(btnClose);
			btnClose.addEventListener(MouseEvent.CLICK,btnCloseClickHandler);
			btnClose.addEventListener(MouseEvent.MOUSE_OVER,btnCloseMouseOverHandler);
			btnClose.addEventListener(MouseEvent.MOUSE_OUT,btnCloseMouseOutHandler);
			
			btnScrollBg = new Sprite();
			btnScrollBg.x = visualDebugWidth - 25;
			btnScrollBg.y = dragBar.height;
			btnScrollBg.graphics.beginFill(0x999999,1);
			btnScrollBg.graphics.drawRect(0,0,25,visualDebugHeight-dragBar.height);
			btnScrollBg.graphics.endFill();
			visualDebugWindow.addChild(btnScrollBg);
			
			btnScroll = new Sprite();
			btnScroll.useHandCursor = true;
			btnScroll.buttonMode = true;
			btnScroll.x = visualDebugWidth - 25;
			btnScroll.y = dragBar.height;
			btnScroll.graphics.beginFill(0x0000CC,1);
			btnScroll.graphics.drawRect(0,0,25,25);
			btnScroll.graphics.endFill();
			visualDebugWindow.addChild(btnScroll);
			btnScroll.addEventListener(MouseEvent.MOUSE_DOWN,btnScrollStartDragHandler);
			btnScroll.addEventListener(MouseEvent.MOUSE_UP,btnScrollStopDragHandler);
			btnScroll.addEventListener(MouseEvent.RELEASE_OUTSIDE,btnScrollStopDragHandler);
			//btnScroll.addEventListener(Event.MOUSE_LEAVE,btnScrollStopDragHandler);
			//btnScroll.addEventListener(Event.REMOVED,btnScrollStopDragHandler);
			
			textFormatTitle = new TextFormat();
			textFormatTitle.color = 0x000000;
			visualDebugTitle = new TextField();
			visualDebugTitle.x = 2;
			visualDebugTitle.y = 2;
			visualDebugTitle.autoSize = TextFieldAutoSize.LEFT;
			visualDebugTitle.border = false;
			visualDebugTitle.borderColor = 0x000000;
			visualDebugTitle.height = dragBar.height;
			visualDebugTitle.text = "Visual Debug v2.0 - Darcey@AllForTheCode.co.uk";
			visualDebugTitle.mouseEnabled = false;
			visualDebugWindow.addChild(visualDebugTitle);
			
			textFormatBody = new TextFormat();
			textFormatBody.color = 0x000000;
			visualDebugBody = new TextField();
			visualDebugBody.x = 2;
			visualDebugBody.y = dragBar.height + 2;
			visualDebugBody.width = visualDebugWidth - 29;
			visualDebugBody.height = visualDebugHeight - (dragBar.height + 10);
			visualDebugBody.border = false;
			visualDebugBody.borderColor = 0x000000;
			visualDebugBody.multiline = true;
			visualDebugBody.wordWrap = false;
			visualDebugBody.mouseEnabled = true;
			visualDebugBody.selectable = true;
			visualDebugBody.text = debugText;
			
			visualDebugWindow.addChild(visualDebugBody);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function btnScrollStartDragHandler(e:*):void
		{
			var rect:Rectangle = new Rectangle(
				(visualDebugWidth-btnScroll.width),
				dragBar.height,
				0,
				(visualDebugHeight-(dragBar.height+btnScroll.height))
			);
			btnScroll.startDrag(false,rect);
			rect = null;
			
			_stage.addEventListener(MouseEvent.MOUSE_MOVE,btnScrollMouseMoveHandler);
		}
		private function btnScrollMouseMoveHandler(e:*):void {
			syncTextWithBtnScroll();
		}
		private function btnScrollStopDragHandler(e:*):void
		{
			try {
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE,btnScrollMouseMoveHandler);
			} catch (e:Error) {}
			
			btnScroll.stopDrag();
			syncTextWithBtnScroll();
		}
		private function syncTextWithBtnScroll(): void {
			range = (visualDebugHeight - btnClose.height)-50;
			step = visualDebugBody.maxScrollV/range;
			targetScrollV = (btnScroll.y-btnClose.height) * step;
			
			if (targetScrollV<0){
				targetScrollV = 0;
			}
			
			visualDebugBody.scrollV = targetScrollV;
			
			/*
			var s:String = "";
			s += "range:" + range + "  ";
			s += "step:" + step + "  ";
			s += "btnScroll.y:" + btnScroll.y + "  ";
			s += "maxScrollV:" + visualDebugBody.maxScrollV + "  ";
			s += "targetScrollV:" + targetScrollV + "  ";
			trace(s);
			*/
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function dragBarStartDragHandler(e:*):void
		{
			visualDebugWindow.startDrag();
		}
		private function dragBarStopDragHandler(e:*):void
		{
			visualDebugWindow.stopDrag();
			if (visualDebugWindow.y < 0){
				visualDebugWindow.y = 0;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function btnCloseMouseOverHandler(e:MouseEvent):void
		{
			btnClose.graphics.clear();
			btnClose.graphics.beginFill(0xFF0000,1);
			btnClose.graphics.drawRect(0,0,25,25);
			btnClose.graphics.endFill();
			
			btnClose.graphics.lineStyle(2,0xFFFFFF,1,true);
			btnClose.graphics.moveTo(5,5);
			btnClose.graphics.lineTo(20,20);
			btnClose.graphics.moveTo(20,5);
			btnClose.graphics.lineTo(5,20);
		}
		private function btnCloseMouseOutHandler(e:MouseEvent):void
		{
			btnClose.graphics.clear();
			btnClose.graphics.beginFill(0x990000,1);
			btnClose.graphics.drawRect(0,0,25,25);
			btnClose.graphics.endFill();
			
			btnClose.graphics.lineStyle(2,0x000000,1,true);
			btnClose.graphics.moveTo(5,5);
			btnClose.graphics.lineTo(20,20);
			btnClose.graphics.moveTo(20,5);
			btnClose.graphics.lineTo(5,20);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function btnCloseClickHandler(e:MouseEvent):void
		{
			this.hide();
			disposeOfVisualDebug();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -		
		
		
		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function disposeOfVisualDebug():void
		{
			//trace("disposeOfVisualDebug()");
			
			try {
				dragBar.removeEventListener(MouseEvent.MOUSE_DOWN,dragBarStartDragHandler);
			}catch (e:Error){}
			
			try {
				dragBar.removeEventListener(MouseEvent.MOUSE_UP,dragBarStopDragHandler);
			}catch (e:Error){}
			
			try {
				dragBar.removeEventListener(MouseEvent.RELEASE_OUTSIDE,dragBarStopDragHandler);
			}catch (e:Error){}
			
			try {
				dragBar.removeEventListener(Event.MOUSE_LEAVE,dragBarStopDragHandler);
			}catch (e:Error){}
			
			try {
				dragBar.removeEventListener(Event.REMOVED,dragBarStopDragHandler);
			}catch (e:Error){}
			
			// - - - - - - -
			
			try {
				btnClose.removeEventListener(MouseEvent.MOUSE_OVER,btnCloseMouseOverHandler);
			}catch (e:Error){}
			
			try {
				btnClose.removeEventListener(MouseEvent.MOUSE_OUT,btnCloseMouseOutHandler);
			}catch (e:Error){}
			
			try {
				btnClose.removeEventListener(MouseEvent.CLICK,btnCloseClickHandler);
			}catch (e:Error){}
			
			// - - - - - - -
			
			try {
				btnScroll.removeEventListener(MouseEvent.MOUSE_DOWN,btnScrollStartDragHandler);
			}catch (e:Error){}
			
			try {
				btnScroll.removeEventListener(MouseEvent.MOUSE_UP,btnScrollStopDragHandler);
			}catch (e:Error){}
			
			try {
				btnScroll.removeEventListener(MouseEvent.RELEASE_OUTSIDE,btnScrollStopDragHandler);
			}catch (e:Error){}
			
			try {
				btnScroll.removeEventListener(Event.MOUSE_LEAVE,btnScrollStopDragHandler);
			}catch (e:Error){}
			
			try {
				btnScroll.removeEventListener(Event.REMOVED,btnScrollStopDragHandler);
			}catch (e:Error){}
			
			// - - - - - - -
			
			try {
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE,btnScrollMouseMoveHandler);
			} catch (e:Error) {}
			
			// - - - - - - -
			
			if (visualDebugWindow){
				new RemoveAllChildrenIn(visualDebugWindow);
				visualDebugWindow.graphics.clear();
			}
			
			if (dragBar){
				new RemoveAllChildrenIn(dragBar);
				dragBar.graphics.clear();
			}
			
			if (btnClose){
				new RemoveAllChildrenIn(btnClose);
				btnClose.graphics.clear();
			}
			
			if (btnScroll){
				new RemoveAllChildrenIn(btnScroll);
				btnScroll.graphics.clear();
			}
			
			if (btnScrollBg){
				new RemoveAllChildrenIn(btnScrollBg);
				btnScrollBg.graphics.clear();
			}
			
			// - - - - - - -
			
			textFormatTitle = null;
			visualDebugTitle = null;
			textFormatBody = null;
			visualDebugBody = null;
			
			btnClose = null;
			dragBar = null;
			btnScroll = null;
			btnScrollBg = null;
			visualDebugWindow = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function clear():void
		{
			debugText = ""; debugText = null;
			update("");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			//trace("dispose()");
			try {
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);
			} catch(error:Error) {}
			
			try {
				_stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpHandler);
			} catch(error:Error) {}
			
			disposeOfVisualDebug();
			new RemoveAllChildrenIn(this);

			_stage = null;
			debugText = "";
			visualDebugWindow = null;
			dragBar = null;
			btnClose = null;
			btnScrollBg = null;
			btnScroll = null;
			textFormatTitle = null;
			visualDebugTitle = null;
			textFormatBody = null;
			visualDebugBody = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
}