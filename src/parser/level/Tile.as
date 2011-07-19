package parser.level 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Tile 
	{
		public var id:String;
		public var x:int;
		public var y:int;
		public var extra:String = "";
		
		public static function fromXml(xml:XML):Tile
		{
			var t:Tile = new Tile();
			
			var p:Array = String(xml.@p).split(",");
			t.id = p[0];
			t.x = parseInt(p[1]);
			t.y = parseInt(p[2]);
			
			if (xml.attribute("e").length() > 0)
				t.extra = xml.@e;
			
			return t;
		}
	}

}