package parser.level 
{
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Layer 
	{
		public var id:String;
		public var x:Number;
		public var y:Number;
		public var d:Number;
		public var width:int;
		public var obj:Boolean;
		public var tiles:Vector.<Tile> = new Vector.<Tile>();
		
		public var allTileIds:Vector.<String> = new Vector.<String>();
		
		public static function fromXml(xml:XML):Layer
		{
			var lay:Layer = new Layer();
			lay.id = xml.@id;
			lay.x = Number(xml.@x);
			lay.y = Number(xml.@y);
			lay.d = Number(xml.@d);
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
				
				// determine width of layer, different for object or regular layers
				if (!lay.obj)
				{
					if (parsedTile.x >= lay.width)
						lay.width = parsedTile.x + 1;
				}
			}
			return lay;
		}
		
		
		public function toString():String
		{
			return "Layer: " + this.id + ",  tiles: " + tiles.length + "  (unique "+ allTileIds.length +") width: " + width;
		}
	}

}