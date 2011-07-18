package parser.sheet 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Sprite 
	{
		public var id:String;
		public var name:String;
		public var type:String;
		public var bb:Rectangle;
		public var p:Array;
		
		public var spriteStates:Vector.<SpriteState> = new Vector.<SpriteState>();
		
		public static function fromXml(xml:XML):Sprite
		{
			var s:Sprite = new Sprite();
			s.id = xml.@id;
			s.name = xml.@name;
			s.type = SpriteTypes.TYPE_SPRITE;
			s.bb = parseRect( xml.@bb );
			s.p = String(xml.@p).split(",");
			
			var spriteStates:XMLList = xml.sprite;
			for each( var state:XML in spriteStates )
			{
				s.spriteStates.push( SpriteState.fromXml(state) );
			}
			
			return s;
		}
		
		private static function parseRect(s:String):Rectangle
		{
			var dim:Array = s.split(",");
			return new Rectangle( Number(dim[0]), Number(dim[1]), Number(dim[2]), Number(dim[3]) );
		}
	}

}