package unittest.parser.writer 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import parser.sheet.SheetData;
	import parser.sheet.TileData;
	import parser.writer.ISheetWriter;
	import parser.writer.TileDataWriter;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestTileDataWriter
	{
		[Test]
		public function testTileDataWriter():void
		{
			var tdw:TileDataWriter = new TileDataWriter();
			
			var data:SheetData = new SheetData();
			data.tileData = new <TileData>[
				newTileData("1", "2", 3, 4),
				newTileData("2", "3", 0, 0, [9, 8, 7, 6])];
			
			var exptected:String = "";
			exptected += "BEFORE";
			exptected += "_sheet.tileData = [];\n";
			exptected += "_sheet.tileData[1] = [1,2,3,4,'z'];\n";
			exptected += "_sheet.tileData[2] = [2,3,0,0,[9,8,7,6]];\n";
			exptected += "AFTER";
			
			var template:String = "BEFORE[TileData]AFTER";
			assertThat( tdw.write(template,data), equalTo(exptected) );
		}
		
		private function newTileData(id:String, sheet:String, x:int, y:int, p:Array = null):TileData
		{
			var td:TileData = new TileData();
			td.id = id;
			td.sheetId = sheet;
			td.x = x;
			td.y = y;
			td.prop = p;
			return td;
		}
	}

}