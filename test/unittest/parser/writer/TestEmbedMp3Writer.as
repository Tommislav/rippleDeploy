package unittest.parser.writer 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import parser.sheet.SheetData;
	import parser.sheet.Sound;
	import parser.writer.EmbedMp3Writer;
	import parser.writer.ISheetWriter;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestEmbedMp3Writer
	{
		[Test]
		public function testEmbedMp3Writer():void
		{
			var projDir:String = "test";
			var mp3:EmbedMp3Writer = new EmbedMp3Writer(projDir);
			
			var data:SheetData = new SheetData();
			data.sound = new <Sound> [ newSound( "one", "one.mp3" ) ];
			
			var expedted:String = "";
			expedted += "BEFORE";
			expedted += "[Embed(source='test/one.mp3')]\n";
			expedted += "private var Sound_Class_one:Class;\n";
			expedted += "private var sound_one:Sound = new Sound_Class_one();\n\n";
			expedted += "AFTER";
			
			var template:String = "BEFORE[EmbedSounds]AFTER";
			assertThat( mp3.write(template, data), equalTo(expedted) );
		}
		
		private function newSound(id:String, src:String):Sound
		{
			var snd:Sound = new Sound();
			snd.id = id;
			snd.src = src;
			return snd;
		}
	}

}