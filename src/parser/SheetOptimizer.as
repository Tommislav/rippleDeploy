package parser 
{
	import flash.utils.getTimer;
	import parser.level.Layer;
	import parser.level.LevelData;
	import parser.level.Tile;
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	import parser.sheet.TileData;
	import parser.sheet.TileSheet;
	import parser.util.UniqueifyList;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class SheetOptimizer 
	{
		public static function optimizeSheet(sheet:SheetData, levels:Vector.<LevelData>):SheetData
		{
			var start:uint = getTimer();
			var optSheet:SheetData = sheet.clone();
			
			var opt:SheetOptimizer = new SheetOptimizer(optSheet);
			for each(var lvl:LevelData in levels)
			{
				opt.prepareDataFromLevel(lvl);
			}
			
			opt.optimizeSheet();
			
			trace("FIRST PASS TOOK " + (getTimer() - start) + " ms");
			return optSheet;
		}
		
		
		
		private var _usedTileSheets:Vector.<String>;
		private var _allLayerObjects:Vector.<String>;
		private var _sheet:SheetData;
		
		public function SheetOptimizer(sheet:SheetData)
		{
			_usedTileSheets = new Vector.<String>();
			_allLayerObjects = new Vector.<String>();
			_sheet = sheet;
		}
		
		/**
		 * Call this first for each level. Will get a list which tiles are used.
		 * @param	lv
		 */
		public function prepareDataFromLevel(lv:LevelData):void
		{
			var td:Vector.<String> = new Vector.<String>();
			for each(var layer:Layer in lv.layers)
			{
				UniqueifyList.getUnique(_allLayerObjects, layer.allTileIds);
			}
			trace("--- number of unique layer objects: " + _allLayerObjects.length + " (of "+ _sheet.tileData.length +")");
		}
		
		/**
		 * After having prepared data for all levels, we should have a list with all tiles that is
		 * used. From this list we can figure out which tileSheets to keep, and which to throw away.
		 */
		public function optimizeSheet():void
		{
			var allTileDatas:Vector.<TileData> = new Vector.<TileData>();
			var allSpriteDatas:Vector.<Sprite> = new Vector.<Sprite>();
			var allSpriteFrames:Vector.<String> = new Vector.<String>();
			for each( var id:String in _allLayerObjects )
			{
				var obj:Object = getTileDataOrSpriteDataFromId(id);
				
				if (obj is TileData)
					allTileDatas.push(TileData(obj));
				
				if (obj is Sprite)
				{
					allSpriteDatas.push(Sprite(obj));
					UniqueifyList.getUnique(allSpriteFrames, Sprite(obj).allFrames);
				}
			}
			
			// Get all tileDatas for the sprite frames!
			for each( var frame:String in allSpriteFrames )
			{
				allTileDatas.push(getTileDataOrSpriteDataFromId(frame));
			}
			
			trace("number of parsed frames: " + allSpriteFrames.length);
			
			// optimize tilesheets, remove the ones not used
			var allTileSheetIds:Vector.<String> = new Vector.<String>();
			for each(var td:TileData in allTileDatas)
			{
				UniqueifyList.getUnique(allTileSheetIds, [td.sheetId]);
			}
			
			var allTileSheets:Vector.<TileSheet> = new Vector.<TileSheet>();
			for each(var sheetId:String in allTileSheetIds)
			{
				for each(var orgSheet:TileSheet in _sheet.tileSheets)
				{
					if (orgSheet.id == sheetId)
					{
						allTileSheets.push(orgSheet);
						break;
					}
				}
			}
			
			_sheet.tileSheets = allTileSheets;
			_sheet.tileData = allTileDatas;
			_sheet.sprites = allSpriteDatas;
			
		}
		
		private function getTileDataOrSpriteDataFromId(id:String):Object
		{
			var td:Vector.<TileData> = _sheet.tileData;
			var sp:Vector.<Sprite> = _sheet.sprites;
			var i:int;
			var len:int = td.length;
			for (i = 0; i < len; i++ )
			{
				if (td[i].id == id)
					return td[i];
			}
			
			len = sp.length;
			for (i = 0; i < len; i++ )
			{
				if (sp[i].id == id)
					return sp[i];
			}
			throw new Error("Could not find TileData with id " + id + ", sure this sheet and level belongs together?");
		}
		
		private function getSheetFromTile():TileSheet
		{
			return null;
		}
	}

}