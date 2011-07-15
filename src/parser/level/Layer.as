package parser.level 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Layer 
	{
		public var id:String;
		public var x:int;
		public var y:int;
		public var d:int;
		public var obj:Boolean;
		public var tiles:Vector.<Tile> = new Vector.<Tile>();
		
		public var allTileIds:Vector.<String> = new Vector.<String>();
		
		public function Layer() 
		{
			
		}
		
	}

}