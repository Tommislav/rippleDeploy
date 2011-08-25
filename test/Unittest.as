package  
{
	import com.boblu.test.LUContainer;
	import com.boblu.test.LURunner;
	import org.flexunit.runner.FlexUnitCore;
	/**
	 * ...
	 * @author Tommislav
	 */
	public class Unittest extends LUContainer
	{
		private var _core:FlexUnitCore;
		private var _runner:LURunner;
		private var _suites:Array;
		
		public function Unittest() 
		{
			
		}
		
		override protected function setup():void 
		{
			TestStageGetter.stage = stage;
		}
		
		override protected function start():void 
		{
			_core = new FlexUnitCore();
			_runner = new LURunner();
			
			_core.addListener( _runner );
			addChild( _runner );
			
			_core.run( MainTestSuite );
		}
	}

}