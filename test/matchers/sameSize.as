package matchers 
{
	import com.hm.video.player.dim.IDimension;
	import org.hamcrest.Matcher;
	
	/**
	 * Matches another Dimension object, or a DisplayObject.
	 */
	public function sameSize( dim:Object ):Matcher
	{
		return new DimensionMatcher( dim );
	}
}