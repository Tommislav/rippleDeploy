package parser.sheet 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class TileSheet 
	{
		public static const TYPE_TILE:String = "tilesheetType:tile";
		public static const TYPE_SPRITE:String = "tilesheetType:sprite";
		
		public var id:String;
		public var type:String;
		public var width:Number;
		public var height:Number;
		public var src:String;
		
		public function TileSheet() 
		{
			
		}
		
	}

}