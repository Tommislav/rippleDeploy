package parser.log 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Tommislav
	 */
	public class LogEvent extends Event 
	{
		public static const MSG:String = "msg";
		
		public var msg:String="";
		public function LogEvent(type:String, msg:String) 
		{ 
			super(type, false, false);
			this.msg = msg;
		} 
		
		public override function clone():Event 
		{ 
			return new LogEvent(type, this.msg);
		} 
	}
}