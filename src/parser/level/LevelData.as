package parser.level 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class LevelData 
	{
		public var levelInfo:String;
		public var startPos:Point = new Point();
		public var layers:Vector.<Layer> = new Vector.<Layer>();
		
		public function LevelData() 
		{
			
		}
		
	}

}