package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.debug.VTrace;
	import com.darcey.utils.DTools;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.media.Microphone;

	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class Microphone extends EventDispatcher
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		// http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/media/Microphone.html
		/*
		SampleRate values:
			rate value			Actual frequency
			44					44,100 Hz
			22					22,050 Hz
			11					11,025 Hz
			8					8,000 Hz
			5					5,512 Hz
		
		
		*/
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		
		private var stage:Stage; // Stage is required for enter frame processor
		
		public var deviceIndex:Number = -1;
		
		public var gain:Number = 50; // The amount by which the microphone boosts the signal. Valid values are 0 to 100. The default value is 50
		public var sampleRate:Number = 11;
		public var loopBack:Boolean = false;
		public var silenceLevel:Number = 30; // The minimum input level that should be considered sound
		public var silenceTimeout:int = -1; // The amount of silent time signifying that silence has actually begun
		
		private var triggerEventAtVolumeEnabled:Boolean = false;
		private var triggerEventAtVolume:Number = 90;
		
		public var mic:flash.media.Microphone;
		
		private var debug:Boolean = false;
		private var vt1:VTrace;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function Microphone(stage:Stage,debug:Boolean=false)
		{
			this.debug = debug;
			
			// Setup class specific tracer
			t = new Ttrace(debug);
			t.ttrace("Microphone()");
			
			this.stage = stage;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function connect(deviceIndex:Number):void
		{
			t.ttrace("Microphone.connect(deviceIndex)");
			
			this.deviceIndex = deviceIndex;
			mic = flash.media.Microphone.getMicrophone(deviceIndex);
			mic.setLoopBack(loopBack);
			mic.setSilenceLevel(silenceLevel,silenceTimeout);
			mic.gain = gain;
			mic.rate = sampleRate;
			
			t.clear();
			t.ttrace("Microphone.connect(deviceIndex): mic = " + mic);
			
			if (debug){
				vt1 = new VTrace(mic,"activityLevel");
				DTools.setScale(vt1,4);
				stage.addChild(vt1);
			}
			
			
			// NOTE: Ensure this is set so that the microphone is enabled, without this the 
			// microphone will not dispatch events
			// NOTE: If loopback is true then the microphone will dispatch events without this
			mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			mic.addEventListener(StatusEvent.STATUS, micStatusEventHandler);
			stage.addEventListener(Event.ENTER_FRAME,enterFrameEventHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function triggerCompleteEventAtVolume(vol:Number):void
		{
			t.ttrace("Microphone.triggerCompleteEventAtVolume(vol:"+vol+")");
			triggerEventAtVolume = vol;
			triggerEventAtVolumeEnabled = true;
		}
		public function dissableTriggerCompleteEventAtVolume():void
		{
			triggerEventAtVolumeEnabled = false;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function onSampleData(e:SampleDataEvent):void
		{
			//t.ttrace("Microphone.onSampleData(e)");
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function micStatusEventHandler(e:StatusEvent):void
		{
			t.ttrace("Microphone.micStatusEventHandler(e): e.code = " + e.code);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function enterFrameEventHandler(e:Event):void
		{
			if (!mic){ return; }
			
			//t.ttrace("Microphone.enterFrameEventHandler(e): mic.activityLevel = " + mic.activityLevel);
			
			if (triggerEventAtVolumeEnabled){
				if (mic.activityLevel > triggerEventAtVolume){
					dispatchEvent( new Event(Event.COMPLETE) );
				}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function listDevices():void
		{
			t.div();
			t.ttrace("Microphone.listDevices()");
			for (var index:* in flash.media.Microphone.names)
			{
				t.ttrace(index + ". " + flash.media.Microphone.names[index]);
			}
			t.div();
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function dispose():void
		{
			try {
				mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			} catch (e:Error) {}
			
			try {
				mic.removeEventListener(StatusEvent.STATUS, micStatusEventHandler);
			} catch (e:Error) {}
			
			try {
				stage.removeEventListener(Event.ENTER_FRAME,enterFrameEventHandler);
			} catch (e:Error) {}
			
			if (vt1){
				try {
					stage.removeChild(vt1);
				} catch (e:Error) {}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
}