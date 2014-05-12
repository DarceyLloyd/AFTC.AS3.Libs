package com.darcey.gfx
{
	// --------------------------------------------------------------------------------------------
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	// --------------------------------------------------------------------------------------------
	
	
	// --------------------------------------------------------------------------------------------
	public class DrawShape
	{
		
		// --------------------------------------------------------------------------------------------
		public function DrawShape()
		{
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawSquareBox(width:Number=100,height:Number=100,colour:Number=0x003366,bClearShapeBeforeDraw:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearShapeBeforeDraw) { myShape.graphics.clear(); }
			myShape.graphics.beginFill(colour);
			//myShape.graphics.lineStyle(1, 0x000000,1,true,'normal',null,'JointStyle.BEVEL',10);
			myShape.graphics.drawRect(0,0,width,height);
			myShape.graphics.endFill();		
			
			return myShape;
		}// --------------------------------------------------------------------------------------------
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawSquareOutlinedBox(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				lineThickness:Number = 1,
				shape:Shape = null
		):Shape
		{
			var myShape:Shape;
			
			if (shape == null){
				myShape = new Shape();
			} else {
				myShape = shape;
			}
			
			myShape.graphics.clear();
			
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			myShape.graphics.drawRect(0,0,width,height);
			myShape.graphics.endFill();		
			
			return myShape;
		}// --------------------------------------------------------------------------------------------
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBox(width:Number=100,height:Number=100,colour:Number=0x003366,cornerRadius:Number = 60,bClearShapeBeforeDraw:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearShapeBeforeDraw) { myShape.graphics.clear(); }
			myShape.graphics.beginFill(colour);
			//myShape.graphics.lineStyle(1, 0x000000,1,true,'normal',null,'JointStyle.BEVEL',10);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();		
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBoxWithOutline(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				cornerRadius:Number = 60,
				lineThickness:Number = 1
			):Shape
		{
			var myShape:Shape = new Shape();
			
			myShape.graphics.clear();
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();		
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
				
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledBoxWithOutlineUsingRoundedRectangles(
				width:Number = 100,
				height:Number = 100,
				fillColor:Number = 0x444444,
				lineColor:Number = 0xCCCCCC,
				cornerRadius:Number = 60,
				lineThickness:Number = 1
			):Shape
		{
			var myShape:Shape = new Shape();
			
			// Outline box
			myShape.graphics.clear();
			myShape.graphics.beginFill(lineColor);
			myShape.graphics.drawRoundRect(0, 0, width, height, cornerRadius,cornerRadius);
			myShape.graphics.endFill();
			
			// Innter fill box	
			myShape.graphics.beginFill(fillColor);
			myShape.graphics.drawRoundRect(0+lineThickness, 0+lineThickness, width-(lineThickness*2), height-(lineThickness*2), cornerRadius,cornerRadius);
			myShape.graphics.endFill();	
				
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		

		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawLine(startX:Number=100,startY:Number=100,endX:Number=200,endY:Number = 200,color:Number=0xFFFFFF,thickness:Number = 1,bClearOnCall:Boolean = true):Shape
		{
			var myShape:Shape = new Shape();
			
			if (bClearOnCall)
			{
				myShape.graphics.clear();
			}
			myShape.graphics.moveTo(startX, startY);
			myShape.graphics.lineStyle(thickness, color);
			myShape.graphics.lineTo(endX, endY);
			
			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawOutlineBoxWithCornerGaps(nWidth:Number=100,nHeight:Number=100,color:Number=0xFFFFFF,nCornerGapSize:Number = 1):Shape
		{
			var myShape:Shape = new Shape();
			
			var thickness:Number = 1;
			
			// TOP LEFT > BOTTOM LEFT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(0,nCornerGapSize,thickness,nHeight-(nCornerGapSize*2));
			myShape.graphics.endFill();
			
			// TOP LEFT > TOP RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nCornerGapSize,0,nWidth-(nCornerGapSize),thickness);
			myShape.graphics.endFill();
			
			// TOP RIGHT > BOTTOM RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nWidth,nCornerGapSize,thickness,nHeight-(nCornerGapSize*2));
			myShape.graphics.endFill();
			
			// BOTTOM LEFT > BOTTOM RIGHT
			myShape.graphics.beginFill(color);
			myShape.graphics.drawRect(nCornerGapSize,nHeight-thickness,nWidth-(nCornerGapSize),thickness);
			myShape.graphics.endFill();

			return myShape;
		}
		// --------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawGradientBox(
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0
		):Shape
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			var cornerRadius:Number = 0;
			
			
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			var shapeGradient:Shape = new Shape();
			shapeGradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod); 
			shapeGradient.graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			shapeGradient.graphics.endFill();	
			
			return shapeGradient;
		}// --------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawGradientBoxWithOutline(
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0,
			lineThickness:Number=1,
			lineColor:Number=0x550000
		):Shape
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			var cornerRadius:Number = 0;
			
			
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			var shapeGradient:Shape = new Shape();
			shapeGradient.graphics.lineStyle(lineThickness,lineColor,1,true);
			shapeGradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod); 
			shapeGradient.graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			shapeGradient.graphics.endFill();	
			
			return shapeGradient;
		}// --------------------------------------------------------------------------------------------

		
		
		// --------------------------------------------------------------------------------------------
		public static function DrawBeveledGradientBoxWithOutline(
			nColor1:Number = 0xFF0000,
			nColor1Alpha:Number = 1,
			nColor2:Number = 0xFFFFFF,
			nColor2Alpha:Number = 0.5,
			nWidth:Number=100,
			nHeight:Number=100,
			nAngle:Number=0,
			nRatio1:Number=0,
			nRatio2:Number=0,
			lineColor:Number = 0xCCCCCC,
			cornerRadius:Number = 60,
			lineThickness:Number = 1
		):Shape
		{			
			var a:Number = 30;
			var b:Number = 255;
			var c:Number = 255;
			var d:Number = 0;
			var e:Number = 0;
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [nColor1, nColor2];
			var alphas:Array = [nColor1Alpha, nColor2Alpha]; // transparancies
			var ratios:Array = [a, b];
			var spreadMethod:String = SpreadMethod.PAD;
			
			var matr:Matrix = new Matrix();
			matr.createGradientBox(nWidth, nHeight, (nAngle * Math.PI/180), 0, 0);
			
			var shapeGradient:Shape = new Shape();
			shapeGradient.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);
			shapeGradient.graphics.lineStyle(lineThickness, lineColor,1,true,'normal',null,'JointStyle.BEVEL',3);
			shapeGradient.graphics.drawRoundRect(0, 0, nWidth,nHeight, cornerRadius,cornerRadius);
			shapeGradient.graphics.endFill();	
			
			return shapeGradient;
		}// --------------------------------------------------------------------------------------------



	}
}