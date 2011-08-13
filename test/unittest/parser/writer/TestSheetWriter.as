package unittest.parser.writer 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import parser.sheet.SheetData;
	import parser.sheet.TileSheet;
	import parser.writer.ISheetWriter;
	import parser.writer.TileSheetWriter;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestSheetWriter
	{
		[Test]
		public function testSheetWriter():void
		{
			var exptected:String = "";
			exptected += "BEFORE";
			exptected += "_sheet.tileSheets = {}\n";
			exptected += "_sheet.tileSheets[1] = [1,sheet_1,T,10,20]\n";
			exptected += "AFTER";
			
			var sheet:TileSheet = new TileSheet();
			sheet.id = "1";
			sheet.src = "src";
			sheet.type = TileSheet.TYPE_TILE;
			sheet.width = 10;
			sheet.height = 20;
			
			var data:SheetData = new SheetData();
			data.tileSheets = new <TileSheet>[sheet];
			
			var template:String = "BEFORE[TileSheets]AFTER";
			var writer:ISheetWriter = new TileSheetWriter();
			assertThat( writer.write(template, data), equalTo(exptected) );
		}
	}

}