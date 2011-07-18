package parser.sheet 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SpriteState 
	{
		public var id:String;
		public var name:String;
		public var type:String;
		public var p:Array = new Array();
		
		public var frames:Array = new Array();
		
		public static function fromXml(xml:XML):SpriteState
		{
			var state:SpriteState = new SpriteState();
			state.id = xml.@id;
			state.name = xml.@name;
			state.type = (xml.@type == "spriteState") ? SpriteTypes.TYPE_SPRITE_STATE : SpriteTypes.TYPE_ANIMATED_TILE;
			state.p = String(xml.@p).split(",");
			state.frames = getFrames(xml.frames);
			return state;
		}
		
		private static function getFrames( f:XMLList ):Array
		{
			if (f.length() > 0)
			{
				var frameString:String = f[0].@p;
				return frameString.split(",");
			}
			return [];
		}
		
	}

}