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
		private var _allTileIds:Vector.<String>;
		private var _sheet:SheetData;
		
		public function SheetOptimizer(sheet:SheetData)
		{
			_usedTileSheets = new Vector.<String>();
			_allTileIds = new Vector.<String>();
			_sheet = sheet;
		}
		
		/**
		 * Call this first for each level. Will get a list which tiles are used.
		 * @param	lv
		 */
		public function prepareDataFromLevel(lv:LevelData):void
		{
			var i:int;
			var len:int;
			for each(var layer:Layer in lv.layers)
			{
				var layerTileIds:Vector.<String> = layer.allTileIds;
				
				len = layerTileIds.length;
				for (i = 0; i < len; i++ )
				{
					if ( _allTileIds.indexOf(layerTileIds[i]) == -1 )
						_allTileIds.push(layer.allTileIds[i]);
				}
			}
			trace("--- number of unique tiles: " + _allTileIds.length + " (of "+ _sheet.tileData.length +")");
		}
		
		/**
		 * After having prepared data for all levels, we should have a list with all tiles that is
		 * used. From this list we can figure out which tileSheets to keep, and which to throw away.
		 */
		public function optimizeSheet():void
		{
			var optimizedTileDatas:Vector.<TileData> = new Vector.<TileData>();
			var optimizedSpriteDatas:Vector.<Sprite> = new Vector.<Sprite>();
			var tempFrameIds:Vector.<String> = new Vector.<String>();
			for each( var id:String in _allTileIds )
			{
				var obj:Object = getTileDataOrSpriteDataFromId(id);
				
				if (obj is TileData)
					optimizedTileDatas.push(TileData(obj));
				
				if (obj is Sprite)
				{
					for each(var frameId:String in Sprite(obj).allFrames)
					{
						if (tempFrameIds.indexOf(frameId) == -1)
						{
							tempFrameIds.push(frameId);
							optimizedTileDatas.push(getTileDataOrSpriteDataFromId(frameId));
						}
					}
					optimizedSpriteDatas.push(Sprite(obj));
				}
				
			}
			trace("number of parsed frames: " + tempFrameIds.length);
			_sheet.tileData = optimizedTileDatas;
			_sheet.sprites = optimizedSpriteDatas;
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