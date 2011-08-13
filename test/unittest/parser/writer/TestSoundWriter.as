package unittest.parser.writer 
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import parser.sheet.SheetData;
	import parser.sheet.Sound;
	import parser.writer.SoundWriter;
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class TestSoundWriter
	{
		[Test]
		public function testSoundWriter():void 
		{
			var sndWriter:SoundWriter = new SoundWriter();
			
			var data:SheetData = new SheetData();
			data.sound = new <Sound> [
				newSound("one", "one.mp3"),
				newSound("two", "two.mp3")
			];
			
			var expected:String = "";
			expected += "BEFORE";
			expected += "_sheet.sounds = {}\n";
			expected += "_sheet.sounds['one'] = ['one',sound_one]\n";
			expected += "_sheet.sounds['two'] = ['two',sound_two]\n";
			expected += "AFTER";
			
			var template:String = "BEFORE[Sounds]AFTER";
			
			assertThat( sndWriter.write(template, data), equalTo(expected) );
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