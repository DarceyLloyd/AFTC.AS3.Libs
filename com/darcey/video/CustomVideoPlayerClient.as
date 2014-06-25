package com.darcey.video
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.events.CustomEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class CustomVideoPlayerClient extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		public var width:Number = 0;
		public var height:Number = 0;
		public var duration:Number = 0;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function CustomVideoPlayerClient()
		{
			// Setup class specific tracer
			t = new Ttrace(false);
			t.ttrace("CustomVideoPlayerClient()");
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onMetaData(info:Object):void
		{
			//trace("metadata: duration=" + info.duration + " framerate=" + info.framerate);
			
			t.ttrace("CustomVideoPlayerClient.onMetaData(info):");
			
			width = parseInt(info["width"]);
			height = parseInt(info["height"]);
			duration = parseFloat(info["duration"]);
			
			for(var index:String in info) {				
				t.ttrace("\t" + index + " = " + info[index]);
			}
			t.ttrace("--------------------------------------------------------------\n");
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onImageDataHandler(imageData:Object):void
		{
			trace("imageData length: " + imageData.data.length);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

			
		public function onXMPData(o:Object):void 
		{ 
			t.ttrace("VideoPlayerCustomClient.onXMPData(o): ");
			
			/*
			// Alternative to Meta - only use when needed (FP10+ only) - USE META FOR 9
			// http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3/WSD30FA424-950E-43ba-96C8-99B926943FE7.html
			trace("onXMPData Fired\n"); 
			//trace("raw XMP =\n"); 
			//trace(o.data); 
			var cuePoints:Array = new Array(); 
			var cuePoint:Object; 
			var strFrameRate:String; 
			var nTracksFrameRate:Number; 
			var strTracks:String = ""; 
			var onXMPXML = new XML(o.data); 
			// Set up namespaces to make referencing easier 
			var xmpDM:Namespace = new Namespace("http://ns.adobe.com/xmp/1.0/DynamicMedia/"); 
			var rdf:Namespace = new Namespace("http://www.w3.org/1999/02/22-rdf-syntax-ns#"); 
			for each (var it:XML in onXMPXML..xmpDM::Tracks) 
			{ 
			var strTrackName:String = it.rdf::Bag.rdf::li.rdf::Description.@xmpDM::trackName; 
			var strFrameRateXML:String = it.rdf::Bag.rdf::li.rdf::Description.@xmpDM::frameRate; 
			strFrameRate = strFrameRateXML.substr(1,strFrameRateXML.length); 
			
			nTracksFrameRate = Number(strFrameRate);  
			
			strTracks += it; 
			} 
			var onXMPTracksXML:XML = new XML(strTracks); 
			var strCuepoints:String = ""; 
			for each (var item:XML in onXMPTracksXML..xmpDM::markers) 
			{ 
			strCuepoints += item; 
			} 
			trace(strCuepoints); 
			*/
			
		}
		
		
		
		public function onCuePoint(o:Object=null):void
		{
			t.ttrace("VideoPlayerCustomClient.onCuePoint(o): " + o);
			t.ttrace("cuepoint: time=" + o.time + " name=" + o.name + " type=" + o.type);
			
			dispatchEvent( new CustomEvent("CuePoint",o) );
		}  
		
		
		
		public function onPlayStatus(e:Object):void
		{
			t.ttrace("VideoPlayerCustomClient.onPlayStatus(e): " + e);
			t.ttrace(e.name + "\t" + e.time);
			
			for (var prop:* in e) {
				t.ttrace("\t"+prop+":\t"+e[prop]);
			}
			
			if (e.code == "NetStream.Play.Complete"){
				dispatchEvent( new Event(Event.COMPLETE) );
			}
		} 
		
		

	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}