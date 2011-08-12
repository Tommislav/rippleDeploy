package unittest.parser.sheet
{
	import flash.geom.Rectangle;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.sameInstance;
	import parser.sheet.SheetData;
	import parser.sheet.Sound;
	import parser.sheet.Sprite;
	import parser.sheet.SpriteState;
	import parser.sheet.SpriteTypes;
	import parser.sheet.TileData;
	import parser.sheet.TileSheet;
	
	public class TestSheetData
	{
		private var _sheetData:SheetData = FakeSheetData.getData();
		
		private function get ZERO_PROP_ARRAY():Array { return [ "0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0" ]; }
		
		[Test]
		public function testSheetBasics():void
		{
			var NUM_TILESHEETS:int = 4;
			var NUM_TILEDATA:int = 46;
			var NUM_SPRITES:int = 2;
			var NUM_SOUNDS:int = 3;
			
			assertThat( _sheetData, notNullValue() );
			assertThat( _sheetData.projectDir, "file:///path/to/project" );
			
			assertThat( _sheetData.tileSheets.length, 	NUM_TILESHEETS );
			assertThat( _sheetData.tileData.length, 	NUM_TILEDATA );
			assertThat( _sheetData.sprites.length, 		NUM_SPRITES );
			assertThat( _sheetData.sound.length, 		NUM_SOUNDS );
		}
		
		// --------------------------------------
		// TEST TILESHEET
		// --------------------------------------
		
		[Test]
		public function testParsedTilesheet():void
		{
			var tilesheet:TileSheet = _sheetData.tileSheets[0];
			var spritesheet:TileSheet = _sheetData.tileSheets[2];
			
			assertThat( spritesheet.type, TileSheet.TYPE_SPRITE );
			assertThat( tilesheet.type, TileSheet.TYPE_TILE );
			
			// test properties
			testValidTilesheet( tilesheet );
			
			// test clone
			var t2:TileSheet = tilesheet.clone();
			testValidTilesheet( t2 );
		}
		
		private function testValidTilesheet(tilesheet:TileSheet):void
		{
			// test the rest of tilesheet properties
			assertThat(tilesheet.id, "1");
			assertThat(tilesheet.src, "tilesheet1.png" );
			assertThat(tilesheet.width, 64 );
			assertThat(tilesheet.height, 64 );
		}
		
		
		// --------------------------------------
		// TEST TILEDATA
		// --------------------------------------
		
		[Test]
		public function testTileData():void
		{
			var firstTileData:TileData = _sheetData.tileData[0];
			var data:Object = {
				id: "1",	sheetId: "1", x:"0", y:"0",
				prop: ZERO_PROP_ARRAY
			};
			validateTileData( firstTileData, data );
		}
		
		[Test]
		public function testCloneTileData():void
		{
			var specialTileData:TileData;
			for (var i:int = 0; i < _sheetData.tileData.length; i++ )
			{
				if (_sheetData.tileData[i].id == "9")
				{
					specialTileData = _sheetData.tileData[i];
					break;
				}
			}
			var data:Object = {
				id: "9",	sheetId: "2", x:"1", y:"0",
				prop: ["0", "0", "0", "0", "0", "0", "0", "0", "289", "0", "0", "0", "1", "417", "353", "289"]
			};
			
			var clonedTileData:TileData = specialTileData.clone();
			specialTileData.sheetId = "";
			validateTileData(clonedTileData, data );
		}
		
		private function validateTileData( td:TileData, properties:Object ):void
		{
			assertThat( td, notNullValue() );
			for(var name:String in properties)
			{
				assertThat( td, hasPropertyWithValue( name, properties[name] ) );
			}
		}
		
		
		// --------------------------------------
		// TEST SPRITES AND SPRITE STATES
		// --------------------------------------
		
		[Test]
		public function testSpriteWithStates():void
		{
			var sp:Sprite = _sheetData.sprites[0];
			validateSpriteWithDefaultValues(sp);
		}
		
		[Test]
		public function testCloneSprite():void
		{
			var sp:Sprite = _sheetData.sprites[0];
			var clonedSprite:Sprite = sp.clone();
			
			validateSpriteWithDefaultValues( clonedSprite );
			assertThat(clonedSprite, not(sameInstance(sp)));
			assertThat(clonedSprite.spriteStates[0], not(sameInstance(sp.spriteStates[0])));
		}
		
		private function validateSpriteWithDefaultValues(sp:Sprite):void
		{
			var spriteData:Object = {
				id: "50", name: "bounce01", type: SpriteTypes.TYPE_SPRITE,
				bb: new Rectangle(16, 16, 32, 32), 
				p: ["str=20|dir=0|inact=100|sfxcoll=bounce","4", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0" ,"0", "0"],
				allFrames: new <String>["18","19","20","21","22","23","24","25","26","27","28","29","30"]
			};
			var state1:Object = {
				id: "51", name: "act", type: SpriteTypes.TYPE_SPRITE_STATE,
				p: ZERO_PROP_ARRAY,
				frames: [18,18,19,19,20,20,21,21]
			};
			var state2:Object = {
				id: "52", name: "coll", type: SpriteTypes.TYPE_SPRITE_STATE,
				p: ZERO_PROP_ARRAY,
				frames: [21,22,23,24,24,23,22,21]
			};
			var state3:Object = {
				id: "53", name: "inact", type: SpriteTypes.TYPE_SPRITE_STATE,
				p: ZERO_PROP_ARRAY,
				frames: [25]
			};
			var state4:Object = {
				id: "54", name: "toact", type:SpriteTypes.TYPE_SPRITE_STATE,
				p: ZERO_PROP_ARRAY,
				frames: [26,27,28,29,30]
			}
			
			validateSprite( sp, spriteData, [state1, state2, state3, state4] );
		}
		
		private function validateSprite( s:Sprite, prop:Object, stateProp:Array ):void
		{
			assertThat(s, notNullValue());
			for (var name:String in prop)
			{
				if ( name == "bb" )
					assertThat(s.bb.toString(), equalTo(prop.bb.toString()));
				else if (name == "allFrames")
					assertThat( "allFrames", s.allFrames.join(","), equalTo(prop.allFrames.join(",")) );
				else
					assertThat( s, hasPropertyWithValue( name, prop[name] ) );
			}
			
			for (var i:int = 0; i < s.spriteStates.length; i++)
			{
				var state:SpriteState = s.spriteStates[i];
				var data:Object = stateProp[i];
				var label:String = "state " + i;
				assertThat( label, data, notNullValue() );
				
				for (var sName:String in data)
					assertThat( label + ":" + sName, state, hasPropertyWithValue( sName, data[sName] ) );
			}
		}
		
		
		// --------------------------------------
		// TEST SOUNDS
		// --------------------------------------
		
		[Test]
		public function testSounds():void
		{
			validateSoundVector( _sheetData );
		}
		
		[Test]
		public function testCloneSounds():void
		{
			var cloneSheet:SheetData = _sheetData.clone();
			validateSoundVector( cloneSheet );
			
			assertThat( cloneSheet.sound, not(sameInstance(_sheetData.sound)) );
		}
		
		private function validateSoundVector(sheetData:SheetData):void
		{
			var SOUNDS:Vector.<Sound> = new <Sound>[
				newSound("bg01", "snd_01.mp3"),
				newSound("bg02", "snd_02.mp3"),
				newSound("bg03", "snd_03.mp3")
			];
			
			for (var i:int = 0; i < sheetData.sound.length; i++ )
			{
				assertThat( sheetData.sound[i].toString(), equalTo(SOUNDS[i].toString() ) );
			}
		}
		
		private function newSound(id:String, src:String):Sound
		{
			var s:Sound = new Sound();
			s.id = id;
			s.src = src;
			return s;
		}
	}
	
	
}