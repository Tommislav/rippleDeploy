package parser.sheet 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SpriteState 
	{
		public static const TYPE_SPRITE_STATE:String = "spriteStateState:SpriteState";
		public static const TYPE_ANIMATED_TILE:String = "spriteStateState:AnimatedTile";
		
		public var id:String;
		public var name:String;
		public var type:String;
		public var p:Array;
		
		public var frames:Array;
		
		public function SpriteState() 
		{
			
		}
		
	}

}