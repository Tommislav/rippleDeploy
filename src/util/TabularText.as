/*
 * hexagonlib - Multi-Purpose ActionScript 3 Library.
 *       __    __
 *    __/  \__/  \__    __
 *   /  \__/HEXAGON \__/  \
 *   \__/  \__/  LIBRARY _/
 *            \__/  \__/
 *
 * Licensed under the MIT License
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package util
{
	/**
	 * Represents a list of strings which are seperated into columns. When creating a
	 * new TabularText you specify the number of columns that the TabularText should have
	 * and then you add as many strings as there are columns with the add() method. The
	 * TabularText class cares about adding spacing to any strings so that they can be
	 * easily read in a tabular format. A fixed width font is recommended for the use of
	 * the output. The toString() method returns the formatted text result.
	 */
	public final class TabularText
	{
		//-----------------------------------------------------------------------------------------
		// Properties
		//-----------------------------------------------------------------------------------------
		
		/**
		 * The width of a text line, in characters before the screen width is reached.
		 * This is used to automatically calculate the column width.
		 */
		private static var _lineWidth:int = 0;
		
		private var _columns:Vector.<Array>;
		private var _lengths:Vector.<int>;
		private var _div:String;
		private var _fill:String;
		private var _rowLeading:String;
		private var _colMaxLength:int;
		private var _width:int = 0;
		private var _sort:Boolean;
		private var _isSorted:Boolean;
		private var _hasHeader:Boolean = false;
		
		
		//-----------------------------------------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Creates a new TabularText instance.
		 * 
		 * @param columns the number of columns that the TabularText should have.
		 * @param sort If true the columns are alphabetically sorted.
		 * @param div The String that is used to divide columns visually. If null
		 *        a single whitespace will be used by default.
		 * @param fill An optional String that is used to fill whitespace between
		 *        columns. This string should only be 1 character long. If null a
		 *        whitespace is used as the fill.
		 * @param rowLeading Optional lead characters that any row should start with.
		 * @param colMaxLength If this value is larger than 0, columns will be cropped
		 *        at the length specified by this value. This can be used to prevent
		 *        very long column texts from wrapping to the next line.
		 * @param header An array of header items.
		 */
		public function TabularText(columns:int, sort:Boolean = false, div:String = null,
			fill:String = null, rowLeading:String = null, colMaxLength:int = 0, header:Array = null)
		{
			if (columns < 1) columns = 1;
			
			_div = div == null ? " " : div;
			_fill = fill == null ? " " : fill;
			_rowLeading = rowLeading == null ? "" : rowLeading;
			
			if (colMaxLength > 0) _colMaxLength = colMaxLength;
			else _colMaxLength = _lineWidth / columns;
			
			_sort = sort;
			_isSorted = false;
			
			_columns = new Vector.<Array>(columns, false);
			_lengths = new Vector.<int>(columns, true);
			
			for (var i:int = 0; i < columns; i++)
			{
				_columns[i] = [];
				_lengths[i] = 0;
			}
			
			if (header)
			{
				_hasHeader = true;
				add(header);
			}
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Adds a row of Strings to the TabularText.
		 * 
		 * @param row A row of strings to add. Every string is part of a column. If there
		 *            are more strings specified than the ColumnText has columns, they are
		 *            ignored.
		 */
		public function add(row:Array):void
		{
			var l:int = row.length;
			var i:int;
			
			if (l > _columns.length)
			{
				l = _columns.length;
			}
			
			for (i = 0; i < l; i++)
			{
				/* We don't store s w/ any rowLeading here yet because it would interfere
				 * with numeric sort, so it gets added instead in toString(). */
				//var s:String = ( i > 0 ? "" : _rowLeading) + row[i];
				//_columns[i].push("" + row[i]);
				var s:String = "" + row[i];
				
				/* Crop long texts if neccessary */
				if (_colMaxLength > 0 && s.length - 3 > _colMaxLength)
				{
					s = s.substr(0, _colMaxLength - 1) + "...";
				}
				
				_columns[i].push(s);
				
				if (s.length > _lengths[i])
				{
					_lengths[i] = s.length;
				}
			}
			_isSorted = false;
			
			/* Re-calculate width */
			_width = 0;
			i = -1;
			while (++i < _lengths.length) _width += _lengths[i];
			_width += _rowLeading.length + (_columns.length - 1) * _div.length;
		}

		
		/**
		 * Returns a String Representation of the TabularText.
		 * 
		 * @return A String Representation of the TabularText.
		 */
		public function toString():String
		{
			if (_sort && !_isSorted)
			{
				TabularText.sort(_columns, _hasHeader);
				_isSorted = true;
			}
			
			var result:String = "";
			var header:String = "";
			var cols:int = _columns.length;
			var rows:int = _columns[0].length;
			var c:int;
			var r:int;
			
			/* Process columns and add padding to strings */
			for (c = 0; c < cols; c++)
			{
				var col:Array = _columns[c];
				var maxLen:int = _lengths[c];
				
				for (r = 0; r < rows; r++)
				{
					var s:String = col[r];
					if (s.length < maxLen)
					{
						if (_hasHeader && r == 0) col[r] = TabularText.pad(s, maxLen, " ");
						else col[r] = TabularText.pad(s, maxLen, _fill);
					}
				}
			}
			
			/* Combine rows */
			for (r = 0; r < rows; r++)
			{
				var row:String = _rowLeading;
				for (c = 0; c < cols; c++)
				{
					row += _columns[c][r];
					/* Last column does not need a following divider */
					if (c < cols - 1)
					{
						row += _div;
					}
				}
				
				/* If we have a header we want a nice line dividing the header and the rest */
				if (_hasHeader && r == 0)
				{
					row += "\n" + _rowLeading;
					var i:int=  0;
					while (i++ < (_width - _rowLeading.length)) row += "-";
				}
				
				result += row + "\n";
			}
			
			return header + result;
		}
		
		
		/**
		 * Calculates the text line width for use with automatic column width calculation.
		 * 
		 * @param stageWidth
		 * @param charWidth
		 */
		public static function calculateLineWidth(stageWidth:int, charWidth:int):void
		{
			_lineWidth = stageWidth / charWidth;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		/**
		 * The text of the TabularText.
		 */
		public function get text():String
		{
			return toString();
		}
		
		
		/**
		 * The width of the TabularText, in characters. this value should only be checked
		 * after all rows have been added because the width can change depending on
		 * different row lengths.
		 */
		public function get width():int
		{
			return _width;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Private Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Neat little method that sorts all the arrays in _columns by using indices
		 * provided with Array.RETURNINDEXEDARRAY.
		 * @private
		 */
		private static function sort(columns:Vector.<Array>, hasHeader:Boolean):void
		{
			var c:int;
			var h:Array;
			
			/* If the text has headers we don't want those to be
			 * sorted so remove them temporarily! */
			if (hasHeader)
			{
				h = [];
				for (c = 0; c < columns.length; c++)
				{
					h.push(columns[c].shift());
				}
			}
			
			/* Check if first col only contains numbers - for NUMERIC sort */
			var idx:Array = columns[0];
			var sortType:uint = Array.NUMERIC;
			for each (var s:String in idx)
			{
				if (s.search(/\D+/g) > -1)
				{
					/* Column contains non-digits, can't be sorted by numbers! */
					sortType = Array.CASEINSENSITIVE;
					break;
				}
			}
			
			/* Sort the whole row caboodle ... */
			idx = columns[0].sort(Array.RETURNINDEXEDARRAY | sortType);
			for (c = 0; c < columns.length; c++)
			{
				var col:Array = columns[c];
				var tmp:Array = [];
				var l:int = col.length;
				for (var i:int = 0; i < l; i++)
				{
					tmp.push(col[idx[i]]);
				}
				columns[c] = tmp;
			}
			
			/* And add back headers if they were removed before */
			if (h)
			{
				for (c = 0; c < h.length; c++)
				{
					columns[c].unshift(h[c]);
				}
			}
		}
		
		
		/**
		 * Ultility method to add whitespace padding to the specified string.
		 * @private
		 */
		private static function pad(s:String, maxLen:int, fill:String):String
		{
			var l:int = maxLen - s.length;
			var i:int = 0;
			while (i++ < l) s += fill;
			return s;
		}
	}
}
