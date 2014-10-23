package com.darcey.carousel25
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Carousel25VO extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public var index:uint = 0;
		//public var zIndex:Number = 0;
		private var type:String = ""; // sprite or movieclip LC
		public var mc:MovieClip;
		public var sp:Sprite;
		
		public var zIndexOld:Number = 0;
		public var zIndexNew:Number = 0;
		
		private var debug:Boolean = false;
		private var txt:TextField;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function setIndex(arg:uint):void
		{
			index = arg;
			this.name = "item"+arg;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function attachSprite(sp:Sprite,debug:Boolean=false):void
		{
			type = "sprite";
			this.sp = sp;
			addChild(sp);
			
			this.debug = debug;
			if (debug){
				addText();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function attachMovieClip(mc:MovieClip,debug:Boolean=false):void
		{
			type = "movieclip";
			this.mc = mc;
			addChild(mc);
			
			this.debug = debug;
			if (debug){
				addText();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function addText():void
		{
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.height = 25;
			txt.background = true;
			txt.text = this.name;
			txt.x -= 50;
			txt.scaleX = txt.scaleY = 3;
			addChild(txt);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function getAsset():*
		{
			if (type == "sprite"){
				return this.sp;
			} else {
				return this.mc;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			new RemoveAllChildrenIn(this);
			mc = null;
			sp = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}
