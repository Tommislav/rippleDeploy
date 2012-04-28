package levelselectcompiler 
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	import parser.log.GlobalLogDispatcher;
	import parser.Parser;
	/**
	 * ...
	 * @author ...
	 */
	public class CallLater 
	{
		public static function parseNewFile(parser:Parser, file:File, delay:int):void
		{
			var cl:CallLater = new CallLater();
			cl._parser = parser;
			cl._file = file;
			cl.startTimer(delay, cl.parseFileAfterDelay);
		}
		
		public static function saveSilent(parser:Parser, projectPath:String, delay:int):void
		{
			var cl:CallLater = new CallLater();
			cl._parser = parser;
			cl._projectPath = projectPath;
			cl.startTimer(delay, cl.saveSilentAfterDelay);
		}
		
		public static function log(message:String, delay:int):void
		{
			var cl:CallLater = new CallLater();
			cl._message = message;
			cl.startTimer(delay, cl.logAfterDelay);
		}
		
		private var _timer:Timer;
		private var _parser:Parser;
		private var _file:File;
		private var _projectPath:String;
		private var _message:String;
		
		public function CallLater()
		{
			
		}
		
		
		private function startTimer(delay:int, handler:Function):void
		{
			_timer = new Timer(delay,1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handler);
			_timer.start()
		}
		
		private function parseFileAfterDelay(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, parseFileAfterDelay);
			_parser.newFile(_file);
			cleanup();
		}
		
		private function saveSilentAfterDelay(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, parseFileAfterDelay);
			_parser.silentSave(_projectPath);
			cleanup();
		}
		
		private function logAfterDelay(e:TimerEvent):void
		{
			GlobalLogDispatcher.log(_message);
		}
		
		private function cleanup():void 
		{
			_timer = null;
			_parser = null;
			_file = null;
			_projectPath = null;
		}
	}

}