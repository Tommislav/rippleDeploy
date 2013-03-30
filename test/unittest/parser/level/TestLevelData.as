package unittest.parser.level 
{
	import flash.geom.Point;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import parser.level.Layer;
	import parser.level.LevelData;
	import parser.level.Tile;
	import parser.sheet.TileData;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestLevelData
	{
		private var _levelData:LevelData = FakeLevelData.getData();
		
		[Test]
		public function testLevelInfo():void
		{
			var LEVEL_INFO:String = "name=Name|bonusFee=50%|bonusFeeText=BFT|bgLoop=bg01|introText=some##intro##text!";
			assertThat( _levelData.levelInfo, equalTo(LEVEL_INFO) );
		}
		
		[Test]
		public function testStartPoint():void
		{
			var p:Point = new Point(123, 456);
			assertThat( _levelData.startPos.toString(), equalTo(p.toString()) );
		}
		
		[Test]
		public function testObjectLayer():void
		{
			assertThat( _levelData.layers.length, equalTo(2) );
			
			var objLayer:Layer = _levelData.layers[0];
			var oData:Object = {
				id:"objects", x:1, y:1, d:2, obj:true
			};
			validateObject(objLayer, oData );
			
			
		}
		
		[Test]
		public function testLayer():void
		{
			var layer:Layer = _levelData.layers[1];
			var data:Object = {
				id:"main", x:1, y:1, d:1, obj:false
			};	
			validateObject(layer, data);
		}
		
		
		[Test]
		public function testObjectLayerWidth():void
		{
			var layer:Layer = _levelData.layers[0];
			//assertThat(layer.width, equalTo(372)); // layer width is equal to the x-value of the rightmost tile
			assertThat(layer.width, equalTo(0)); // we don't know the width of the object layers...
		}
		
		[Test]
		public function testLayerWidth():void
		{
			var layer:Layer = _levelData.layers[1];
			assertThat(layer.width, equalTo(128)); // layer width is equal to the x-value of the rightmost tile
		}
		
		private function validateObject(obj:Object, prop:Object):void
		{
			for (var name:String in prop)
			{
				assertThat(obj, hasPropertyWithValue( name, prop[name] ) );
			}
		}
		
		
		
		
		
		[Test]
		public function testObjectTiles():void
		{
			var obj1:Tile = _levelData.layers[0].tiles[0];
			var obj2:Tile = _levelData.layers[0].tiles[1];
			
			var data1:Object = {
				id: 50, x: 372, y: 114, extra: "str=50"
			}
			var data2:Object = {
				id: 50, x: 10, y: 20, extra: ""
			}
			validateObject( obj1, data1 );
			validateObject( obj2, data2 );
		}
		
		[Test]
		public function testTiles():void
		{
			assertThat( _levelData.layers[1].tiles.length, equalTo(3) );
			
			var t:Tile = _levelData.layers[1].tiles[0];
			var data:Object = {
				id: 1,
				x: 7,
				y: 9,
				extra: ""
			};
			validateObject(t, data);
		}
	}

}