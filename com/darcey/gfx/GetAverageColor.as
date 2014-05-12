package com.darcey.gfx
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.Ttrace;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class GetAverageColor
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		
		private static var bmp:Bitmap;
		private static var bmpData:BitmapData;
		private static var matrix:Matrix;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function GetAverageColor()
		{
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public static function fromDisplayObject(displayObject:DisplayObject,area:Rectangle):Number
		{
			var areaBitmap:GetBitmapOfArea = new GetBitmapOfArea(displayObject,area);
			
			return getAverageColor(areaBitmap.getBitmapData());
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public static function getAverageColor( source:BitmapData ):uint
		{
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					
					count++
				}
			}
			
			red /= count;
			green /= count;
			blue /= count;
			
			return red << 16 | green << 8 | blue;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}