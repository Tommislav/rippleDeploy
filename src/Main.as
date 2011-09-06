package 
{
	import com.bit101.components.IndicatorLight;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.desktop.NativeProcess;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import parser.Parser;
	import parser.RippleFile;
	import util.TabularText;
	
	/**
	 * ...
	 * @author Tommy Salomonsson
	 */
	public class Main extends Sprite 
	{
		private var _tf:TextField;
		private var _tab:TabularText;
		private var _rect:Sprite;
		
		private var _indicator:IndicatorLight;
		private var _optimizeBtn:PushButton;
		private var _saveBtn:PushButton;
		private var _resetBtn:PushButton;
		private var _info:TextArea;
		
		private var _txt:String = "";
		
		private var _parser:Parser;
		
		public function Main():void 
		{
			_parser = new Parser();
			
			var isSupported:Boolean = NativeDragManager.isSupported;
			_rect = new Sprite();
			_rect.graphics.beginFill(0xffffff, 1);
			_rect.graphics.drawRect(0, 0, 1000, 1000);
			_rect.graphics.endFill();
			addChild(_rect);
			
			
			_indicator = new IndicatorLight( this, 5, 10, 0x00ff00, "READY" );
			_optimizeBtn = new PushButton( this, 60, 5, "Optimize", optimize );
			_optimizeBtn.enabled = false;
			_saveBtn = new PushButton(this, 170, 5, "Save", save);
			_saveBtn.enabled = false;
			_resetBtn = new PushButton(this, 280, 5, "Reset", reset );
			
			_info = new TextArea( this, 5, 50, "" );
			_info.width = 700;
			_info.width = 400;
			
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.defaultTextFormat = new TextFormat("_typewriter");
			_tf.autoSize = "left";
			_tf.x = 5;
			_tf.y = 165;
			addChild( _tf );
			
			
			_rect.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnter );
			_rect.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP, onDragDrop );
			
			reset(null);
			
			var nativeProcessSupport:Boolean = NativeProcess.isSupported;
			log("Native process supported: " + nativeProcessSupport );
		}
		
		private function optimize(e:Event):void 
		{
			if (_parser.canOptimize())
			{
				log("OPTIMIZING...");
				log(_parser.optimize());
				_saveBtn.enabled = _parser.canSave();
			}
		}
		
		private function save(e:Event):void 
		{
			if (_parser.canSave())
			{
				log("SAVING...");
				_parser.save();
			}
		}
		
		private function reset(e:Event):void 
		{
			_parser.reset();
			
			showFiles();
			_indicator.isLit = false;
			_optimizeBtn.enabled = false;
			_saveBtn.enabled = false;
			_resetBtn.enabled = true;
			_txt = "";
			log("Start by dragging a sheet xml and at least one level xml");
		}
		
		private function onDragEnter(e:NativeDragEvent):void 
		{
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each(var f:File in files)
			{
				if (f.extension.toLowerCase() != "xml")
				{
					log("Invalid file, only *.xml allowed ("+f.name+")");
					return;
				}
			}
			NativeDragManager.acceptDragDrop(_rect);
		}
		
		private function onDragDrop(e:NativeDragEvent):void 
		{
			var files:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each(var f:File in files)
			{
				log(_parser.newFile(f));
			}
			showFiles();
		}
		
		private function showFiles():void
		{
			_tab = new TabularText(2, false, "| ", null, null, 0, ["FILE TYPE               ", "FILE NAME               "]);
			var data:Vector.<RippleFile> = _parser.getAllFiles();
			for ( var i:int = 0; i < data.length; i++ )
			{
				_tab.add([data[i].type, data[i].fileName]);
			}
			
			_tf.text = _tab.toString();
			
			_indicator.isLit = _parser.canOptimize();
			_optimizeBtn.enabled = _parser.canOptimize();
		}
		
		private function log(s:String):void
		{
			s = "> " + s;
			_txt = s + "\n" + _txt;
			_info.text = _txt;
		}
	}
}