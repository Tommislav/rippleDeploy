package parser 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import parser.log.GlobalLogDispatcher;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class CompileSwf 
	{
		private var _fileName:String;
		private var _process:NativeProcess;
		
		public function CompileSwf(asFileName:String) 
		{
			_fileName = asFileName;
		}
		
		public function execute():void
		{
			var nativeInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			
			// C:/Windows/System32/cmd.exe
			
			var pyScript:String = File.applicationDirectory.resolvePath("compile.py").nativePath;
			var batScript:String = File.applicationDirectory.resolvePath("compile.bat").nativePath;
			
			//var exe:File = new File("C:/Windows/System32/cmd.exe");
			var exe:File = new File("C:/Windows/System32/cmd.exe");
			nativeInfo.executable = exe;
			
			var toCompile:String = _fileName.replace("file:///", "");
			
			trace("bat script " + batScript);
			trace("Compile " + toCompile);
			var args:Vector.<String> = new <String> ["/c", batScript, toCompile];
			nativeInfo.arguments = args;
			
			_process = new NativeProcess();
			_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            _process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
            _process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
            _process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
            _process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
			
			_process.start( nativeInfo );
		}
		
		public function onOutputData(event:ProgressEvent):void
        {
			var s:String = _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable);
			//s = s.replace("\n" + "");
			GlobalLogDispatcher.log( "### " + s );
        }
        
        public function onErrorData(event:ProgressEvent):void
        {
			var s:String = _process.standardError.readUTFBytes(_process.standardError.bytesAvailable);
			GlobalLogDispatcher.log( "#ERROR# " + s );
        }
        
        public function onExit(event:NativeProcessExitEvent):void
        {
			var s:String = "#EXITCODE# " + event.exitCode;
            GlobalLogDispatcher.log("#EXIT# " + s );
        }
        
        public function onIOError(event:IOErrorEvent):void
        {
			GlobalLogDispatcher.log(event.toString());
            trace(event.toString());
        }
	}

}