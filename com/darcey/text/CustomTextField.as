package com.darcey.text
{
	// -------------------------------------------------------------------------------------------		
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	// -------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------
	public class CustomTextField extends TextField
	{
		// -------------------------------------------------------------------------------------------
		private var cVO:CustomTextFieldVO;
		public var tf:TextFormat;
		// -------------------------------------------------------------------------------------------
		
		
		// -------------------------------------------------------------------------------------------
		//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html
		//http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html
		// -------------------------------------------------------------------------------------------
		public function CustomTextField(customTextFieldVO:CustomTextFieldVO)
		{
			tf = new TextFormat();
			this.cVO = customTextFieldVO;
			applySettings();
		}
		// -------------------------------------------------------------------------------------------
		
		
		// -------------------------------------------------------------------------------------------
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
			
			this.embedFonts = cVO.embedFonts;
			
			this.multiline = cVO.multiLine;
			this.wordWrap = cVO.wordWrap;
			
			this.selectable = cVO.selectable;
			if (this.selectable){
				this.mouseEnabled = true;
			} else {
				this.mouseEnabled = false;
			}
			
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.autoSize = cVO.autoSize;
						
			
			
			if (cVO.width > -1){
				this.width = cVO.width;
			}
			
			if (cVO.height > -1){
				this.height = cVO.height;
			}
			
			
			if (cVO.html){
				this.htmlText = cVO.label;
			} else {
				this.text = cVO.label;
			}
			this.defaultTextFormat = tf;
			this.setTextFormat(tf);
			
			//trace("cVOLabel = " + cVO.label + "   cVO.border = " + cVO.border + "   cVO.borderColor = " + cVO.borderColor);
			
			this.border = cVO.border;
			this.borderColor = cVO.borderColor;
			this.background = cVO.background;
			this.backgroundColor = cVO.backgroundColor;
		}
		// -------------------------------------------------------------------------------------------
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function set label(arg:String):void
		{
			cVO.label = arg;
			
			if (cVO.html){
				this.htmlText = cVO.label;
			} else {
				this.text = cVO.label;
			}
			this.defaultTextFormat = tf;
			this.setTextFormat(tf);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function get label():String
		{
			if (cVO.html){
				return this.htmlText;
			} else {
				return this.text;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// -------------------------------------------------------------------------------------------
		public function updateFromVO(customTextFieldVO:CustomTextFieldVO):void
		{
			this.cVO = customTextFieldVO;
			applySettings();
		}
		// -------------------------------------------------------------------------------------------
		
		
		// -------------------------------------------------------------------------------------------
		public function setFormat():void { applyFormat(); }
		public function reApplyFormat():void { applyFormat(); }
		public function applyFormat():void
		{
			this.defaultTextFormat = tf;
			this.setTextFormat(tf);
		}
		// -------------------------------------------------------------------------------------------
		
		
		
		// -------------------------------------------------------------------------------------------
		private function updateFromLocalyChangedVO():void
		{
			applySettings();
			this.defaultTextFormat = tf;
			this.setTextFormat(tf);
		}
		// -------------------------------------------------------------------------------------------
		
		
		
		// -------------------------------------------------------------------------------------------
		public function set fontSize(n:Number):void
		{
			cVO.size = n;
			tf.size = cVO.size;
			updateFromLocalyChangedVO();
		}
		public function get fontSize():Number
		{
			return Number(tf.size);
		}
		// -------------------------------------------------------------------------------------------
		
		
		// -------------------------------------------------------------------------------------------
		public function set leading(n:int):void
		{
			cVO.leading = n;
			tf.leading = cVO.leading;
			updateFromLocalyChangedVO();
		}
		public function get lineHeight():int
		{
			return int(tf.leading);
		}
		// -------------------------------------------------------------------------------------------
		
		
		
		
		
		
		
		
		// -------------------------------------------------------------------------------------------
		public function dispose():void
		{
			tf = null;
			this.cVO = null;
		}
		// -------------------------------------------------------------------------------------------
	}
}