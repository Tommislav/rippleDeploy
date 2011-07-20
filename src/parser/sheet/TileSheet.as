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
		
		
		public static function fromXml(xml:XML):TileSheet
		{
			var sheet:TileSheet = new TileSheet();
			sheet.id = xml.@id;
			sheet.type = (xml.@type == "tile") ? TYPE_TILE : TYPE_SPRITE;
			sheet.width = Number(xml.@w);
			sheet.height = Number(xml.@h);
			sheet.src = xml.@src;
			return sheet;
		}
		
		public function clone():TileSheet
		{
			var s:TileSheet = new TileSheet();
			s.id = this.id;
			s.type = this.type;
			s.width = this.width;
			s.height = this.height;
			s.src = this.src;
			return s;
		}
	}

}