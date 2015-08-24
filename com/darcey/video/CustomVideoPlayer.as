package com.darcey.video
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.events.CustomEvent;
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class CustomVideoPlayer extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public var t:Ttrace;
		
		private var stageRef:Stage;
		public var customClient:CustomVideoPlayerClient;
		public var nc:NetConnection = new NetConnection();
		public var ns:NetStream;
		public var video:Video;
		
		public var src:String = "";
		private var vw:Number = 640;
		private var vh:Number = 480;
		
		private var autoPlay:Boolean = true;
		
		//public var client:CustomVideoPlayerClient;
		
		public var playbackTime:Number = 0;
		public var duration:Number = 0;
		
		public var videoVolumeTransform:SoundTransform;
		
		public var isPlaying:Boolean;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function CustomVideoPlayer(stageRef:Stage,src:String,videoW:Number=640,videoH:Number=480,autoPlay:Boolean=false,repeat:Boolean=true)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.ttrace("CustomVideoPlayer(stageRef:"+stageRef+",src:"+src+", videoW:"+videoW+", videoH:"+videoH+",autoPlay:" + autoPlay + ",repeat:" + repeat + ")");
			
			
			// Var ini
			this.stageRef = stageRef;
			this.src = src;
			vw = videoW;
			vh = videoH;
			this.autoPlay = autoPlay;
			
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
			t.ttrace("CustomVideoPlayer.init()");
			
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			nc.connect(null);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("CustomVideoPlayer.securityErrorHandler: " + event);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					t.ttrace("CustomVideoPlayer.netStatusHandler(event): Connection success");
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					t.ttrace("CustomVideoPlayer.netStatusHandler(event): Stream not found: " + src);
					break;
				case "NetStream.Play.Stop":
					t.ttrace("CustomVideoPlayer.netStatusHandler(event): Playback complete");
					dispatchEvent( new Event( Event.COMPLETE ) );
					break;
				default:
					t.ttrace("CustomVideoPlayer.netStatusHandler(event): code = " + event.info.code);
					dispatchEvent( new CustomEvent(event.info.code) );
					break;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function connectStream():void {
			
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			videoVolumeTransform = new SoundTransform(1);
			//ns.soundTransform = videoVolumeTransform;
			//this.soundTransform = new SoundTransform(1);
			ns.soundTransform = videoVolumeTransform;
			
			customClient = new CustomVideoPlayerClient();
			//customClient.addEventListener("CuePoint",cuePointHandler);
			
			//customClient.onMetaData = onMetaData.onMetaData;
			
			ns.client = customClient;
			video.attachNetStream(ns);
			ns.play(src);
			
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function volume(n:Number):void
		{
			videoVolumeTransform.volume = n;
			ns.soundTransform = videoVolumeTransform;
			//this.soundTransform.volume = n;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function cuePointHandler(e:CustomEvent):void
		{
			t.ttrace("CustomVideoPlayer.cuePointHandler(e)");
			
			dispatchEvent( e );
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
				ns.resume();
				//ns.pause();
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
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function changeVideo(src:String):void
		{
			this.src = src;
			
			try {
				ns.close();
			} catch (e:Error) {}
			
			//new RemoveAllChildrenIn(this);
			
			//video = new Video(vw,vh);
			//addChild(video);
			
			try {
				nc.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				nc.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			} catch (e:Error) {}
			nc = null;
			
			try {
				ns.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			} catch (e:Error) {}
			ns = null;
						
			init();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		public function dispose():void
		{
			t.ttrace("CustomVideoPlayer.dispose()");
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
				video.clear();
				video = null;
			} catch (e:Error) {}
			
			
			try {
				//client.removeEventListener("playback complete",playbackComplete);
				//client = null;
			} catch (e:Error) {}
		}
		
		
		/*
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onNCStatus(e:NetStatusEvent):void
		{
			t.ttrace("");
			t.ttrace("CustomVideoPlayer.onNCStatus(e): " + e.type + "  " + e.info);
			
			
			t.ttrace("### e.info.code: " + e.info.code);
			
			switch (e.info.code)
			{
				case "NetConnection.Connect.Success":
					ns = new NetStream(nc);
					ns.addEventListener(NetStatusEvent.NET_STATUS, liveStreamStatusEventsHandler);
					//client = new CustomVideoPlayerClient();
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
			t.ttrace("CustomVideoPlayer.liveStreamStatusEventsHandler(e): e.info.code = [" + e.info.code + "]");
			
			
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
						t.ttrace("LOADING COMPLETE [" + url + "]");
						dispatchEvent( new CustomEvent("loading complete") );
					}
				} else {
					var p:Number = Math.round(   (((100/ns.bytesTotal) * ns.bytesLoaded)*10)      ) / 10;
					t.ttrace("LOADING [" + url + "] - " + p + "%     ns.bytesTotal: [" + ns.bytesTotal + "]   ns.bytesLoaded: [" + ns.bytesLoaded + "]");
				}
				
				
				playTime = (Math.round(ns.time*10))/10;
				videoLength = ns.client.duration;
				
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function playbackComplete(e:Event):void
		{
			t.ttrace("##### VIDEO PLAYBACK COMPLETE [ " + this.url + "] #####");
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
			t.ttrace("CustomVideoPlayer.onMetaDataHandler(o): " + o);
			
		}  
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function onCuePointHandler(o:Object):void
		{
			t.ttrace("CustomVideoPlayer.onCuePointHandler(o): " + o);
			//t.ttrace(o.name + "\t" + o.time);
		}  
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		public function play():void
		{
			t.ttrace("CustomVideoPlayer.play()");
			ns.play(url);
			//ns.resume();
		}
		
		
		public function seek(time:Number):void
		{
			t.ttrace("CustomVideoPlayer.seek(time:"+time+")");
			ns.seek(time);
		}
		
		public function resume():void
		{
			t.ttrace("CustomVideoPlayer.resume()");
			ns.resume();
		}
		
		public function stop():void
		{
			if (ns){
				t.ttrace("CustomVideoPlayer.stop()");
				ns.pause();
				ns.seek(0);
			} else {
				t.ttrace("CustomVideoPlayer.stop() error");
			}
		}
		
		public function pause():void
		{
			ns.pause();
		}
		
		
		
		
		
		public function dispose():void
		{
			t.ttrace("CustomVideoPlayer.dispose()");
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