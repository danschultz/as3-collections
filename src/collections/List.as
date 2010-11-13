package collections
{
	import flash.utils.flash_proxy;
	
	use namespace flash_proxy;

	/**
	 * A base list implementation that provides a scaffolding for more specific types 
	 * of lists. This class delegates the insertion, retrieval, search and removal to 
	 * its sub-classes. As such, when implementing an immutalbe list, developers must 
	 * override and implement the following methods:
	 * 
	 * <ul>
	 * <li><code>List.at()</code></li>
	 * <li><code>List.toArray()</code></li>
	 * <li><code>List.length</code></li>
	 * </ul>
	 * 
	 * When implementing a mutable list, the following methods must also be implemented:
	 * 
	 * <ul>
	 * <li><code>List.addAt()</code></li>
	 * <li><code>List.removeAt()</code></li>
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
	 * Lists that extend from this class also support the retrieval and insertion
	 * of elements through the array access operator <code>[]</code>. Passing in an
	 * object that cannot be interpreted as an integer will throw an error. In addition,
	 * passing in an index that is either less than 0, or greater than the length of the
	 * list will cause a <code>RangeError</code>.
	 * </p>
	 * 
	 * <p>
	 * <strong>Example:</strong> Using the array access operators.
	 * 
	 * <listing version="3.0">
	 * var list:ArrayList = new ArrayList();
	 * list[0] = "a";
	 * trace(list[0]); // a
	 * 
	 * trace(0 in list); // true
	 * trace(1 in list); // false
	 * 
	 * delete list[0];
	 * trace(list.length); // 0
	 * </listing>
	 * </p>
	 * 
	 * @see collections.ArrayList
	 * @see collections.Collection#areElementsEqual()
	 * 
	 * @author Dan Schultz
	 */
	public class List extends Collection
	{
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function List(items:Object = null)
		{
			super(items);
		}
		
		/**
		 * Returns the element of this list that is stored at the given index.
		 * If the index is less than 0 or is greater than or equal to the size of 
		 * the list, a <code>RangeError</code> is thrown.
		 * 
		 * @param index The position of the item to return.
		 * @return The item at the given position.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	or equal to the size of the list.
		 */
		public function at(index:int):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		final override public function add(item:Object):Boolean
		{
			var oldLength:int = length;
			addAt(item, length);
			return oldLength != length;
		}
		
		/**
		 * Adds the given element to this list at the given index.
		 * 
		 * @param item The element to add.
		 * @param index The index to add the element at.
		 * @throws RangeError If <code>(index < 0 || index > length)</code>
		 */
		public function addAt(item:Object, index:int):void
		{
			
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
			
			if (collection is List && length == collection.length) {
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
		 * Returns the first <code>n</code> elements from this list. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the list is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		final public function first(count:int = 1):*
		{
			if (!isEmpty) {
				return count == 1 ? at(0) : range(0, count).toArray();
			}
			return undefined;
		}
		
		/**
		 * Searches for the first occurrence in this list of the given element. This
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
		 * Returns the last <code>n</code> elements from this list. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the list is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		final public function last(count:int = 1):*
		{
			if (!isEmpty) {
				return count == 1 ? at(length-1) : range(length-count < 0 ? 0 : length-count, length).toArray();
			}
			return undefined;
		}
		
		/**
		 * Removes and returns the last element in the list. If the list is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The last element in the list, or <code>undefined</code>.
		 */
		final public function pop():*
		{
			return isEmpty ? undefined : removeAt(length-1);
		}
		
		/**
		 * Returns a new list that contains the elements from this list between
		 * the starting index (inclusive) and the ending index (exclusive).
		 * 
		 * @param start The starting index. If a negative number, the starting 
		 * 	point begins at the end of the list, where -1 is the last element.
		 * @param end The ending index. If you omit this parameter, the range 
		 * 	includes all elements from the starting point to the end of the list. 
		 * 	If the index is a negative number, the ending point is specified from 
		 * 	the end of the list, where -1 is the last element.
		 * @return A new list.
		 */
		public function range(start:int, end:int = int.MAX_VALUE):List
		{
			return new ArrayList(toArray().slice(start, end));
		}
		
		/**
		 * @inheritDoc
		 */
		final override public function remove(item:Object):Boolean
		{
			var index:int = indexOf(item);
			if (index != -1) {
				removeAt(index);
				return true;
			}
			return false;
		}
		
		/**
		 * Removes the element of this list that is stored at the given position.
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
		 * the index is the size of the list, the element is added to the end of the
		 * list and <code>undefined</code> is returned.
		 * 
		 * @param item The new item.
		 * @param index The position of the item to replace.
		 * @return The element that was replaced.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	the size of the list.
		 */
		final public function setItemAt(item:Object, index:int):*
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
		 * Removes and returns the first element in the list. If the list is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The first element in the list, or <code>undefined</code>.
		 */
		final public function shift():*
		{
			return isEmpty ? undefined : removeAt(0);
		}
		
		/**
		 * Returns a new list that is sorted according to the given function. This
		 * function should have the following signature: 
		 * <code>function comparator(a:Object, b:Object):int</code>. If the returned
		 * integer is negative, then <code>a</code> preceeds <code>b</code>. If the
		 * returned integer is 0, then <code>a</code> has the same sort order as
		 * <code>b</code>. If positive, then <code>a</code> appears after <code>b</code>. 
		 * 
		 * @param comparator The comparator function.
		 * @return A new sorted list.
		 */
		public function sort(comparator:Function):List
		{
			return new ArrayList(toArray().sort(comparator));
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
		 * Forwards calls like delete list[0] to list.removeAt(0)
		 */
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			return removeAt(getIndexFromQName(name));
		}
		
		/**
		 * @private
		 * 
		 * Forwards calls like list[0] to list.at(0)
		 */
		override flash_proxy function getProperty(name:*):*
		{
			return at(getIndexFromQName(name));
		}
		
		/**
		 * @private
		 * 
		 * Checks for the existance of <code>1 in list</code>.
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
		 * Forwards calls like list[0] = item to list.setItemAt(item, 0)
		 */
		override flash_proxy function setProperty(name:*, value:*):void
		{
			setItemAt(value, getIndexFromQName(name));
		}
	}
}