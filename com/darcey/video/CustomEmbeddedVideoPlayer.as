package com.darcey.video
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.ByteArray;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class CustomEmbeddedVideoPlayer extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var stageRef:Stage;
		public var nc:NetConnection = new NetConnection();
		public var ns:NetStream;
		public var video:Video;
		
		private var vw:Number = 640;
		private var vh:Number = 480;
		
		private var autoPlay:Boolean = true;
		
		//public var client:CustomEmbeddedVideoPlayerClient;
		
		public var playbackTime:Number = 0;
		public var duration:Number = 0;
		
		public var videoClass:Class;
		public var videoByteArray:ByteArray;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function CustomEmbeddedVideoPlayer(stageRef:Stage,videoClass:Class,videoW:Number=640,videoH:Number=480,autoPlay:Boolean=false,repeat:Boolean=true)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.string("CustomEmbeddedVideoPlayer(stageRef, videoClass, videoW, videoH, autoPlay, repeat)");
			
			
			
			// Var ini
			this.stageRef = stageRef;
			vw = videoW;
			vh = videoH;
			this.autoPlay = autoPlay;
			this.videoClass = videoClass;
			
			video = new Video(vw,vh);
			addChild(video);
			
			if (autoPlay){
				init();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function init():void
		{
			t.string("CustomEmbeddedVideoPlayer.init()");
			
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			nc.connect(null);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("CustomEmbeddedVideoPlayer.securityErrorHandler: " + event);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					t.string("CustomEmbeddedVideoPlayer.netStatusHandler(event): Connection success");
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					t.string("CustomEmbeddedVideoPlayer.netStatusHandler(event): Embedded stream not found!");
					break;
				case "NetStream.Play.Stop":
					t.string("CustomEmbeddedVideoPlayer.netStatusHandler(event): Playback complete");
					dispatchEvent( new Event( Event.COMPLETE ) );
					break;
				default:
					t.string("CustomEmbeddedVideoPlayer.netStatusHandler(event): code = " + event.info.code);
					break;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function connectStream():void {
			
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.client = new CustomVideoPlayerClient();
			video.attachNetStream(ns);
			//ns.play(url);
			
			ns.play(null);
			videoByteArray = new videoClass();
			ns.appendBytes(videoByteArray);
			video.attachNetStream(ns);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function play():void
		{
			if (!ns){
				init();
				return;
			}
			
			if (!nc){
				init();
				return;
			}
			
			
			if (ns){
				ns.pause();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function pause():void
		{
			if (ns){
				ns.pause();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function stop():void
		{
			if (ns){
				ns.pause();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function seek(to:Number):void
		{
			if (ns){
				ns.seek(to);
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		/*
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onNCStatus(e:NetStatusEvent):void
		{
			t.string("");
			t.string("CustomEmbeddedVideoPlayer.onNCStatus(e): " + e.type + "  " + e.info);
			
			
			t.string("### e.info.code: " + e.info.code);
			
			switch (e.info.code)
			{
				case "NetConnection.Connect.Success":
					ns = new NetStream(nc);
					ns.addEventListener(NetStatusEvent.NET_STATUS, liveStreamStatusEventsHandler);
					//client = new CustomEmbeddedVideoPlayerClient();
					//ns.client = client;
					var o:Object = new Object();
					o.onMetaData = function(s:*=null):void{};
					ns.client = o;
					vid.attachNetStream(ns);
					if (!autoPlay){
						ns.pause();
					} else {
						ns.play(url);
					}
					break;
				
				case "NetStream.Publish.BadName":
					trace("");
					trace("### VideoPlayer ERROR: Please check the name of the publishing stream [NetStream.Publish.BadName] url = [" + url + "]");
					trace("");
					break;
			}   
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function liveStreamStatusEventsHandler(e:NetStatusEvent):void
		{
			t.div();
			t.string("CustomEmbeddedVideoPlayer.liveStreamStatusEventsHandler(e): e.info.code = [" + e.info.code + "]");
			
			
			switch (e.info.code)
			{
				case "NetStream.Play.Start":
					try {
						videoLength = (Math.round(ns.client.length*10))/10;
					} catch (e:Error) {}
					if (stageRef){
						stageRef.addEventListener(Event.ENTER_FRAME,streamProgressHandler);
					}
					break;
				
				case "NetStream.Play.Stop":
					playbackComplete(null);
					break;
				
				
				case "NetStream.Buffer.Full":
					dispatchEvent( new CustomEvent("buffer full") );
					break;
			}
			
			
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var videoLoadedFlagged:Boolean = false;
		private function streamProgressHandler(e:Event):void
		{
			if (ns){
				
				if (ns.bytesTotal == ns.bytesLoaded){
					if (!videoLoadedFlagged){
						videoLoadedFlagged = true;
						t.string("LOADING COMPLETE [" + url + "]");
						dispatchEvent( new CustomEvent("loading complete") );
					}
				} else {
					var p:Number = Math.round(   (((100/ns.bytesTotal) * ns.bytesLoaded)*10)      ) / 10;
					t.string("LOADING [" + url + "] - " + p + "%     ns.bytesTotal: [" + ns.bytesTotal + "]   ns.bytesLoaded: [" + ns.bytesLoaded + "]");
				}
				
				
				playTime = (Math.round(ns.time*10))/10;
				videoLength = ns.client.duration;
				
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function playbackComplete(e:Event):void
		{
			t.string("##### VIDEO PLAYBACK COMPLETE [ " + this.url + "] #####");
			dispatchEvent( new Event(Event.COMPLETE) );			
			
			try {
				stageRef.removeEventListener(Event.ENTER_FRAME,streamProgressHandler);
			} catch (e:Error) {
				
			}
			
			videoLoadedFlagged = false;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onMetaDataHandler(o:Object):void
		{
			t.string("CustomEmbeddedVideoPlayer.onMetaDataHandler(o): " + o);
			
		}  
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onCuePointHandler(o:Object):void
		{
			t.string("CustomEmbeddedVideoPlayer.onCuePointHandler(o): " + o);
			//t.string(o.name + "\t" + o.time);
		}  
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		public function play():void
		{
			t.string("CustomEmbeddedVideoPlayer.play()");
			ns.play(url);
			//ns.resume();
		}
		
		
		public function seek(time:Number):void
		{
			t.string("CustomEmbeddedVideoPlayer.seek(time:"+time+")");
			ns.seek(time);
		}
		
		public function resume():void
		{
			t.string("CustomEmbeddedVideoPlayer.resume()");
			ns.resume();
		}
		
		public function stop():void
		{
			if (ns){
				t.string("CustomEmbeddedVideoPlayer.stop()");
				ns.pause();
				ns.seek(0);
			} else {
				t.string("CustomEmbeddedVideoPlayer.stop() error");
			}
		}
		
		public function pause():void
		{
			ns.pause();
		}
		
		
		
		
		
		public function dispose():void
		{
			t.string("CustomEmbeddedVideoPlayer.dispose()");
			new RemoveAllChildrenIn(this);
			
			try {
				ns.close();
				ns = null;
			} catch (e:Error) {}
			
			try {
				nc.close();
				nc = null;
			} catch (e:Error) {}
			
			try {
				vid.clear();
				vid = null;
			} catch (e:Error) {}
			
			
			try {
				//client.removeEventListener("playback complete",playbackComplete);
				//client = null;
			} catch (e:Error) {}
		}
		
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
	*/
		
	}
}