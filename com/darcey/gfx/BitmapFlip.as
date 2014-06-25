package com.darcey.gfx
{
	// --------------------------------------------------------------------------------------
	// Author: Darcey.Lloyd@gmail.com
	// Type: Utility
	// --------------------------------------------------------------------------------------
	
	// --------------------------------------------------------------------------------------
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	// --------------------------------------------------------------------------------------
	
	
	
	// --------------------------------------------------------------------------------------
	public class BitmapFlip
	{
		// --------------------------------------------------------------------------------------
		private var bmpData:BitmapData;
		// --------------------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------------------
		public function BitmapFlip(
			bmp:Bitmap,
			flipAxis:String="H || V || B",
			transparent:Boolean = false,
			bgColor:Number = 0xFF0000
		)
		{
			//flip vertical & horizontal matrix
			var horizontalAndVerticalFlipMatrix:Matrix = new Matrix();
			horizontalAndVerticalFlipMatrix.scale(-1,-1);
			horizontalAndVerticalFlipMatrix.translate(bmp.width, bmp.height);
			
			//flip vertical matrix
			var verticalFlipMatrix:Matrix = new Matrix();
			verticalFlipMatrix.scale(1,-1);
			verticalFlipMatrix.translate(0,bmp.height);
			
			//flip horizontal matrix
			var horizontalFlipMatrix:Matrix = new Matrix();
			horizontalFlipMatrix.scale(-1,1);
			horizontalFlipMatrix.translate(bmp.width,0);
			
			// Perform the flip
			flipAxis = flipAxis.toLowerCase();
			switch (flipAxis)
			{
				case "b":
					bmpData = new BitmapData(bmp.width, bmp.height, transparent, bgColor);
					bmpData.draw(bmp, horizontalAndVerticalFlipMatrix);
					break;
				
				case "h":
					bmpData = new BitmapData(bmp.width, bmp.height, transparent, bgColor);
					bmpData.draw(bmp, horizontalFlipMatrix);
					break;
				
				case "v":
					bmpData = new BitmapData(bmp.width, bmp.height, transparent, bgColor);
					bmpData.draw(bmp, verticalFlipMatrix);
					break;
			}
			
			
			
		}
		// --------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------
		private function toRad(n:Number):Number
		{
			return (n * 0.0174532925);
		}
		// --------------------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------------------
		public function getBitmap():Bitmap
		{
			return new Bitmap(bmpData);
		}
		// --------------------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------------------
		public function getBitmapData():BitmapData
		{
			return bmpData;
		}
		// --------------------------------------------------------------------------------------
		
		
		
		
	}
	// --------------------------------------------------------------------------------------
}