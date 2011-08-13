package parser.writer 
{
	import parser.sheet.SheetData;
	import parser.sheet.Sound;
	/**
	 * Replace [EmbedSounds] with as code to embed sounds
	 * @author Tommy Salomonsson
	 */
	public class EmbedMp3Writer implements ISheetWriter
	{
		private var _projectDir:String;
		
		public function EmbedMp3Writer(projectDir:String) 
		{
			_projectDir = projectDir;
		}
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			
			for each (var snd:Sound in data.sound)
			{
				var className:String = "Sound_Class_" + snd.id;
				var soundName:String = "sound_" + snd.id;
				
				var src:String = _projectDir + "/" + snd.src;
				
				s += "[Embed(source='"+ src +"')]\n";
				s += "private var " + className +":Class;\n";
				s += "private var " + soundName + ":Sound = new " + className + "();\n\n";
			}
			
			return template.replace("[EmbedSounds]", s);
		}
		
	}

}