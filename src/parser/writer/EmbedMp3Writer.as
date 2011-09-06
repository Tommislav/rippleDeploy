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
		
		public function EmbedMp3Writer() 
		{
		}
		
		/* INTERFACE parser.writer.ISheetWriter */
		
		public function write(template:String, data:SheetData):String
		{
			var s:String = "";
			
			for each (var snd:Sound in data.sound)
			{
				var className:String = "Sound_Class_" + snd.id;
				var soundName:String = "sound_" + snd.id;
				
				var src:String = data.projectDir + "/" + snd.src;
				src = src.replace(/\%20/g, " ");
				
				s += "[Embed(source='"+ src +"')]\n";
				s += "private var " + className +":Class;\n";
				s += "private var " + soundName + ":Sound = new " + className + "();\n\n";
			}
			
			return template.replace("[EmbedSounds]", s);
		}
		
	}

}