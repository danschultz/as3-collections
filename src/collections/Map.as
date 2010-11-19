package collections
{
	/**
	 * A base map class that provides a scaffolding for more specific types of maps. 
	 * This class delegates the insertion, retrieval, search and removal of its elements
	 * to sub-classes. As such, the following methods must be overridden and implemented
	 * to provide a functional map:
	 * 
	 * <ul>
	 * <li>Map.entries()</li>
	 * <li>Map.insertEntry()</li>
	 * <li>Map.removeEntryWithKey()</li>
	 * </ul>
	 * 
	 * <p>
	 * <code>Map.findEntryForKey()</code> provides a default implementation for maps. Its
	 * implementation iterates through each map entry and checks if the keys match. Since
	 * this method is critical for retrieval of map elements, sub-classes should override
	 * this method to provide faster retrieval of entries.
	 * </p>
	 * 
	 * @author Dan Schultz
	 */
	public class Map implements IMap
	{
		/**
		 * Constructor.
		 */
		public function Map()
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		final public function clear():void
		{
			for each (var key:Object in keys()) {
				remove(key);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		final public function containsKey(key:Object):Boolean
		{
			return findEntryForKey(key) != null;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function containsValue(value:Object):Boolean
		{
			for each (var v:Object in values()) {
				if (Collection.areElementsEqual(v, value)) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function entries():Array
		{
			return [];
		}
		
		/**
		 * @inheritDoc
		 */
		public function equals(map:IMap):Boolean
		{
			if (this == map) {
				return true;
			}
			
			if (length == map.length) {
				for (var key:Object in keys()) {
					if (!Collection.areElementsEqual(grab(key), map.grab(key))) {
						return false;
					}
				}
				
				return true;
			}
			return false;
		}
		
		/**
		 * Returns the entry in this map that contains the given key. If one is not found,
		 * <code>null</code> is returned.
		 * 
		 * <p>
		 * A default implementation is provided, where each <code>Entry</code> of the map
		 * is iterated through to find a matching key. Sub-classes should override this 
		 * method and provide a faster implementation if possible.
		 * </p> 
		 * 
		 * @param key A key.
		 * @return An entry, or <code>null</code> if one is not found.
		 */
		protected function findEntryForKey(key:Object):Entry
		{
			for each (var entry:Entry in entries()) {
				if (Collection.areElementsEqual(key, entry.key)) {
					return entry;
				}
			}
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function grab(key:Object):*
		{
			var entry:Entry = findEntryForKey(key);
			return entry != null ? entry.value : undefined;
		}
		
		/**
		 * Called by <code>put()</code> to insert an key-value entry into this map.
		 * If an entry already exists for the given key, the entry's value should be
		 * replaced and the old value returned. If a new entry was created, 
		 * <code>undefined</code> should be returned. Since some types of maps support
		 * <code>null</code> values, it is important to return <code>undefined</code> as
		 * apposed to <code>null</code>.
		 * 
		 * @param key The key for the entry.
		 * @param value The value for the entry.
		 * @return The replaced value, or <code>undefined</code> if the entry is new.
		 */
		protected function insertEntry(key:Object, value:Object):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function keys():Array
		{
			return entries().map(function(entry:Entry, index:int, array:Array):Object
			{
				return entry.key;
			});
		}
		
		/**
		 * @inheritDoc
		 */
		final public function put(key:Object, value:Object):*
		{
			var result:* = insertEntry(key, value);
			if (result === undefined) {
				_length++;
			}
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function remove(key:Object):*
		{
			var result:* = removeEntryWithKey(key);
			if (result !== undefined) {
				_length--;
			}
			return result;
		}
		
		/**
		 * Removes the entry from this map that contains the given <code>key</code>. If an
		 * entry is not found, the value of <code>undefined</code> should be returned.
		 * Otherwise, the removed value for the entry is returned. Since some maps support
		 * <code>null</code> values, it is important to return <code>undefined</code> as
		 * apposed to <code>null</code>.
		 * 
		 * @param key The key for the entry to remove.
		 * @return The entries value, or <code>undefined</code> if the entry was not found.
		 */
		protected function removeEntryWithKey(key:Object):*
		{
			return undefined;
		}
				
		/**
		 * @private
		 */
		public function toString():String
		{
			return entries().join(", ");
		}
		
		/**
		 * @inheritDoc
		 */
		public function values():Array
		{
			return entries().map(function(entry:Entry, index:int, array:Array):Object
			{
				return entry.value;
			});
		}
		
		/**
		 * @inheritDoc
		 */
		final public function get isEmpty():Boolean
		{
			return length == 0;
		}
		
		private var _length:int = 0;
		/**
		 * @inheritDoc
		 */
		final public function get length():int
		{
			return _length;
		}
	}
}