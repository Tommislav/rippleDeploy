package parser.sheet 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class TileData 
	{
		public var id:String;
		public var sheetId:String;
		public var x:int;
		public var y:int;
		public var prop:Array;
		
		public static function fromXml(xml:XML):TileData
		{
			var td:TileData = new TileData();
			td.id = xml.@id;
			td.sheetId = xml.@sheet;
			td.x = parseInt( xml.@x );
			td.y = parseInt( xml.@y );
			td.prop = String(xml.@prop).split(",");
			return td;
		}
		
		public function clone():TileData
		{
			var td:TileData = new TileData();
			td.id = this.id;
			td.x = this.x;
			td.y = this.y;
			td.prop = this.prop.slice();
			return td;
		}
	}

}