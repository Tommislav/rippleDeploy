package unittest.parser 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.sameInstance;
	import parser.level.LevelData;
	import parser.sheet.SheetData;
	import parser.sheet.Sprite;
	import parser.sheet.SpriteState;
	import parser.sheet.TileData;
	import parser.sheet.TileSheet;
	import parser.SheetOptimizer;
	import unittest.parser.level.FakeLevelData;
	import unittest.parser.sheet.FakeSheetData;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestSheetOptimizer
	{
		protected var _orgSheet:SheetData;
		protected var _optSheet:SheetData;
		
		[Before]
		public function setup():void
		{
			_orgSheet = FakeSheetData.getData();
			var level:LevelData = FakeLevelData.getData();
			_optSheet = SheetOptimizer.optimizeSheet(_orgSheet, new <LevelData>[level] );
		}
		
		[Test]
		public function testOptReturnsNewInstance():void
		{
			assertThat( _optSheet, not(sameInstance(_orgSheet)) );
		}
		
		[Test]
		public function testOptSounds():void
		{
			 //don't optimize sounds, should stay the same!
			assertThat(_optSheet.sound.length, equalTo(_orgSheet.sound.length));
		}
		
		[Test]
		public function testOptSprites():void
		{
			var optSprites:Array = new Array();
			for each( var s:Sprite in _optSheet.sprites )
				optSprites.push(s.id);
			
			assertThat(optSprites, hasItems("50"));
			assertThat(optSprites, arrayWithSize(1));
		}
		
		[Test]
		public function testOptSpriteStates():void
		{
			var s:Sprite = _optSheet.sprites[0];
			var states:Array = new Array();
			for each(var ss:SpriteState in s.spriteStates)
				states.push(ss.id);
			
			assertThat( states, hasItems("51", "52", "53", "54" ));
			assertThat( states.length, equalTo(4));
		}
		
		[Test]
		public function testOptTileData():void
		{
			// Extract all tiledata id:s from opt sheet into array
			var optTD:Array = new Array();
			for each(var td:TileData in _optSheet.tileData)
				optTD.push(td.id);
			
			assertThat("regular frames", optTD, hasItems("1", "2", "26"));
			assertThat("bouncer frames", optTD, hasItems("18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"));
			
			// And that should be all!
			assertThat(optTD, arrayWithSize(16));
		}
		
		[Test]
		public function testOptSheets():void
		{
			var sheets:Array = new Array();
			for each(var s:TileSheet in _optSheet.tileSheets)
				sheets.push(s.id);
			
			assertThat(sheets, array("1", "3"));
			//assertThat(sheets.length, equalTo(2));
		}
	}

}