package unittest.parser.writer 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import parser.sheet.SheetData;
	import parser.sheet.TileSheet;
	import parser.writer.EmbedTileSheetWriter;
	import parser.writer.ISheetWriter;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestEmbedTileSheetWriter
	{
		[Test]
		public function testWriteTileSheetImage():void
		{
			var expected:String = "";
			expected += "BEFORE";
			expected += "[Embed(source='proj ect/images/img1.png')]\n";
			expected += "private var Sheet_Class_1:Class;\n";
			expected += "private var sheet_1:BitmapData = new Sheet_Class_1().bitmapData;\n\n";
			expected += "AFTER";
			
			var projDir:String = "proj%20ect";
			var fakeSheet:TileSheet = new TileSheet();
			fakeSheet.id = "1";
			fakeSheet.src = "images/img1.png";
			
			var sheetData:SheetData = new SheetData();
			sheetData.projectDir = projDir;
			sheetData.tileSheets = new <TileSheet>[ fakeSheet ];
			
			var template:String = "BEFORE[EmbedTileSheets]AFTER";
			var writer:ISheetWriter = new EmbedTileSheetWriter();
			
			assertThat( writer.write(template, sheetData), equalTo(expected) );
		}
	}

}