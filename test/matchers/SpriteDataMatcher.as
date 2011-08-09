package matchers 
{
	import org.hamcrest.BaseMatcher;
	import org.hamcrest.CustomMatcher;
	import org.hamcrest.Description;
	import parser.sheet.Sprite;
	
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class SpriteDataMatcher extends BaseMatcher
	{
		private var errorTest:String;
		
		public function SpriteDataMatcher() 
		{
			super();
		}
		
		override public function describeMismatch(item:Object, mismatchDescription:Description):void 
		{
			
		}
		
		override public function matches(item:Object):Boolean 
		{
			var sData:Sprite;
			
			return false;
		}
	}

}