package com.darcey.gfx
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.Ttrace;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;

	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class SetTint
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function SetTint()
		{
			/*
			Color.prototype.setTint = function (r, g, b, amount) {
			var trans = new Object();
			trans.ra = trans.ga = trans.ba = 100 - amount;
			var ratio = amount / 100;
			trans.rb = r * ratio;
			trans.gb = g * ratio;
			trans.bb = b * ratio;
			this.setTransform(trans);
			}
			
			myColor = new Color(mcColourBox);
			myColor.setTint(colour[0],colour[1],colour[2], 100);
			*/
			
			
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public static function on(target:DisplayObject,color:Number,amount:Number):void
		{
			applyTint(target, color, amount);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public static function onSprite(target:Sprite,color:Number,amount:Number):void
		{
			applyTint(target, color, amount);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public static function onMovieClip(target:MovieClip,color:Number,amount:Number):void
		{
			applyTint(target, color, amount);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		private static function applyTint(displayObject:DisplayObject, tintColor:Number, tintMultiplier:Number):void {
			//trace("applyTint("+displayObject+","+tintColor+","+tintMultiplier+")");
			var colTransform:ColorTransform = new ColorTransform();
			colTransform.redMultiplier = colTransform.greenMultiplier = colTransform.blueMultiplier = 1-tintMultiplier;
			colTransform.redOffset = Math.round(((tintColor & 0xFF0000) >> 16) * tintMultiplier);
			colTransform.greenOffset = Math.round(((tintColor & 0x00FF00) >> 8) * tintMultiplier);
			colTransform.blueOffset = Math.round(((tintColor & 0x0000FF)) * tintMultiplier);
			displayObject.transform.colorTransform = colTransform;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}