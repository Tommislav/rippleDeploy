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
		public var animatedTiles:Vector.<SpriteState> = new Vector.<SpriteState>();
		public var sound:Vector.<Sound> = new Vector.<Sound>();
		
		
		
		public static function fromXml(xml:XML):SheetData
		{
			var len:int;
			var i:int;
			
			var sheetData:SheetData = new SheetData();
			
			// remove any trailing "/" or "\" from projectDir to avoid "//"
			var projectDir:String = xml.project[0].@dir;
			if (projectDir.lastIndexOf("/") == projectDir.length - 1 || projectDir.lastIndexOf("\\") == projectDir.length - 1)
				projectDir = projectDir.substr(0, projectDir.length - 1);
			
			sheetData.projectDir = projectDir;
			
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
			
			var animTiles:XMLList = xml.sprite.sprite.(@type == "animatedTile");
			for each(var anim:XML in animTiles)
			{
				sheetData.animatedTiles.push( SpriteState.fromXml(anim) );
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
			return "Sheet XML, tileSheets("+tileSheets.length+"), tileData("+tileData.length+"), sprites("+sprites.length+"), animTiles("+animatedTiles.length+"), sounds("+sound.length+")";
		}
		
		public function clone():SheetData
		{
			var sd:SheetData = new SheetData();
			sd.projectDir = this.projectDir;
			var i:int;
			
			for (i = 0; i < tileSheets.length; i++ )
				sd.tileSheets.push(this.tileSheets[i].clone());
			
			for (i = 0; i < tileData.length; i++ )
				sd.tileData.push(this.tileData[i].clone());
			
			for (i = 0; i < sprites.length; i++ )
				sd.sprites.push(this.sprites[i].clone());
			
			for (i = 0; i < animatedTiles.length; i++ )
				sd.animatedTiles.push(this.animatedTiles[i].clone());
			
			for (i = 0; i < sound.length; i++ )
				sd.sound.push(this.sound[i].clone());
			
			return sd;
		}
	}

}