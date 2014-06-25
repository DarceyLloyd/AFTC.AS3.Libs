package com.darcey.text
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -		
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class CustomBitmapTextField extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var cVO:CustomTextFieldVO;
		public var txt:TextField;
		public var tf:TextFormat;
		public var bmp:Bitmap;
		public var bmpData:BitmapData;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html
		//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function CustomBitmapTextField(vo:CustomTextFieldVO)
		{
			tf = new TextFormat();
			cVO = vo;
			txt = new TextField();
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function applySettings():void
		{
			tf.font = cVO.font;
			tf.size = cVO.size;
			tf.color = cVO.color;
			tf.align = cVO.align;
			tf.bold = cVO.bold;
			tf.leading = cVO.leading;
			tf.letterSpacing = cVO.letterSpacing;
			tf.underline = cVO.underline;
			
			txt.embedFonts = cVO.embedFonts;
			
			txt.multiline = cVO.multiLine;
			txt.wordWrap = cVO.wordWrap;
			
			txt.selectable = cVO.selectable;
			if (txt.selectable){
				txt.mouseEnabled = true;
			} else {
				txt.mouseEnabled = false;
			}
			
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.autoSize = cVO.autoSize;
			
			if (cVO.width > -1){
				this.width = cVO.width;
			}
			
			if (cVO.height > -1){
				this.height = cVO.height;
			}
			
			
			if (cVO.html){
				txt.htmlText = cVO.label;
			} else {
				txt.text = cVO.label;
			}
			
			//trace("cVOLabel = " + cVO.label + "   cVO.border = " + cVO.border + "   cVO.borderColor = " + cVO.borderColor);
			
			txt.border = cVO.border;
			txt.borderColor = cVO.borderColor;
			txt.background = cVO.background;
			txt.backgroundColor = cVO.backgroundColor;
			
			txt.defaultTextFormat = tf;
			txt.setTextFormat(tf);
			
			//addChild(txt);
			generateBitmap();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function generateBitmap(smoothDraw:Boolean=false,smoothBitmap:Boolean=false):Bitmap
		{
			new RemoveAllChildrenIn(this);
			this.graphics.clear();
			
			bmpData = new BitmapData(txt.width,txt.height,true,0x00000000);
			bmpData.draw(txt,null,null,null,null,smoothDraw);
			bmp = new Bitmap(bmpData,"auto",smoothBitmap);
			
			addChild(txt);
			
			return bmp;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function updateFromVO(vo:CustomTextFieldVO):void
		{
			this.cVO = vo;
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function update():void
		{
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set label(label:String):void
		{
			cVO.label = label;
			applySettings();
		}
		public function get label():String
		{
			return cVO.label;
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set text(label:String):void
		{
			cVO.label = label;
			applySettings();
		}
		public function get text():String
		{
			return cVO.label;
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set htmlText(label:String):void
		{
			cVO.label = label;
			applySettings();
		}
		public function get lineHeight():String
		{
			return cVO.label;
			applySettings();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			tf = null;
			this.cVO = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
}