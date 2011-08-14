package
{
	import unittest.parser.level.TestLevelData;
	import unittest.parser.sheet.TestSheetData;
	import unittest.parser.TestSheetOptimizer;
	import unittest.parser.util.TestUniqueifyList;
	import unittest.parser.writer.TestEmbedMp3Writer;
	import unittest.parser.writer.TestEmbedTileSheetWriter;
	import unittest.parser.writer.TestLevelWriter;
	import unittest.parser.writer.TestSheetWriter;
	import unittest.parser.writer.TestSoundWriter;
	import unittest.parser.writer.TestSpriteDataWriter;
	import unittest.parser.writer.TestTileDataWriter;
	
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
		
		// output writers
		public var tileSheetImageWriterTest:TestEmbedTileSheetWriter;
		public var testSheetWriter:TestSheetWriter;
		public var tdWriter:TestTileDataWriter;
		public var embedSoundWriter:TestEmbedMp3Writer;
		public var sndWriter:TestSoundWriter;
		public var spriteWriter:TestSpriteDataWriter;
		
		public var levelWriter:TestLevelWriter;
		
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