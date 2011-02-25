package collections
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;
	
	/**
	 * A base sequence implementation that provides a scaffolding for more specific types 
	 * of sequences. This class delegates the insertion, retrieval, search and removal to 
	 * its sub-classes. As such, when implementing an immutalbe sequence, developers must 
	 * override and implement the following methods:
	 * 
	 * <ul>
	 * <li><code>Sequence.at()</code></li>
	 * <li><code>Sequence.toArray()</code></li>
	 * <li><code>Sequence.length</code></li>
	 * </ul>
	 * 
	 * When implementing a mutable sequence, the following methods must also be implemented:
	 * 
	 * <ul>
	 * <li><code>Sequence.addAt()</code></li>
	 * <li><code>Sequence.removeAt()</code></li>
	 * </ul>
	 * 
	 * <p>
	 * Sub-classes may also override the <code>indexOf()</code> method. A default 
	 * implementation is provided that relies on <code>toArray()</code>, but a more
	 * effecient operation should be performed if possible. When overriding this method,
	 * <code>areElementsEqual()</code> can be used for element equality.
	 * </p>
	 * 
	 * <p>
	 * Sequences that extend from this class also support the retrieval and insertion
	 * of elements through the array access operator <code>[]</code>. Passing in an
	 * object that cannot be interpreted as an integer will throw an error. In addition,
	 * passing in an index that is either less than 0, or greater than the length of the
	 * sequence will cause a <code>RangeError</code>.
	 * </p>
	 * 
	 * <p>
	 * <strong>Example:</strong> Using the array access operators.
	 * 
	 * <listing version="3.0">
	 * var sequence:ArraySequence = new ArraySequence();
	 * sequence[0] = "a";
	 * trace(sequence[0]); // a
	 * 
	 * trace(0 in sequence); // true
	 * trace(1 in sequence); // false
	 * 
	 * delete sequence[0];
	 * trace(sequence.length); // 0
	 * </listing>
	 * </p>
	 * 
	 * @see collections.ArraySequence
	 * @see collections.Collection#areElementsEqual()
	 * 
	 * @author Dan Schultz
	 */
	public class Sequence extends Collection implements ISequence
	{
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function Sequence(items:Object = null)
		{
			super(items);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add(item:Object):Boolean
		{
			var oldLength:int = length;
			addAt(item, length);
			return oldLength != length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAllAt(items:Object, index:int):void
		{
			for each (var item:Object in items) {
				addAt(item, index++);
			}
		}
		
		/**
		 * Adds the given element to this sequence at the given index.
		 * 
		 * @param item The element to add.
		 * @param index The index to add the element at.
		 * @throws RangeError If <code>(index < 0 || index > length)</code>
		 */
		public function addAt(item:Object, index:int):void
		{
			
		}
		
		/**
		 * Returns the element of this sequence that is stored at the given index.
		 * If the index is less than 0 or is greater than or equal to the size of 
		 * the sequence, a <code>RangeError</code> is thrown.
		 * 
		 * @param index The position of the item to return.
		 * @return The item at the given position.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	or equal to the size of the sequence.
		 */
		public function at(index:int):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(item:Object):Boolean
		{
			return indexOf(item) != -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function equals(collection:ICollection):Boolean
		{
			if (this == collection) {
				return true;
			}
			
			if (collection is Sequence && length == collection.length) {
				var items1:Array = toArray();
				var items2:Array = collection.toArray();
				var len:int = length;
				for (var i:int = 0; i < len; i++) {
					if (!areElementsEqual(items1[i], items2[i])) {
						return false;
					}
				}
				return true;
			}
			
			return false;
		}
		
		/**
		 * Returns the first <code>n</code> elements from this sequence. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the sequence is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		public function first(count:int = 1):*
		{
			if (!isEmpty) {
				return count == 1 ? at(0) : slice(0, count).toArray();
			}
			return undefined;
		}
		
		/**
		 * Searches for the first occurrence in this sequence of the given element. This
		 * method check if the given element has an <code>equals()</code> method. If
		 * so, it will attempt to use this method to see if two objects are equal.
		 * 
		 * @param item The element to get the index of.
		 * @return The index of the first occurrence of the element. If the element is
		 * 	not found, <code>-1</code> is returned.
		 */
		public function indexOf(item:Object):int
		{
			var count:int = 0;
			for each (var element:Object in this) {
				if (areElementsEqual(element, item)) {
					return count;
				}
				count++;
			}
			return -1;
		}
		
		/**
		 * Returns the last <code>n</code> elements from this sequence. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the sequence is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		public function last(count:int = 1):*
		{
			if (!isEmpty) {
				return count == 1 ? at(length-1) : slice(length-count < 0 ? 0 : length-count, length).toArray();
			}
			return undefined;
		}
		
		/**
		 * Removes and returns the last element in the sequence. If the sequence is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The last element in the sequence, or <code>undefined</code>.
		 */
		public function pop():*
		{
			return isEmpty ? undefined : removeAt(length-1);
		}
		
		/**
		 * Returns a new sequence that contains the elements from this sequence between
		 * the starting index (inclusive) and the ending index (exclusive).
		 * 
		 * @param start The starting index. If a negative number, the starting 
		 * 	point begins at the end of the sequence, where -1 is the last element.
		 * @param end The ending index. If you omit this parameter, the range 
		 * 	includes all elements from the starting point to the end of the sequence. 
		 * 	If the index is a negative number, the ending point is specified from 
		 * 	the end of the sequence, where -1 is the last element.
		 * @return A new sequence.
		 */
		public function slice(start:int, end:int = int.MAX_VALUE):ISequence
		{
			return new ArraySequence(toArray().slice(start, end));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item:Object):Boolean
		{
			var index:int = indexOf(item);
			if (index != -1) {
				removeAt(index);
				remove(item);
				return true;
			}
			return false;
		}
		
		/**
		 * Removes the element of this sequence that is stored at the given position.
		 * 
		 * @param index The position of the item to remove.
		 * @return The object removed.
		 * @throws RangeError If <code>(index < 0 || index >= length)</code>
		 */
		public function removeAt(index:int):*
		{
			return undefined;
		}
		
		/**
		 * Replaces an element at the given position with the specified element. If
		 * the index is the size of the sequence, the element is added to the end of the
		 * sequence and <code>undefined</code> is returned.
		 * 
		 * @param item The new item.
		 * @param index The position of the item to replace.
		 * @return The element that was replaced.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	the size of the sequence.
		 */
		public function setItemAt(item:Object, index:int):*
		{
			if (index < 0 || index > length) {
				throw new RangeError("Cannot set element at index " + index);
			}
			
			var oldItem:*;
			if (index < length) {
				oldItem = removeAt(index);
			}
			
			addAt(item, index);
			return oldItem;
		}
		
		/**
		 * Removes and returns the first element in the sequence. If the sequence is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The first element in the sequence, or <code>undefined</code>.
		 */
		public function shift():*
		{
			return isEmpty ? undefined : removeAt(0);
		}
		
		/**
		 * Returns a new sequence that is sorted according to the given function. This
		 * function should have the following signature: 
		 * <code>function comparator(a:Object, b:Object):int</code>. If the returned
		 * integer is negative, then <code>a</code> preceeds <code>b</code>. If the
		 * returned integer is 0, then <code>a</code> has the same sort order as
		 * <code>b</code>. If positive, then <code>a</code> appears after <code>b</code>. 
		 * 
		 * @param comparator The comparator function.
		 * @return A new sorted sequence.
		 */
		public function sort(comparator:Function):ISequence
		{
			return new ArraySequence(toArray().sort(comparator));
		}
		
		/**
		 * @inheritDoc
		 */
		public function where(block:Function):ISequence
		{
			return new ArraySequence(toArray().filter(function(element:Object, index:int, array:Array):Boolean
			{
				return block(element) == true;
			}));
		}
		
		/**
		 * @private
		 */
		override public function toString():String
		{
			return toArray().toString();
		}
		
		private function getIndexFromQName(name:*):int
		{
			if (name is QName) {
				name = name.localName;
			}
			
			var index:Number = parseInt(name);
			if (isNaN(index)) {
				throw new ArgumentError("Expected an array index, but received '" + name + "'");
			}
			return index;
		}
		
		/**
		 * @private
		 * 
		 * Forwards calls like delete sequence[0] to sequence.removeAt(0)
		 */
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			return removeAt(getIndexFromQName(name));
		}
		
		/**
		 * @private
		 * 
		 * Forwards calls like sequence[0] to sequence.at(0)
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return at(getIndexFromQName(name));
		}
		
		/**
		 * @private
		 * 
		 * Checks for the existance of <code>1 in sequence</code>.
		 */
		override flash_proxy function hasProperty(name:*):Boolean
		{
			try {
				var index:int = getIndexFromQName(name);
				return index >= 0 && index < length;
			} catch (e:Error) {
				
			}
			return false;
		}
		
		/**
		 * @private
		 * 
		 * Forwards calls like sequence[0] = item to sequence.setItemAt(item, 0)
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			setItemAt(value, getIndexFromQName(name));
		}
	}
}