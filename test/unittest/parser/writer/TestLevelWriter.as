package unittest.parser.writer 
{
	import flash.geom.Point;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.text.containsString;
	import parser.level.Layer;
	import parser.level.LevelData;
	import parser.level.Tile;
	import parser.writer.LevelWriter;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestLevelWriter
	{
		private var _writer:LevelWriter;
		private var _data:LevelData;
		
		[Before]
		public function setup():void
		{
			_writer = new LevelWriter();
			_data = new LevelData();
			_data.levelInfo = "prop=val";
			_data.startPos = new Point(10, 20);
		}
		
		[Test]
		public function testBasicLevelWriter():void
		{
			var NAME:String = "level.xml";
			var expected:String = "BEFORE*_levels['level']={name:'level',levelInfo:'prop=val',startPos:[10,20],titlecards:[title01_0,title02_0,titleNum_0],layers:[]}\n*AFTER";
			assertThat( _writer.write("BEFORE*[Level]*AFTER", _data, NAME ), equalTo(expected) );
		}
		
		[Test]
		public function testTileLayer():void
		{
			var lay:Layer = newLayer("lay1", 1, 2, 3, false);
			lay.tiles.push( newTile( "1", 10, 20 ) );
			lay.tiles.push( newTile( "2", 40, 50 ) );
			lay.width = 1234;
			_data.layers.push(lay);
			
			var subStr:String = "[\n{id:'lay1',pos:[1,2,3],obj:false,width:1234,t:[[1,10,20],[2,40,50]]}\n]";
			assertThat( _writer.write("[Level]", _data, ""), containsString(subStr) );
		}
		
		[Test]
		public function testObjectLayer():void
		{
			var lay:Layer = newLayer("obj", 0, 0, 0, true);
			lay.tiles.push( newTile( "1", 10, 20, "str=10" ) );
			lay.tiles.push( newTile( "2", 64, 64 ) );
			lay.width = 64;
			_data.layers.push(lay);
			
			var subStr:String = "[\n{id:'obj',pos:[0,0,0],obj:true,width:64,t:[[1,10,20,\"str=10\"],[2,64,64]]}\n]";
			assertThat( _writer.write("[Level]", _data, ""), containsString(subStr) );
		}
		
		private function newLayer(id:String, x:int, y:int, d:int, obj:Boolean):Layer
		{
			var lay:Layer = new Layer();
			lay.id = id;
			lay.x = x;
			lay.y = y;
			lay.d = d;
			lay.obj = obj;
			return lay;
		}
		
		private function newTile(id:String, x:int, y:int, extra:String=""):Tile
		{
			var t:Tile = new Tile();
			t.id = id;
			t.x = x;
			t.y = y;
			t.extra = extra;
			return t;
		}
	}

}