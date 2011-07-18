package parser.sheet 
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SheetData 
	{
		public var projectDir:String;
		public var tileSheets:Vector.<TileSheet> = new Vector.<TileSheet>();
		public var tileData:Vector.<TileData> = new Vector.<TileData>();
		public var sprites:Vector.<Sprite> = new Vector.<Sprite>();
		public var sound:Vector.<Sound> = new Vector.<Sound>();
		
		
		
		public static function fromXml(xml:XML):SheetData
		{
			var len:int;
			var i:int;
			
			var sheetData:SheetData = new SheetData();
			sheetData.projectDir = xml.project[0].@dir;
			
			var xmlTileSheets:XMLList = xml.tileSheets;
			for each(var sheet:XML in xmlTileSheets)
			{
				sheetData.tileSheets.push( TileSheet.fromXml(sheet) );
			}
			
			var xmlTileData:XMLList = xml.tileData;
			for each(var td:XML in xmlTileData)
			{
				sheetData.tileData.push( TileData.fromXml(td) );
			}
			
			var xmlSpriteData:XMLList = xml.sprite;
			for each(var sp:XML in xmlSpriteData)
			{
				sheetData.sprites.push( Sprite.fromXml(sp) );
			}
			
			var xmlSoundData:XMLList = xml.sound;
			for each(var snd:XML in xmlSoundData)
			{
				sheetData.sound.push(Sound.fromXml(snd));
			}
			
			return sheetData;
		}
		
		
		
		public function toString():String
		{
			return "Sheet XML, tileSheets("+tileSheets.length+"), tileData("+tileData.length+"), sprites("+sprites.length+"), sounds("+sound.length+")";
		}
	}

}