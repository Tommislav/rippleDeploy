package matchers 
{
	import com.hm.video.player.dim.IDimension;
	import flash.display.DisplayObject;
	import org.hamcrest.BaseMatcher;
	import org.hamcrest.Description;
	import org.hamcrest.Matcher;
	
	/**
	 * Hamcrest-matcher that will return true if two IDimension-objects are of
	 * equal size. Also matches a displayObject against a Dimension.
	 * @author Tommislav
	 */
	public class DimensionMatcher extends BaseMatcher 
	{
		private var _dim:Object;
		
		public function DimensionMatcher(dim:Object) 
		{
			validateObjectAndThrow( dim );
			_dim = dim;
		}
		
		override public function matches(item:Object):Boolean 
		{
			var disp:DisplayObject = item as DisplayObject;
			if (disp != null)
				return matchDisplayObject( disp );
			
			validateObjectAndThrow( item );
			return matchDimenstion( item );
		}
		
		override public function describeMismatch(item:Object, mismatchDescription:Description):void 
		{
			mismatchDescription.appendText("but size was " + item.x + ", " + item.y + ", " + item.width + ", " + item.height );
		}
		
		override public function describeTo(description:Description):void 
		{
			description.appendText("Expected size " + _dim.x + ", " + _dim.y + ", " + _dim.width + ", " + _dim.height );
		}
		
		
		
		
		private function matchDimenstion( dim2:Object ):Boolean
		{
			return( _dim.x == dim2.x && _dim.y == dim2.y && _dim.width == dim2.width && _dim.height == dim2.height );
		}
		
		private function matchDisplayObject( disp:DisplayObject ):Boolean
		{
			return( _dim.x == disp.x && _dim.y == disp.y && _dim.width == disp.width && _dim.height == disp.height );
		}
		
		private function validateObjectAndThrow(o:Object):void
		{
			
			var x:Number = o.x;
			var y:Number = o.y;
			var w:Number = o.width;
			var h:Number = o.height;
			
			if (isNaN(x + y + w + h))
				throw new Error("Object to match dimension on is not valid, missing x,y,width or height");
		}
	}

}