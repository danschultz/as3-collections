package collections
{
	/**
	 * A mutable list of elements that can contain duplicate elements. This 
	 * collection supports <code>null</code> elements.
	 * 
	 * @author Dan Schultz
	 */
	public class ArrayList extends Collection
	{
		private var _items:Array = [];
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function ArrayList(items:Object = null)
		{
			super(items);
		}
		
		/**
		 * @private
		 */
		override public function add(item:Object):Boolean
		{
			addAt(item, length);
			return true;
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
			if (index < 0 || index > length) {
				throw new RangeError("Cannot insert element at index " + index);
			}
			_items.splice(index, 0, item);
		}
		
		/**
		 * @private
		 */
		override public function contains(item:Object):Boolean
		{
			return indexOf(item) != -1;
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
		public function getItemAt(index:int):Object
		{
			if (index < 0 || index >= length) {
				throw new RangeError("Index " + index + " is outside range of list.");
			}
			return _items[index];
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
			var hasEquals:Boolean = item != null && item.hasOwnProperty("equals");
			
			var len:int = length;
			for (var i:int = 0; i < len; i++) {
				var tempItem:Object = _items[i];
				
				if (tempItem === item) {
					return i;
				}
				
				if (hasEquals && tempItem != null && tempItem.hasOwnProperty("equals")) {
					try {
						if (tempItem.equals(item)) {
							return i;
						}
					} catch(e:Error) {
						
					}
				}
			}
			
			return -1;
		}
		
		/**
		 * @private
		 */
		override public function remove(item:Object):Boolean
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
		public function removeAt(index:int):Object
		{
			if (index < 0 || index >= index) {
				throw new RangeError("Cannot remove element at index " + index);
			}
			return _items.splice(index, 1)[0];
		}
		
		/**
		 * Replaces an element at the given position with the specified element.
		 * 
		 * @param item The replacee item.
		 * @param index The position of the item to replace.
		 * @return The element that was replaced.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	or equal to the size of the list.
		 */
		public function setItemAt(item:Object, index:int):Object
		{
			var oldItem:Object = removeAt(index);
			addAt(item, index);
			return oldItem;
		}
		
		/**
		 * @private
		 */
		override public function toArray():Array
		{
			return _items.concat();
		}
		
		/**
		 * @private
		 */
		override public function get length():int
		{
			return _items.length;
		}
	}
}