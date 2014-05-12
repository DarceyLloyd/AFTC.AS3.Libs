package com.darcey.text
{
	// ---------------------------------------------------------------------------------------------------------------------------
	import com.darcey.utils.DTools;
	
	import flash.display.Sprite;

	// ---------------------------------------------------------------------------------------------------------------------------
	
	// ---------------------------------------------------------------------------------------------------------------------------
	public class CustomTextFieldVO
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		public var font:String = "Arial";
		public var embedFonts:Boolean = true;
		public var label:String = "UNDEFINED";
		public var size:Number = 12;
		public var color:Number = 0x000000;
		public var autoSize:String = "left"; // none || left || right || center
		public var align:String = "left"; // left || right || center || justify
		public var border:Boolean = false;
		public var borderColor:Number = 0x000000;
		public var leading:Number = 0;
		public var bold:Boolean = false;
		public var multiLine:Boolean = false;
		public var wordWrap:Boolean = false;
		public var selectable:Boolean = false;
		public var underline:Boolean = false;
		
		public var overlayHitShape:Boolean = false;
		
		public var background:Boolean = false;
		public var backgroundColor:Number = 0xFFFFFF;
		
		public var letterSpacing:Number = 0;
		
		
		public var width:Number = -1;
		public var height:Number = -1;
		public var html:Boolean = false;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function CustomTextFieldVO(xmlData:XML=null):void
		{
			if (xmlData == null){ return; }
			
			parseXMLDataIntoVariables(xmlData);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function update(xmlData:XML):void
		{
			if (xmlData == null){ return; }
			
			parseXMLDataIntoVariables(xmlData);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		private function parseXMLDataIntoVariables(xmlData:XML):void
		{
			// Strings
			if (getValue(String(xmlData.@font))){ this.font = xmlData.@font; }
			if (getValue(String(xmlData.@autoSize))){ this.autoSize = xmlData.@autoSize; }
			if (getValue(String(xmlData.@align))){ this.align = xmlData.@align; }
			//if (getValue(String(xmlData.@verticalAlign))){ this.verticalAlign = xmlData.@verticalAlign; }
			
			// Numbers
			if (getValue(parseInt(xmlData.@color))){ this.color = parseInt(xmlData.@color); }
			if (getValue(parseInt(xmlData.@leading))){ this.leading = parseInt(xmlData.@leading); }
			if (getValue(parseInt(xmlData.@size))){ this.size = parseInt(xmlData.@size); }
			if (getValue(parseInt(xmlData.@width))){ this.width = parseInt(xmlData.@width); }
			if (getValue(parseInt(xmlData.@height))){ this.height = parseInt(xmlData.@height); }
			if (getValue(parseInt(xmlData.@borderColor))){ this.borderColor = parseInt(xmlData.@borderColor); }
			if (getValue(parseInt(xmlData.@backgroundColor))){ this.borderColor = parseInt(xmlData.@backgroundColor); }
			
			
			
			// Booleans
			if (getValue(parseInt(xmlData.@embedFonts))){ this.embedFonts = DTools.getBooleanFromNumber(parseInt(xmlData.@embedFonts)) }
			if (getValue(parseInt(xmlData.@bold))){ this.bold = DTools.getBooleanFromNumber(parseInt(xmlData.@bold)) }
			if (getValue(parseInt(xmlData.@multiLine))){ this.multiLine = DTools.getBooleanFromNumber(parseInt(xmlData.@multiLine)) }
			if (getValue(parseInt(xmlData.@wordWrap))){ this.wordWrap = DTools.getBooleanFromNumber(parseInt(xmlData.@wordWrap)) }
			if (getValue(parseInt(xmlData.@selectable))){ this.selectable = DTools.getBooleanFromNumber(parseInt(xmlData.@selectable)) }
			if (getValue(parseInt(xmlData.@border))){ this.border = DTools.getBooleanFromNumber(parseInt(xmlData.@border)) }
			if (getValue(parseInt(xmlData.@background))){ this.selectable = DTools.getBooleanFromNumber(parseInt(xmlData.@background)) }
			if (getValue(parseInt(xmlData.@underline))){ this.underline = DTools.getBooleanFromNumber(parseInt(xmlData.@underline)) }
			if (getValue(parseInt(xmlData.@html))){ this.html = DTools.getBooleanFromNumber(parseInt(xmlData.@html)) }
			if (getValue(parseInt(xmlData.@html))){ this.overlayHitShape = DTools.getBooleanFromNumber(parseInt(xmlData.@overlayHitShape)) }
			
			
			// Node label
			label = xmlData.toString();
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		private function getValue(v:*):Boolean
		{
			var get:Boolean = true;
			//trace("v = " + v + " - typeof = " + typeof(v));
			if (!v){ get = false; }			
			return get;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
	}
	// ---------------------------------------------------------------------------------------------------------------------------
}