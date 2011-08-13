package parser.writer 
{
	import parser.level.LevelData;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public interface ILevelWriter 
	{
		function write(template:String, data:LevelData):String;
	}
	
}