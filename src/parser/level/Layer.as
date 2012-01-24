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
		public var width:int;
		public var obj:Boolean;
		public var tiles:Vector.<Tile> = new Vector.<Tile>();
		
		public var allTileIds:Vector.<String> = new Vector.<String>();
		
		public static function fromXml(xml:XML):Layer
		{
			var lay:Layer = new Layer();
			lay.id = xml.@id;
			lay.x = parseInt(xml.@x);
			lay.y = parseInt(xml.@y);
			lay.d = parseInt(xml.@d);
			lay.width = 0;
			lay.obj = (xml.@obj == "true") ? true : false;
			
			var xmlTile:XMLList = xml.tile;
			for each( var t:XML in xmlTile )
			{
				var parsedTile:Tile = Tile.fromXml(t);
				
				// List all unique tile id:s
				if ( lay.allTileIds.indexOf(parsedTile.id) == -1)
					lay.allTileIds.push(parsedTile.id);
				
				lay.tiles.push(parsedTile);
				
				if (parsedTile.x > lay.width)
					lay.width = parsedTile.x;
			}
			return lay;
		}
		
		public function toString():String
		{
			return "Layer: " + this.id + ",  tiles: " + tiles.length + "  (unique "+ allTileIds.length +")";
		}
	}

}