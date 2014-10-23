package com.darcey.carousel25
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.DTools;
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Carousel25 extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var sinSpeed:Number;
		private var cosSpeed:Number;
		private var sinRadius:Number;
		private var cosRadius:Number;
		private var sinGap:Number;
		private var cosGap:Number;
		private var sinAxes:String = "x"; // x or y
		
		private var sin:Number = 0;
		private var cos:Number = 0;
		
		private var centerItem:Carousel25VO;
		private var centerItemIndex:uint = 0;
		
		private var zSorting:Boolean = true;
		private var addedToStage:Boolean = false;
		
		private var items:Array;
		private var centerItemAdded:Boolean = false;
		private var itemStep:Number = 0;
		private var radianGap:Number = 0;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Carousel25(sinSpeed:Number,cosSpeed:Number,sinRadius:Number,cosRadius:Number,sinGap:Number,cosGap:Number,sinAxis:String="x",zSorting:Boolean=true)
		{
			this.sinSpeed = sinSpeed;
			this.cosSpeed = cosSpeed;
			this.sinRadius = sinRadius;
			this.cosRadius = cosRadius;
			this.sinGap = sinGap;
			this.cosGap = cosGap;
			this.sinAxes = sinAxes;
			this.zSorting = zSorting;
			
			items = new Array();
			
			this.addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removedFromStageHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function addedToStageHandler(e:Event):void
		{
			addedToStage = true;
		}
		private function removedFromStageHandler(e:Event):void
		{
			addedToStage = false;
			try {
				stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		private var itemCount:Number = 0;
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function addMovieClip(mc:MovieClip):void
		{
			var item:Carousel25VO = new Carousel25VO();
			item.name = "item"+itemCount;
			item.attachMovieClip(mc);
			item.setIndex(itemCount);
			itemCount++;
			addChild(item);
			items.push( item );
		}
		public function addSprite(sp:Sprite):void
		{
			var item:Carousel25VO = new Carousel25VO();
			item.name = "item"+itemCount;
			item.attachSprite(sp);
			item.setIndex(itemCount);
			itemCount++;
			addChild(item);
			items.push( item );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function addCenterMovieClip(mc:MovieClip,x:Number=0,y:Number=0):void
		{
			if (centerItemAdded){ return; }
			centerItemAdded = true;
			
			centerItem = new Carousel25VO();
			centerItem.name = "center";
			centerItem.attachMovieClip(mc);
			centerItem.name = "center";
			centerItem.mc.x = x;
			centerItem.mc.y = y;
			addChild(centerItem);
			//items.push( centerItem );
			//centerItemIndex = itemCount;
		}
		public function addCenterSprite(sp:Sprite,x:Number=0,y:Number=0):void
		{
			if (centerItemAdded){ return; }
			centerItemAdded = true;
			
			centerItem = new Carousel25VO();
			centerItem.attachSprite(sp);
			centerItem.name = "center";
			centerItem.sp.x = x;
			centerItem.sp.y = y;
			addChild(centerItem);
			//items.push( centerItem );
			//centerItemIndex = itemCount;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function start():void
		{
			itemStep = 360 / (items.length);
			
			if (addedToStage){
				stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler,false,0,true);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function stop():void
		{
			try {
				stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			} catch (e:Error) {}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function enterFrameHandler(e:Event):void
		{
			if (items.length == 0){ return; } // Prevent start if no items to animate
			
			var item:Carousel25VO;
			var name:String;
			for (var i:int = 0; i < items.length; i++) 
			{
				item = items[i];
				
				if (item.name != "center")
				{
					radianGap = DTools.toRad( (itemStep*i) );
					
					sin = Math.sin((getTimer()/sinSpeed)+radianGap) * sinRadius;
					cos = Math.cos((getTimer()/cosSpeed)+radianGap) * cosRadius;
					
					// ENSURE NO Z IS THE SAME VALUE FOR SORTING PURPOSES
					cos += ((i+1) * 0.01);
					
					if (sinAxes == "x"){
						item.x = sin;
					} else {
						item.y = sin;
					}
					
					item.z = cos;
				}
				
			}
			
			//tracez("START");
			
			// ZSorting
			var temp:Array = new Array();
			var prevZ:Number = -9999999;
			var msg:String = "";
			
			// Add center item temporarily
			if (centerItemAdded){
				items[items.length] = centerItem;
			}
			
			//tracez("CENTER ADD");
			
			for (z = 0; z < items.length; z++){
				//temp[z] = items[getIndexOfItemWithZAbove( prevZ )];
				temp[z] = getItemWithZAbove(prevZ);
				temp[z].zIndexNew = z;
				//temp[z] = { index:items[z].index , zIndexOld:items[z].zIndex, zIndexNew:-1,  z:items[z].z, name:items[z].name };
				
				msg = "";
				if (temp[z]){
					prevZ = temp[z].z;
					temp[z].zIndex = z;
					msg += temp[z].name;
					msg += " index:" + temp[z].index + " ";
					msg += " zIndexOld:" + temp[z].zIndexOld.toFixed(2) + " ";
					msg += " zIndexNew:" + temp[z].zIndexNew.toFixed(2) + " ";
					msg += " z:" + temp[z].z.toFixed(2) + " ";
				}
			}
			
			// remove items center item
			if (centerItemAdded){
				items.splice(items.length-1);
				//tracez("CENTER REM");
			}
			
			//traceSorted(temp);
			
			var asset:Sprite;
			var zIndexTarget:uint = 0;
			
			for (z = 0; z < temp.length; z++)
			{
				if (temp[z].name != "center"){
					asset = Carousel25VO(items[temp[z].index]);
					zIndexTarget = (temp.length-1) - temp[z].zIndexNew;
					//trace(z + ". SETTING [" + Carousel25VO(items[temp[z].index]).name + "] to a zIndex of " + temp[z].zIndexNew);
					this.setChildIndex(asset,zIndexTarget);
				} else {
					zIndexTarget = (temp.length-1) - temp[z].zIndexNew;
					//trace(z + ". SETTING [center] to a zIndex of " + temp[z].zIndexNew);
					this.setChildIndex(centerItem,zIndexTarget);
				}
			}
			
			//tracez("AFTER");
			//trace("");
			
			asset = null;
			temp = null;
			
			//this.stop();
			
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function traceSorted(arr:Array):void
		{
			var msg:String = "SORTED ["+(arr.length-1)+"]: ";
			for (z = 0; z < arr.length; z++){
				msg += arr[z].name + ":" + arr[z].zIndexNew + " z:" + arr[z].z.toFixed(2) + "    ";
			}
			trace(msg);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function tracez(label:String):void
		{
			var msg:String = label + "["+(items.length-1)+"]: ";
			for (z = 0; z < items.length; z++){
				msg += items[z].name + ":" + this.getChildIndex( Carousel25VO(items[z]) )  + " z:" + items[z].z.toFixed(2) + "    ";
			}
			trace(msg);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function getItemWithZAbove(aboveValue:Number):Object
		{
			var lowestIndex:int = -1;
			var lowestZ:Number = 999999999;
			
			var found:Boolean = false;
			var item:Object = new Object();
			
			for (var i:int = 0; i < items.length; i++){
				if ( Carousel25VO(items[i]).z > aboveValue )
				{
					if (Carousel25VO(items[i]).z < lowestZ)
					{
						found = true;
						
						lowestZ = Carousel25VO(items[i]).z;
						lowestIndex = i;
						
						item.name = items[i].name;
						item.z = items[i].z;
						item.index = items[i].index;
						item.zIndexOld = this.getChildIndex( Carousel25VO(items[i]) );
						item.zIndexNew = z;
					}
				}
			}
			
			/*
			if (!found){
				trace("Looking for item with z above " + aboveValue.toFixed(2) + " NOT FOUND!");
			} else {
				trace("Looking for item with z above " + aboveValue.toFixed(2) + " FOUND at index: " + item.index + " with z:" + item.z.toFixed(2));
			}
			
			*/
			return item;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			new RemoveAllChildrenIn(this);
			
			for each (var item:Carousel25VO in items) 
			{
				item.dispose();
				item = null;
			}
			
			
			try {
				stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			} catch (e:Error) {}
			
			
			new RemoveAllChildrenIn(this);
			
			centerItem = null;
			items = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}
