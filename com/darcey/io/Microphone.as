package com.darcey.io
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	import com.darcey.debug.VTrace;
	import com.darcey.utils.DTools;
	import com.darcey.utils.RemoveAllChildrenIn;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.events.StatusEvent;
	import flash.events.TimerEvent;
	import flash.media.Microphone;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	
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
		public var gain:Number = 20; // The amount by which the microphone boosts the signal. Valid values are 0 to 100. The default value is 50
		public var sampleRate:Number = 11;
		public var loopBack:Boolean = false;
		public var silenceLevel:Number = 0; // The minimum input level that should be considered sound
		public var silenceTimeout:int = -1; // The amount of silent time signifying that silence has actually begun
		
		
		
		private var volumeSampleTimer:Timer;
		
		private var volumeSampleFreq:Number = 300;
		private var noOfVolumeSamplesToBeTaken:Number = 10;
		private var volumes:Array = new Array();
		private var medianVol:Number = 0;
		public var medianVolAdditionalTrigger:Number = 20;
		private var triggerEventAtVolume:Number = 200;
		private var medianCalculationStarted:Boolean = false;
		
		public var mic:flash.media.Microphone;
		public var connected:Boolean = false;
		
		public var triggerCompleteEventAtVolumeEnabled:Boolean = false;
		
		private var debug:Boolean = false;
		private var vt1:VTrace;
		private var txt:TextField;
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
			t.ttrace("Microphone.connect(deviceIndex:"+deviceIndex+")");
			
			this.deviceIndex = deviceIndex;
			mic = flash.media.Microphone.getMicrophone();
			if (!mic){
				t.wdiv()
				t.wdiv()
				t.warn("ERROR: UNABLE TO GET MICROPHONE AT DEVICE INDEX [" + deviceIndex + "]");
				t.wdiv()
				t.wdiv()
				return;
			}
			mic.setSilenceLevel(silenceLevel,silenceTimeout);
			mic.gain = gain;
			mic.rate = sampleRate;
			mic.setLoopBack(loopBack);
			
			t.clear();
			t.ttrace("Microphone.connect(deviceIndex:"+deviceIndex+"): mic = " + mic);
			
			if (debug){
				vt1 = new VTrace(mic,"activityLevel");
				DTools.setScale(vt1,4);
				stage.addChild(vt1);
				
				txt = new TextField();
				txt.width = 300;
				txt.height = 35;
				txt.background = true;
				txt.text = "txt";
				txt.y = 100;
				DTools.setScale(txt,3);
				stage.addChild(txt);
			}
			
			
			
			
			// NOTE: Ensure this is set so that the microphone is enabled, without this the 
			// microphone will not dispatch events
			// NOTE: If loopback is true then the microphone will dispatch events without this
			this.addEventListener(Event.CONNECT,iniUserConfig);
			mic.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			mic.addEventListener(StatusEvent.STATUS, micStatusEventHandler);
			//stage.addEventListener(Event.ENTER_FRAME,enterFrameEventHandler);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function triggerCompleteEventAtVolume(vol:Number):void
		{
			t.ttrace("Microphone.triggerCompleteEventAtVolume(vol:"+vol+")");
			triggerEventAtVolume = vol;
			triggerCompleteEventAtVolumeEnabled = true;
		}
		public function dissableTriggerCompleteEventAtVolume():void
		{
			triggerCompleteEventAtVolumeEnabled = false;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function onSampleData(e:SampleDataEvent):void
		{
			//t.ttrace("Microphone.onSampleData(e): mic.activityLevel = " + mic.activityLevel);
			if (!connected){
				connected = true;
				dispatchEvent( new Event(Event.CONNECT) );
				t.ttrace("Microphone.onSampleData(e): Mic connected and data being processed");
			} else {
				//connected = false;
				if (triggerCompleteEventAtVolumeEnabled){
					//calculateMedian(null);
				}
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function micStatusEventHandler(e:StatusEvent):void
		{
			t.ttrace("Microphone.micStatusEventHandler(e): e.code = " + e.code);
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		public var calculateVolumeMedian:Boolean = false;
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function iniUserConfig(e:Event):void
		{
			t.ttrace("Microphone.iniUserConfig(e)");
			
			try {
				this.removeEventListener(Event.CONNECT,iniUserConfig);
			} catch (e:Error) {}
			
			if (calculateVolumeMedian){
				volumeSampleTimer = new Timer(volumeSampleFreq);
				volumeSampleTimer.addEventListener(TimerEvent.TIMER,calculateMedian);
				volumeSampleTimer.start();
			}
			
			
			if (enableAutoTrigger){
				setupAutoTrigger();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private function calculateMedian(e:TimerEvent):void
		{
			//t.ttrace("Microphone.calculateMedian(e): mic.activityLevel = " + mic.activityLevel);
			
			if (!mic){ return; }
			if (mic.activityLevel < 0){ return; }
			
			
			volumes.push(mic.activityLevel);
			
			if (volumes.length > noOfVolumeSamplesToBeTaken){
				volumes.shift();
			}
			
			if (t.enabled){
				//trace(volumes);
			}
			
			if (volumes.length == noOfVolumeSamplesToBeTaken){
				
				medianCalculationStarted = true;
				
				for (var i:int = 0; i < volumes.length; i++) 
				{
					medianVol += volumes[i];
				}
				medianVol = medianVol/noOfVolumeSamplesToBeTaken;
				triggerEventAtVolume = medianVol + medianVolAdditionalTrigger;
				if (triggerEventAtVolume>100)
				{
					triggerEventAtVolume = 100;
				}
			}
			
			
			if (mic.activityLevel >= triggerEventAtVolume){
				dispatchEvent( new Event(Event.COMPLETE) );
				try {
					stage.removeChild(txt);
				} catch (e:Error) {}
				t.ttrace("MIC TRIGGER VOLUME REACHED!");
				if (txt){
					txt.text = "medianVol: " + medianVol.toFixed(2) + "    triggerEventAtVolume: " + triggerEventAtVolume.toFixed(2) + "\n" + mic.activityLevel.toFixed(2) + "/" + triggerEventAtVolume.toFixed(2) + " TRIGGER!";
				}
			} else {
				if (txt){
					txt.text = "medianVol: " + medianVol.toFixed(2) + "    triggerEventAtVolume: " + triggerEventAtVolume.toFixed(2) + "\n" + mic.activityLevel.toFixed(2) + "/" + triggerEventAtVolume.toFixed(2);
				}
			}
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public var enableAutoTrigger:Boolean = false;
		public var autoTriggerAfter:Number = 4;
		private var autoTriggerTimer:Timer;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function autoTriggerCompleteEventAfter(delayInSeconds:Number):void
		{
			t.ttrace("Microphone.autoTriggerCompleteEventAfter(delayInSeconds:"+delayInSeconds+")");
			enableAutoTrigger = true;
			autoTriggerAfter = delayInSeconds * 1000;
			
			if (connected){
				setupAutoTrigger();
			}
		}
		private function setupAutoTrigger():void
		{
			t.ttrace("Microphone.setupAutoTrigger()");
			
			autoTriggerTimer = new Timer(autoTriggerAfter);
			autoTriggerTimer.addEventListener(TimerEvent.TIMER,autoTriggerTimerEventHandler);
			autoTriggerTimer.start();
		}
		private function autoTriggerTimerEventHandler(e:TimerEvent):void {
			if (medianCalculationStarted){
				t.ttrace("Microphone.autoTriggerTimerEventHandler(e)");
				enableAutoTrigger = false;
				autoTriggerTimer.stop();
				autoTriggerTimer.removeEventListener(TimerEvent.TIMER,autoTriggerTimerEventHandler);
				autoTriggerTimer = null;
				dispatchEvent( new Event(Event.COMPLETE) );
				try {
					stage.removeChild(txt);
				} catch (e:Error) {}
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
				stage.removeChild(txt);
			} catch (e:Error) {}
			
			try {
				mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			} catch (e:Error) {}
			
			try {
				mic.removeEventListener(StatusEvent.STATUS, micStatusEventHandler);
			} catch (e:Error) {}
			
			/*
			try {
			stage.removeEventListener(Event.ENTER_FRAME,enterFrameEventHandler);
			} catch (e:Error) {}
			*/
			
			try {
				volumeSampleTimer.removeEventListener(TimerEvent.TIMER,calculateMedian);
			} catch (e:Error) {}
			
			try {
				autoTriggerTimer.removeEventListener(TimerEvent.TIMER,autoTriggerTimerEventHandler);
			} catch (e:Error) {}
			
			volumeSampleTimer = null;
			autoTriggerTimer = null;
			volumes = null;
			
			if (vt1){
				try {
					stage.removeChild(vt1);
				} catch (e:Error) {}
			}
			
			
			
			txt = null;
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
}