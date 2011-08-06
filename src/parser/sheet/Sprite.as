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
		public var allFrames:Vector.<String> = new Vector.<String>();
		
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
				var ss:SpriteState = SpriteState.fromXml(state);
				var frames:Vector.<String> = ( getUniqueFrames( ss ) );
				
				for each(var f:String in frames)
				{
					if (s.allFrames.indexOf(f) == -1)
						s.allFrames.push(f);
				}
				
				s.spriteStates.push( ss );
			}
			
			return s;
		}
		
		private static function parseRect(s:String):Rectangle
		{
			var dim:Array = s.split(",");
			return new Rectangle( Number(dim[0]), Number(dim[1]), Number(dim[2]), Number(dim[3]) );
		}
		
		private static function getUniqueFrames(ss:SpriteState):Vector.<String>
		{
			var v:Vector.<String> = new Vector.<String>();
			for each(var id:String in ss.frames)
			{
				if (v.indexOf(id) == -1)
					v.push(id);
			}
			return v;
		}
		
		public function clone():Sprite
		{
			var s:Sprite = new Sprite();
			s.id = this.id;
			s.name = this.name;
			s.type = this.type;
			s.bb = this.bb.clone();
			s.p = this.p.slice();
			
			for (var i:int = 0; i < spriteStates.length; i++ )
			{
				s.spriteStates.push(spriteStates[i].clone());
			}
			
			return s;
		}
	}

}