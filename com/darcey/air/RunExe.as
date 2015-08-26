package com.darcey.air
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.filesystem.File;

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class RunExe
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private var t:Ttrace;
		private var fileName:String;
		private var process:NativeProcess;
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function RunExe(fileName:String,args:Array=null)
		{
			// Setup class specific tracer
			t = new Ttrace(true);
			t.string("RunExe(fileName, args)");
			
			this.fileName = fileName;
			
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo(); 
			var file:File = File.applicationDirectory.resolvePath(fileName); 
			nativeProcessStartupInfo.executable = file;
			
			if (args){
				var processArgs:Vector.<String> = new Vector.<String>();
				
				for each (var i:int in args) 
				{
					processArgs.push(args[i]);
				}
				//processArgs.push("hello"); 
				nativeProcessStartupInfo.arguments = processArgs; 
				
			}
			
			process = new NativeProcess(); 
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}