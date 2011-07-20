package parser.sheet 
{
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Sound 
	{
		public var id:String;
		public var src:String;
		
		public static function fromXml(xml:XML):Sound
		{
			var s:Sound = new Sound();
			s.id = xml.@id;
			s.src = xml.@src;
			return s;
		}
		
		public function clone():Sound
		{
			var s:Sound = new Sound();
			s.id = this.id;
			s.src = this.src;
			return s;
		}
	}

}