package com.darcey.utils
{
	// Author: Darcey.Lloyd@gmail.com
	// Commented out Away3D functions for this project
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	//import away3d.core.base.SubGeometry;
	//import away3d.entities.Mesh;
	
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class DTools
	{
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function toggleFullScreen(s:Stage):void
		{
			try {
			if (s.displayState == StageDisplayState.NORMAL) {
				s.displayState=StageDisplayState.FULL_SCREEN;
			} else {
				s.displayState=StageDisplayState.NORMAL;
			}
			} catch (e:Error) {
				trace("FULL SCREEN MODE NOT AVAILABLE!");
			}
		}
		
		public static function goFullScreen(s:Stage):void
		{
			try {
				if (s.displayState == StageDisplayState.NORMAL) {
					s.displayState=StageDisplayState.FULL_SCREEN;
				}
			} catch (e:Error) {
				trace("FULL SCREEN MODE NOT AVAILABLE!");
			}
		}
		
		public static function goFullScreenInteractive(s:Stage):void
		{
			try {
				if (s.displayState == StageDisplayState.NORMAL) {
					s.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE;
				}
			} catch (e:Error) {
				trace("FULL SCREEN INTERACTIVE MODE NOT AVAILABLE!");
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getURL(url:String,newWindow:Boolean):void
		{
			if (newWindow){
				navigateToURL(new URLRequest(url), "_blank");
			} else {
				navigateToURL(new URLRequest(url));
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function outlineStage(stage:Stage):void
		{
			var outlineContainer:Sprite = new Sprite();
			outlineContainer.name = "stage outline";
			
			outlineContainer.graphics.lineStyle(1,0xFFFFFF);
			outlineContainer.graphics.moveTo(0,0);
			outlineContainer.graphics.lineTo(stage.stageWidth-1,0);
			outlineContainer.graphics.lineTo(stage.stageWidth-1,stage.stageHeight-1);
			outlineContainer.graphics.lineTo(0,stage.stageHeight-1);
			outlineContainer.graphics.lineTo(0,0);
			stage.addChild(outlineContainer);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function traceChildrenIn(target:*):void
		{
			trace("\n");
			trace("DTools.traceChildrenIn(target:"+target+"): target.numChildren = " + target.numChildren);
			
			
			try {
				for (var i:Number = 0; i <= target.numChildren-1; i++)
				{
					try {
						trace("#### DTOOLS: traceChildrenIn(): index ["+i+"] getChildAt["+i+"] =  [" + target.getChildAt(i) + "] name: [" + target.getChildAt(i).name + "]");
					} catch (e:Error) {
						trace("#### DTOOLS: ERROR: traceChildrenIn(): at index ["+i+"]");
						target.visible = true;
					}
				}
				
			} catch (e:Error) {
				trace("#### DTOOLS: ERROR: traceChildrenIn(): Unable to trace children in " + target);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function removeAllChildrenIn(target:*):void
		{
			try { 
				while(target.numChildren) 
				{ 
					target.removeChildAt(0); 
				} 
			} catch (e:Error) {
				trace("#### DTOOLS: ERROR: removeAllChildrenIn(): Unable to remove children from " + target);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function hideAllChildrenIn(target:*):void
		{
			try {
				for (var i:Number = 0; i <= target.numChildren-1; i++)
				{
					try {
						//trace("##### target at ["+i+"] = " + target.getChildAt(i) + " is now hidden!");
						target.getChildAt(i).visible = false;
						//target.removeChildAt(0);
					} catch (e:Error) {
						trace("#### DTOOLS: ERROR: hideAllChildrenIn(): index ["+i+"] name: ["+ target.name + "] getChildAt [" + target.getChildAt(i) + "] target: [" + target + "]");
						target.visible = true;
					}
				}
				
			} catch (e:Error) {
				trace("#### DTOOLS: ERROR: hideAllChildrenIn(): Unable to hide children in " + target);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function setAlphaOfAllChildrenIn(target:*,alphaValue:Number):void
		{
			try { 
				for (var i:Number = 0; i <= target.numChildren; i++)
				{ 
					try {
						target.getChildAt(i).alpha = alphaValue;
						//target.removeChildAt(0);
					} catch (e:Error) {
						trace("#### DTOOLS: ERROR: setAlphaOfAllChildrenIn(): Unable to set the alpha of ["+ target + "] in " + target);
					}
				} 
			} catch (e:Error) {
				trace("#### DTOOLS: ERROR: setAlphaOfAllChildrenIn(): Unable to set the alpha of children in " + target);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static var callBackTimer:Timer;
		public static var callBackTime:Number;
		public static var callBackFunction:Function;
		public static function waitAndCallBack(delayInSeconds:Number,functionToCallBack:Function):void
		{
			trace("#### DTools.waitAndCallBack(delayInSeconds:"+delayInSeconds+", functionToCallBack)");
			
			callBackTime = delayInSeconds * 1000;
			callBackFunction = functionToCallBack;
			callBackTimer = new Timer(delayInSeconds*callBackTime);
			callBackTimer.addEventListener(TimerEvent.TIMER,waitAndCallBackTimerComplete);
			callBackTimer.start();
			
		}
		public static function waitAndCallBackTimerComplete(e:TimerEvent):void
		{
			callBackTimer.stop();
			
			try {
				callBackTimer.removeEventListener(TimerEvent.TIMER,waitAndCallBackTimerComplete);
			} catch (e:Error) {}
			
			callBackFunction.call();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getValueFromURLString(source:String,paramater:String):String
		{
			var result:String = "";
			
			// Split into value pairs
			var sourceSplit:Array = source.split("&");
			//trace(sourceSplit);
			
			// Find array position with paramater in
			var indexFound:Number = -1;
			for (var i:uint = 0; i < sourceSplit.length; i++)
			{
				//trace(sourceSplit[i]);
				if (isInString(sourceSplit[i],paramater))
				{
					indexFound = i;
				}
			}
			
			if (indexFound == -1){
				return "0";
			}
			
			var pairSplit:Array = sourceSplit[indexFound].split("=");
			result = pairSplit[pairSplit.length-1];
			
			//trace(result);
			
			return result;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function isInString(source:String,find:String):Boolean
		{
			if (source.indexOf(find) == -1)
			{
				return false;
			}
			return true;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function replaceForwardSlashes(source:String,replacementString:String):String
		{
			var regEx:RegExp = /(\/)/g;
			return source.replace( regEx,replacementString );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function trim(arg:String):String
		{ 
			//return arg ? arg.replace(/^\s+|\s+$/gs, '') : "";
			return arg.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getFileExtension(str:String):String
		{
			var extIndex:Number = str.lastIndexOf(".");
			if (extIndex == -1) {
				return "";
			} else {
				return str.substr(extIndex + 1,str.length);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// 1 Decimal place
		public static function getPercentageFromProgressEvent(e:ProgressEvent):Number
		{
			var p:Number = 0;
			
			p = (100/e.bytesTotal * e.bytesLoaded) * 100;
			p = Math.round(p) / 100;
			
			return p;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function mergeBitmapData(bitmapData1:BitmapData,bitmapData2:BitmapData,alpha1:Number=255,alpha2:Number=255):BitmapData
		{			
			var result:BitmapData = new BitmapData(bitmapData1.width, bitmapData1.height, true, 0);
			//result.draw(bitmapData1);
			result.merge(bitmapData1,bitmapData1.rect,new Point(0, 0),128,128,128,alpha1);
			result.merge(bitmapData2,bitmapData1.rect,new Point(0, 0),128,128,128,alpha2);
			
			return result;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// Simply takes a degree value and ensures it's max is 360 if 361 or 721 it converts to 1 degree
		public static function convertDegreeTo360Limit(degrees:Number):Number
		{			
			var rotations:Number = Math.floor(Math.abs(degrees)/360);
			return Math.round(Math.abs(degrees) - (rotations * 360));
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private static function createDebugTextField(width:Number,height:Number,border:Boolean=true,background:Boolean=true,label:String="textfield"):TextField
		{
			var txt:TextField = new TextField();
			txt.width = width;
			txt.height = height;
			txt.border = border;
			txt.background = background;
			txt.text = label;
			return txt;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function rotateBitmap(degrees:Number,bmp:Bitmap):BitmapData
		{
			var bmpData:BitmapData;
			
			
			var matrix:Matrix = new Matrix();
			matrix.translate(-bmpData.width/2, -bmpData.height/2);
			matrix.rotate(toRad(degrees));
			matrix.translate(bmpData.width/2, bmpData.height/2);
			bmpData = new BitmapData(bmpData.width,bmpData.height,true,0);
			bmpData.draw(bmp, matrix);
			
			return bmpData;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function toRad(n:Number):Number
		{
			return (n * 0.0174532925);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function findItemInArray(itemToFind:*,arrayToSearch:Array,exclusionList:Array=null):Number
		{
			var index:Number = -1;
			
			//trace("");
			//trace("----------");
			for (var i:uint = 0; i <= arrayToSearch.length-1; i++)
			{
				//trace("Checking arrayToSearch["+i+"] = [" + arrayToSearch[i] + "] typeof:" + typeof(arrayToSearch[i]) + "   to see if it matches [" + itemToFind + "] typeof: " + typeof(itemToFind) );
				if (arrayToSearch[i] == itemToFind)
				{
					//trace("MATCH FOUND");
					
					if (exclusionList){
						// Check if arrayToSearch[i] is in the exclusionList
						var exclusionFound:Boolean = false;
						for (var v:uint = 0; v <= exclusionList.length-1; v++)
						{
							//trace("\t" + "Checking to see if the found item in arrayToSearch["+i+"] = " + arrayToSearch[i] + "  is not in the exclusion list exclusionList["+v+"] = " + exclusionList[v]);
							if (exclusionList[v] == arrayToSearch[i])
							{
								// Exclusion found
								exclusionFound = true;
								//trace("\t" + "Item is in the exclusion list keep on checking");
								break;
							}
						}
						if (!exclusionFound)
						{
							index = i;
							//trace("Item is not in exclusion list we can return the index and break the loop checking: index = [" + index + "]");
							break;
						}
					} else {
						//trace("No exclusion list specified can return the index it has been found on: index = [" + index + "]");
						index = i;
						break;
					}
				}
			}
			//trace("----------");
			//trace("");
			return index;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getBooleanFromNumber(n:Number):Boolean
		{
			if (n>1 || n<0){
				trace("");
				trace("DTools ## WARNING ## get Boolean from number() has been supplied a number greater than 1 or less than 0, returning true");
				trace("");
				return true;
			}
			
			if (n == 0)
			{
				return false;
			} else {
				return true;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getBooleanFromString(str:String):Boolean
		{
			str = str.toLowerCase();
			
			if (str != "false" && str != "true" && str != "0" && str != "1"){
				trace("");
				trace("DTools ## WARNING ## get Boolean from string() has not been supplied a usable input [" + str + "]");
				trace("DTools ## WARNING ## Input required is either 0,1,true or false. Returning true as default.");
				trace("");
				return true;
			}
			
			if (str == "false" || str == "0")
			{
				return false;
			} else {
				return true;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function centerStageX(stageWidth:Number,obj:DisplayObject,offset:Number=0,setWidth:Number=0):void
		{
			if (setWidth == 0){
				obj.x = ((stageWidth/2) - (obj.width/2)) + offset;
			} else {
				obj.x = ((stageWidth/2) - (setWidth/2)) + offset;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function centerStageY(stageHeight:Number,obj:DisplayObject,offset:Number=0,setHeight:Number=0):void
		{
			if (setHeight == 0){
				obj.y = ((stageHeight/2) - (obj.height/2)) + offset;
			} else {
				obj.y = ((stageHeight/2) - (setHeight/2)) + offset;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function isValidEmail(email:String):Boolean
		{
			var regExpPattern : RegExp = /^[0-9a-zA-Z][-._a-zA-Z0-9]*@([0-9a-zA-Z][-._0-9a-zA-Z]*\.)+[a-zA-Z]{2,4}$/;
			
			if( email.match(regExpPattern) == null ){
				return false;
			} else {
				return true;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		public static function aspectRatioResizeNoCrop(displayObject:DisplayObject,targetW:Number,targetH:Number):void
		{
			trace("aspectRatioResizeNoCrop: displayObject: " + displayObject + "   mcw:" + displayObject.width + "   mch:" + displayObject.height);
			
			if (displayObject.width > displayObject.height){
				//trace("SET BY WIDTH");
				displayObject.height = targetH;
				displayObject.scaleX = displayObject.scaleY;
			} else {
				//trace("SET BY HEIGHT");
				displayObject.width = targetW;
				displayObject.scaleY = displayObject.scaleX;
			}
		}
		
		
		/*
		incrementUV(plane, new Point(0.01, 0.01));
		scaleUV(plane, new Point(0.99, 0.99));
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function incrementUV(m:Mesh, pos:Point):void
		{
		var v:Vector.<Number> = SubGeometry(m.geometry.subGeometries[0]).UVData;
		for (var i:int = 0; i < v.length; i=i+2)
		{
		v[i] += pos.x;
		v[i + 1] += pos.y;
		SubGeometry(m.geometry.subGeometries[0]).updateUVData(v);
		}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function scaleUV(m:Mesh, pos:Point):void
		{
		var v:Vector.<Number> = SubGeometry(m.geometry.subGeometries[0]).UVData;
		for (var i:int = 0; i < v.length; i=i+2)
		{
		v[i] += ( pos.x - 1) * 0.5;
		v[i + 1] += (pos.y - 1) * 0.5;
		
		v[i] /= pos.x
		v[i + 1] /= pos.y;
		
		SubGeometry(m.geometry.subGeometries[0]).updateUVData(v);
		}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function rotateUV(m:Mesh, rotationDeg:Number, rotateAbout:Point):void
		{
		var v:Vector.<Number> = SubGeometry(m.geometry.subGeometries[0]).UVData;
		var r:Number= rotationDeg*(Math.PI/180);
		
		
		for (var i:int = 0; i < v.length; i=i+2)
		{
		v[i] -= rotateAbout.x;
		v[i + 1] -= rotateAbout.y;
		v[i] = v[i] * Math.cos(r) + v[i + 1] * -Math.sin(r);
		v[i + 1] = v[i] * Math.sin(r) +v[i + 1] * Math.cos(r);
		v[i] += rotateAbout.x;
		v[i + 1] += rotateAbout.y;
		}
		SubGeometry(m.geometry.subGeometries[0]).updateUVData(v);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		*/
		
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}