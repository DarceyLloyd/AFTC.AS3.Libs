package com.darcey.text
{
	// ---------------------------------------------------------------------------------------------------------------------------
	import com.darcey.utils.DTools;
	
	import flashx.textLayout.formats.VerticalAlign;

	// ---------------------------------------------------------------------------------------------------------------------------

	// ---------------------------------------------------------------------------------------------------------------------------
	public class CustomTLFTextFieldVO
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		public var font:String = "Trebuchet MS";
		public var embedFonts:Boolean = true;
		public var label:String = "UNDEFINED";
		public var size:Number = 12;
		public var color:Number = 0x000000;
		public var autoSize:String = "left"; // none || left || right || center
		public var align:String = "left"; // left || right || center
		public var border:Boolean = false;
		public var borderColor:Number = 0x000000;
		public var leading:Number = 0;
		public var bold:Boolean = false;
		public var multiLine:Boolean = false;
		public var wordWrap:Boolean = false;
		public var selectable:Boolean = false;
		
		public var paddingLeft:Number = 0;
		public var paddingRight:Number = 0;
		public var paddingTop:Number = 0;
		public var paddingBottom:Number = 0;
		
		
		public var width:Number = -1;
		public var height:Number = -1;
		public var html:Number = 1;
		public var verticalAlign:String = VerticalAlign.TOP;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function CustomTLFTextFieldVO(xmlData:XML=null):void
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
			if (getValue(String(xmlData.@verticalAlign))){ this.verticalAlign = xmlData.@verticalAlign; }
			
			// Numbers
			if (getValue(parseInt(xmlData.@color))){ this.color = parseInt(xmlData.@color); }
			if (getValue(parseInt(xmlData.@leading))){ this.leading = parseInt(xmlData.@leading); }
			if (getValue(parseInt(xmlData.@size))){ this.size = parseInt(xmlData.@size); }
			if (getValue(parseInt(xmlData.@width))){ this.width = parseInt(xmlData.@width); }
			if (getValue(parseInt(xmlData.@height))){ this.height = parseInt(xmlData.@height); }
			if (getValue(parseInt(xmlData.@borderColor))){ this.borderColor = parseInt(xmlData.@borderColor); }
			
			if (getValue(parseInt(xmlData.@paddingLeft))){ this.paddingLeft = parseInt(xmlData.@paddingLeft); }
			if (getValue(parseInt(xmlData.@paddingRight))){ this.paddingRight = parseInt(xmlData.@paddingRight); }
			if (getValue(parseInt(xmlData.@paddingTop))){ this.paddingTop = parseInt(xmlData.@paddingTop); }
			if (getValue(parseInt(xmlData.@paddingBottom))){ this.paddingBottom = parseInt(xmlData.@paddingBottom); }
			
			
			
			// Booleans
			if (getValue(parseInt(xmlData.@border))){ this.border = DTools.getBooleanFromNumber(parseInt(xmlData.@border)) }
			if (getValue(parseInt(xmlData.@bold))){ this.bold = DTools.getBooleanFromNumber(parseInt(xmlData.@bold)) }
			if (getValue(parseInt(xmlData.@multiLine))){ this.multiLine = DTools.getBooleanFromNumber(parseInt(xmlData.@multiLine)) }
			if (getValue(parseInt(xmlData.@wordWrap))){ this.wordWrap = DTools.getBooleanFromNumber(parseInt(xmlData.@wordWrap)) }
			if (getValue(parseInt(xmlData.@selectable))){ this.selectable = DTools.getBooleanFromNumber(parseInt(xmlData.@selectable)) }
			
			
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