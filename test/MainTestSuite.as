package
{
	import unittest.parser.level.TestLevelData;
	import unittest.parser.sheet.TestSheetData;
	import unittest.parser.TestSheetOptimizer;
	import unittest.parser.util.TestUniqueifyList;
	
	/**
	 * This is the main testsuit where you can configure which sub-testsuits you want to run.
	 * @author Tommy Salomonsson
	 */
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]	
	public class MainTestSuite
	{
		
		public var d:DummyTest;
		public var UniqueifyList:TestUniqueifyList;
		public var testSheetData:TestSheetData;
		public var testLevelData:TestLevelData;
		public var testSheetOpt:TestSheetOptimizer;
		
		/* Examples!
		
		[Test]
		public function doTest():void
		{
			//org.flexunit.Assert;
			Assert.assertTrue(true);
		}
		
		[Test(async,timeout="900")]
		public function testEvent():void
		{
			// org.flexunit.async.Async
			Async.handleEvent( testCase(this), targetDispatcher, "eventName", eventHandler, timeout, passThroughObject, timeoutHandler );
		}
		
		private function eventHandler( e:Event, passthrough:Object ):void 
		{
			
		}
		
		
		
		
		*/
		
		
	}

}