package com.darcey.gfx
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class CreateGradientImageReflection extends Bitmap
	{
		// --------------------------------------------------------------------------------------
		public function CreateGradientImageReflection(bmp:Bitmap)
		{
			var rotatedBitmap:Bitmap = applyBitmapFlip(bmp);
			//addChild(rotatedBitmap);
			
			var gradientedBitmap:Bitmap = applyBitmapTransparentGradient(rotatedBitmap);
			//addChild(gradientedBitmap);
			
			var mergedBitmaps:Bitmap = mergeBitmaps(bmp,gradientedBitmap);
			//addChild(mergedBitmaps);
			
			//return mergedBitmaps.bitmapData;
			this.bitmapData = mergedBitmaps.bitmapData;
		}
		// --------------------------------------------------------------------------------------
		
		
		
		
		
		// --------------------------------------------------------------------------------------
		private function mergeBitmaps(bmp:Bitmap,gradientedBitmap:Bitmap):Bitmap
		{
			// Merge original with flipped
			var moveImageDownMatrix:Matrix = new Matrix();
			moveImageDownMatrix.translate(0,bmp.height);
			
			var w:Number = bmp.width;
			var h:Number = bmp.height + (bmp.height/2);
			
			var mergedBitmapData:BitmapData = new BitmapData(w,h,true,0x000000);
			mergedBitmapData.draw(bmp);
			mergedBitmapData.draw(gradientedBitmap,moveImageDownMatrix);
			var combinedBitmap:Bitmap = new Bitmap(mergedBitmapData);
			
			return combinedBitmap;
		}
		// --------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------
		private function applyBitmapTransparentGradient(bmp:Bitmap):Bitmap
		{
			// Apply gradient
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( bmp.width, bmp.height/2, Math.PI / 2 );
			
			var linear:String = GradientType.LINEAR;
			var colors:Array = [0xFFFFFF, 0xFFFFFF];
			var alphas:Array = [0.5, 0.0];
			var ratios:Array = [0.0, 255];
			var spread:String = SpreadMethod.PAD;
			
			var gradient:Shape = new Shape();
			gradient.graphics.beginGradientFill( linear, colors, alphas, ratios, matrix, spread );
			gradient.graphics.drawRect(0, 0, bmp.width, bmp.height/2);
			gradient.graphics.endFill();
			
			var gradientBitmap:BitmapData = new BitmapData( gradient.width, gradient.height, true, 0 );
			gradientBitmap.draw( gradient );
			
			var result:BitmapData = new BitmapData( bmp.width, bmp.height, true, 0 );
			result.copyPixels( bmp.bitmapData, result.rect, new Point(), gradientBitmap, new Point(), true );
			
			return new Bitmap(result);
		}
		// --------------------------------------------------------------------------------------
		
		
		// --------------------------------------------------------------------------------------
		private function applyBitmapFlip(bmp:Bitmap):Bitmap
		{			
			// Flipped image
			var verticalFlipMatrix:Matrix = new Matrix();
			verticalFlipMatrix.scale(1,-1);
			verticalFlipMatrix.translate(0,bmp.height);
			
			var rotatedBitmapData:BitmapData = new BitmapData(bmp.width, bmp.height,true, 0x000000);
			rotatedBitmapData.draw(bmp, verticalFlipMatrix);
			var rotatedBitmap:Bitmap = new Bitmap(rotatedBitmapData);
			
			return rotatedBitmap;
		}
		// --------------------------------------------------------------------------------------
		
		
		
		
		
		// --------------------------------------------------------------------------------------
		private function toRad(n:Number):Number
		{
			return (n * 0.0174532925);
		}
		// --------------------------------------------------------------------------------------
		
				
		
	}
}