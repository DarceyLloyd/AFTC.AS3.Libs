package com.darcey.gfx
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class FlippedSprite extends Sprite
	{
		// --------------------------------------------------------------------------------------
		private var spriteBitmapData:BitmapData;
		private var spriteBitmap:Bitmap;
		
		private var inputSprite:Sprite;
		
		private var bmpData:BitmapData;
		private var bmp:Bitmap;
		// --------------------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------------------
		public function FlippedSprite(
			inputSprite:Sprite,
			flipAxis:String="H || V || B",
			transparent:Boolean = false,
			bgColor:Number = 0xFF0000
		)
		{
			// Var ini
			this.inputSprite = inputSprite;
			spriteBitmapData = new BitmapData(inputSprite.width,inputSprite.height,true,0xFFCC00);
			spriteBitmapData.draw(inputSprite);
			spriteBitmap = new Bitmap(spriteBitmapData);
			
			bmpData = spriteBitmapData;
			
			//flip vertical & horizontal matrix
			var horizontalAndVerticalFlipMatrix:Matrix = new Matrix();
			horizontalAndVerticalFlipMatrix.scale(-1,-1);
			horizontalAndVerticalFlipMatrix.translate(spriteBitmap.width, spriteBitmap.height);
			
			//flip vertical matrix
			var verticalFlipMatrix:Matrix = new Matrix();
			verticalFlipMatrix.scale(1,-1);
			verticalFlipMatrix.translate(0,spriteBitmap.height);
			
			//flip horizontal matrix
			var horizontalFlipMatrix:Matrix = new Matrix();
			horizontalFlipMatrix.scale(-1,1);
			horizontalFlipMatrix.translate(spriteBitmap.width,0);
			
			// Perform the flip
			flipAxis = flipAxis.toLowerCase();
			switch (flipAxis)
			{
				case "b":
					bmpData = new BitmapData(spriteBitmap.width, spriteBitmap.height, transparent, bgColor);
					bmpData.draw(spriteBitmap, horizontalAndVerticalFlipMatrix);
					break;
				
				case "h":
					bmpData = new BitmapData(spriteBitmap.width, spriteBitmap.height, transparent, bgColor);
					bmpData.draw(spriteBitmap, horizontalFlipMatrix);
					break;
				
				case "v":
					bmpData = new BitmapData(spriteBitmap.width, spriteBitmap.height, transparent, bgColor);
					bmpData.draw(spriteBitmap, verticalFlipMatrix);
					break;
			}
			
			
			bmp = new Bitmap(bmpData);
			addChild(bmp);
			
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
			return bmp;
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