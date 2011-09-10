package parser.log 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class GlobalLogDispatcher 
	{
		public static var logDispatcher:EventDispatcher = new EventDispatcher();
		public static function log(s:String):void
		{
			logDispatcher.dispatchEvent( new LogEvent( LogEvent.MSG, s ) );
		}
		
	}

}