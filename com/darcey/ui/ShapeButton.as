package com.darcey.ui

	// Author: Darcey.Lloyd@gmail.com

{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class ShapeButton extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		private var bgColorUp:Number = 0x660000;
		private var bgColorOver:Number = 0x330000;
		private var tf:TextFormat;
		private var txt:TextField;
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function ShapeButton(label:String="UNDEFIND",size:Number=12,bold:Boolean=false,embedFont:Boolean=false,font:String="Arial",textColor:Number=0xFFFFFF,bgColorUp:Number=0x660000,bgColorOver:Number=0x330000)
		{
			this.bgColorUp = bgColorUp;
			this.bgColorOver = bgColorOver;
			
			tf = new TextFormat();
			tf.color = textColor;
			tf.size = size;
			tf.bold = bold;
			tf.font = font;
			
			txt = new TextField();
			txt.text = label;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.embedFonts = embedFont;
			txt.defaultTextFormat = tf;
			txt.setTextFormat(tf);
			
			bmpData = new BitmapData(txt.width,txt.height,true,0x00000000);
			bmpData.draw(txt);
			bmp = new Bitmap(bmpData);
			
			this.graphics.beginFill(bgColorUp);
			this.graphics.drawRect(0,0,txt.width+20,txt.height+10);
			this.graphics.endFill();
			
			bmp.x = (this.width/2) - (bmp.width/2);
			bmp.y = (this.height/2) - (bmp.height/2);
			
			txt.x = (this.width/2) - (txt.width/2);
			txt.y = (this.height/2) - (txt.height/2);
			
			
			//addChild(bg);
			addChild(txt);
			//addChild(bmp);
			
			this.buttonMode = true;
			this.useHandCursor = true;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseOverHandler(e:MouseEvent):void
		{
			this.graphics.beginFill(bgColorOver);
			this.graphics.drawRect(0,0,txt.width+20,txt.height+10);
			this.graphics.endFill();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function mouseOutHandler(e:MouseEvent):void
		{
			this.graphics.beginFill(bgColorUp);
			this.graphics.drawRect(0,0,txt.width+20,txt.height+10);
			this.graphics.endFill();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}