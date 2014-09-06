// AUTHOR: Darcey.Lloyd@gmail.com

package com.darcey.gfx
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.DTools;
	import com.darcey.utils.RemoveAllChildrenIn;
	import com.greensock.BlitMask;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Scroller extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var displayObject:DisplayObject;
		private var bmpData:BitmapData;
		private var bmp1:Bitmap;
		private var bmp2:Bitmap;
		private var scrollArea:Rectangle;
		private var blitMask:BlitMask;
		private var newNumber:Number;
		private var container:Sprite;
		private var mask:Sprite;
		
		private var scrollSpeedX:Number = 1;
		private var scrollSpeedY:Number = 1;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Scroller()
		{
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function createScrollerFromDisplayObject(displayObject:DisplayObject,scrollSpeedX:Number=1,useMask:Boolean=true):void
		{
			this.displayObject = displayObject;
			
			container = new Sprite();
			addChild(container);
			
			bmpData = new BitmapData(displayObject.width,displayObject.height,false);
			bmpData.draw(displayObject);
			bmp1 = new Bitmap(bmpData);
			bmp2 = new Bitmap(bmpData);
			bmp1.x = 0;
			bmp2.x = bmp1.width;
			container.addChild(bmp1);
			container.addChild(bmp2);
			
			if (useMask){
				mask = new Sprite();
				mask.graphics.beginFill(0xCC0000);
				mask.graphics.drawRect(0,0,bmp1.width,bmp1.height);
				mask.graphics.endFill();
				container.addChild(mask);
				container.mask = mask;
			}
			
			this.addEventListener(Event.ENTER_FRAME, scrollDisplayObject); 
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function scrollDisplayObject(e:Event):void{
			bmp1.x -= scrollSpeedX;  
			bmp2.x -= scrollSpeedX;  
			
			//if(bmp1.x < -bmp1.width){
			if(bmp1.x - scrollSpeedX < -bmp1.width){
				bmp1.x = bmp1.width;
			}else if(bmp2.x - scrollSpeedX < -bmp2.width){
				bmp2.x = bmp2.width;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function createBlitScrollerFromDisplayObject(displayObject:DisplayObject,size:Rectangle,scrollSpeedX:Number=1,scrollSpeedY:Number=0):void
		{
			this.displayObject = displayObject;
			this.scrollSpeedX = scrollSpeedX;
			this.scrollSpeedY = scrollSpeedY;
			
			container = new Sprite();
			addChild(container);
			
			bmpData = new BitmapData(displayObject.width,displayObject.height,false);
			bmpData.draw(displayObject);
			bmp1 = new Bitmap(bmpData);
			container.addChild(bmp1);
			
			blitMask = new BlitMask( bmp1, size.x, size.y, size.width, size.height, true, true, 0x000000, true);
			
			//generate a random offset value divisible by 100
			newNumber = (DTools.randomNumber(0, 9) * 100) + 1200;
			
			stage.addEventListener(Event.ENTER_FRAME, blitScroll);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function blitScroll(e:Event):void
		{
			if (scrollSpeedX>0){
				bmp1.x += scrollSpeedX;
			}
			
			if (scrollSpeedY>0){
				bmp1.y += scrollSpeedY;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			container.graphics.clear();
			mask.graphics.clear();
			
			new RemoveAllChildrenIn(this);
			new RemoveAllChildrenIn(container);
			
			bmpData.dispose();
			bmp1 = null;
			bmp2 = null;
			displayObject = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}