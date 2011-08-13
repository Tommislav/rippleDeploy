package parser.writer 
{
	import parser.sheet.SheetData;
	import parser.sheet.Sound;
	/**
	 * replace [Sounds] with string data structure
	 * @author Tommy Salomonsson
	 */
	public class SoundWriter implements ISheetWriter
	{
		
		public function SoundWriter() 
		{
			
		}
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			s += "_sheet.sounds = {}\n";
			
			for each (var snd:Sound in data.sound)
				s += "_sheet.sounds['" + snd.id + "'] = ['" + snd.id + "',sound_" + snd.id +"]\n";
			
			return template.replace("[Sounds]", s);
		}
		
	}

}