package parser.level 
{
	import parser.RippleFile;
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	import parser.sheet.TileData;
	import parser.sheet.TileSheet;
	/**
	 * Since it's really tricky to determine the width of a sprite, but the level demands it, we need to hax it a bit.
	 * I have extracted the haxy part into this file, leaving the rest more clean... hopefully
	 * @author Tommislav
	 */
	public class ObjectLayerWidthAdjustment 
	{
		private var _sheetId:String;
		private var _cachedSpriteWidth:Array = new Array();
		private var _adjustedLevelFiles:Array = new Array();
		private var _sheetData:SheetData;
		
		public function ObjectLayerWidthAdjustment() 
		{
			
		}
		
		public function adjust(sheetFile:RippleFile, levelFiles:Vector.<RippleFile>):void
		{
			if (sheetFile != null && sheetFile.fileName != _sheetId)
			{
				_sheetId = sheetFile.fileName;
				_cachedSpriteWidth = new Array();
				_sheetData = sheetFile.parsedData as SheetData;
				_adjustedLevelFiles = new Array();
			}
			
			for each (var levelFile:RippleFile in levelFiles)
			{
				if (_adjustedLevelFiles.indexOf(levelFile.fileName) > -1)
					continue;
				
				_adjustedLevelFiles.push(levelFile.fileName);
				var levelData:LevelData = levelFile.parsedData as LevelData;
				
				for each(var layer:Layer in levelData.layers)
				{
					if (layer.obj)
					{
						var objLayerWidth:Number = 0;
						for each(var tile:Tile in layer.tiles)
						{
							var right:Number = tile.x + getWidthFromSpriteId(tile.id);
							if (right >= objLayerWidth)
								objLayerWidth = right + 1;
						}
						layer.width = objLayerWidth;
					}
				}
			}
		}
		
		// complicated? hell yeah! =(
		private function getWidthFromSpriteId(id:String):Number
		{
			if (_cachedSpriteWidth[id] != null)
				return _cachedSpriteWidth[id];
			
			var sprite:Sprite = _sheetData.spriteById[id];
			var frame:Number = sprite.spriteStates[0].frames[0];
			var tiledata:TileData = _sheetData.tileDataById[frame];
			var tileSheet:TileSheet = _sheetData.tileSheetById[tiledata.sheetId];
			var width:int = Math.ceil(tileSheet.width / 16);
			
			_cachedSpriteWidth[id] = width;
			return width;
		}
		
	}

}