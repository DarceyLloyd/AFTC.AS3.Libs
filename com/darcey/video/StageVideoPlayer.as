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
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.StageVideo;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class StageVideoPlayer extends Sprite
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public var t:Ttrace;
		
		private var stageRef:Stage;
		public var videoClient:VideoPlayerClient;
		public var nc:NetConnection = new NetConnection();
		public var ns:NetStream;
		public var video:StageVideo;
		public var repeat:Boolean = false;
		
		public var src:String = "";
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var vw:Number = 640;
		private var vh:Number = 480;
		
		private var autoPlay:Boolean = true;
		
		//public var client:StageVideoPlayerClient;
		
		public var playbackTime:Number = 0;
		public var duration:Number = 0;
		
		public var videoVolumeTransform:SoundTransform;
		
		public var isPlaying:Boolean;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function StageVideoPlayer(stageRef:Stage,src:String,videoX:Number=0,videoY:Number=0,videoW:Number=640,videoH:Number=480,autoPlay:Boolean=false,repeat:Boolean=true)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.string("StageVideoPlayer(stageRef:"+stageRef+",src:"+src+", videoW:"+videoW+", videoH:"+videoH+",autoPlay:" + autoPlay + ",repeat:" + repeat + ")");
			
			
			// Var ini
			this.stageRef = stageRef;
			this.src = src;
			this.vx = videoX;
			this.vy = videoY;
			this.vw = videoW;
			this.vh = videoH;
			this.autoPlay = autoPlay;
			this.repeat = repeat;
			
			video = stageRef.stageVideos[0];
			video.viewPort = new Rectangle( vx, vy, vw, vh) ;
			//addChild(video);
			
			if (autoPlay){
				init();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function init():void
		{
			t.string("StageVideoPlayer.init()");
			
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			nc.connect(null);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("StageVideoPlayer.securityErrorHandler: " + event);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					t.string("StageVideoPlayer.netStatusHandler(event): Connection success");
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					t.warn("StageVideoPlayer.netStatusHandler(event): Stream not found: " + src);
					if (!t.enabled){
						trace("###############################################################################");
						trace("StageVideoPlayer.netStatusHandler(event): Stream not found: " + src);
						trace("###############################################################################");
					}
					break;
				case "NetStream.Play.Stop":
					t.string("StageVideoPlayer.netStatusHandler(event): Playback complete");
					dispatchEvent( new Event( Event.COMPLETE ) );
					if (repeat){
						/*
						t.enabled = true;
						t.ttrace("StageVideoPlayer.netStatusHandler(event): repeat = " + repeat);
						t.string("StageVideoPlayer.netStatusHandler(event): repeat = true, attempting to restart video!");
						*/
						//ns.seek(0.01);
						//ns.resume();
						ns.play(src);
					}
					break;
				default:
					t.string("StageVideoPlayer.netStatusHandler(event): code = " + event.info.code);
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
			
			//customClient.addEventListener("CuePoint",cuePointHandler);
			
			//customClient.onMetaData = onMetaData.onMetaData;
			
			videoClient = new VideoPlayerClient();
			ns.client = videoClient;
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
			t.string("StageVideoPlayer.cuePointHandler(e)");
			
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
			t.string("StageVideoPlayer.dispose()");
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
				video = null;
			} catch (e:Error) {}
			
			
			try {
				//client.removeEventListener("playback complete",playbackComplete);
				//client = null;
			} catch (e:Error) {}
		}
		
		
		
		
	}
}