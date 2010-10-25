package collections
{
	import flash.utils.Dictionary;

	/**
	 * A hash map is a class that maps keys to values. This hash map supports 
	 * <code>null</code> keys and <code>null</code> values, with the exception 
	 * of <code>undefined</code> values. If a key evaluates to <code>undefined</code>
	 * the key is considered not to exist.
	 * 
	 * <p>
	 * This hash map supports the equality of keys where two keys might not be
	 * the same object reference, but represent the same data. It is up to the object 
	 * that you pass as a key to support this functionality. In order for an object 
	 * to support this, the object must implement two methods: <code>equals()</code> 
	 * and <code>hashCode()</code>.
	 * </p>
	 * 
	 * @author Dan Schultz
	 */
	public class HashMap
	{
		private var _hashToEntries:Dictionary = new Dictionary();
		
		/**
		 * Constructor.
		 */
		public function HashMap()
		{
			super();
		}
		
		private function areKeysEqual(key1:Object, key2:Object):Boolean
		{
			if (key1 === key2) {
				return true;
			}
			
			if (key1 != null && key1.hasOwnProperty("equals") && key2 != null && key2.hasOwnProperty("equals")) {
				try {
					if (key1.equals(key2)) {
						return true;
					}
				} catch (e:Error) {
					
				}
			}
			
			return false;
		}
		
		private function computeHash(key:Object):Object
		{
			if (key != null && key.hasOwnProperty("equals") && key.hasOwnProperty("hashCode")) {
				return key.hashCode();
			}
			return key;
		}
		
		/**
		 * Clears all the keys and their values from the hash map.
		 */
		public function clear():void
		{
			for each (var key:Object in keys()) {
				remove(key);
			}
		}
		
		/**
		 * Creates a shallow copy of this map.
		 * 
		 * @return A cloned map.
		 */
		public function clone():HashMap
		{
			var map:HashMap = new HashMap();
			for each (var key:Object in keys()) {
				map.put(key, grab(key));
			}
			return map;
		}
		
		/**
		 * Checks if the given key is mapped to a value in this hash map.
		 * 
		 * @param key The key to check for.
		 * @return <code>true</code> if the key was found.
		 */
		public function containsKey(key:Object):Boolean
		{
			return findEntryForKey(key) != null;
		}
		
		/**
		 * Checks if the given value is being mapped to by a key.
		 * 
		 * @param value The value to check for.
		 * @return <code>true</code> if the value was found.
		 */
		public function containsValue(value:Object):Boolean
		{
			for each (var v:Object in values()) {
				if (v === value) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Checks if two maps are equal. Two maps are equal when their lengths are 
		 * the same, and their keys map to the same values.
		 * 
		 * @param obj The other hash map.
		 * @return <code>true</code> if the two maps are equal.
		 */
		public function equals(obj:HashMap):Boolean
		{
			if (this == obj) {
				return true;
			}
			
			var keys1:Array = keys();
			var keys2:Array = obj.keys();
			
			if (keys1.length == keys2.length) {
				for (var key1:Object in keys1) {
					if (grab(key1) !== obj.grab(key1)) {
						return false;
					}
				}
				
				for (var key2:Object in keys2) {
					if (grab(key2) !== obj.grab(key2)) {
						return false;
					}
				}
				
				return isEmpty;
			}
			return false;
		}
		
		private function findEntryForKey(key:Object):Entry
		{
			var entry:Entry = _hashToEntries[computeHash(key)];
			while (entry != null) {
				if (areKeysEqual(key, entry.key)) {
					break;
				}
				entry = entry.next;
			}
			return entry;
		}
		
		/**
		 * Retrieves the value that is mapped to the given key.
		 * 
		 * @param key The key to retrieve the value for.
		 * @return The key's value.
		 */
		public function grab(key:Object):Object
		{
			var entry:Entry = findEntryForKey(key);
			return entry != null ? entry.value : undefined;
		}
		
		/**
		 * Returns the set of keys contained in this map.
		 * 
		 * @return The set of keys.
		 */
		public function keys():Array
		{
			var result:Array = [];
			for each (var entry:Entry in _hashToEntries) {
				while (entry != null) {
					result.push(entry.key);
					entry = entry.next;
				}
			}
			return result;
		}
		
		/**
		 * Maps the given key to the given value. If the key already maps to a value,
		 * the value is replaced with the new value, and the old value is returned.
		 * 
		 * @param key The key to map.
		 * @param value The value to map to.
		 * @return The old value.
		 */
		public function put(key:Object, value:Object):Object
		{
			var entry:Entry = findEntryForKey(key);
			var oldValue:Object
			
			if (entry == null) {
				entry = new Entry(key, value);
				
				var hash:Object = computeHash(key);
				var entryForHash:Entry = _hashToEntries[hash];
				
				if (entryForHash == null) {
					_hashToEntries[hash] = entry;
				} else {
					while (entryForHash.next != null) {
						entryForHash = entryForHash.next;
					}
					entryForHash.next = entry;
				}
			} else {
				oldValue = entry.value;
			}
			
			entry.value = value;
			return oldValue;
		}
		
		/**
		 * Removes the mapping for the given key, and returns the value the key was mapped
		 * to.
		 * 
		 * @param key The key to remove.
		 * @return The value the key mapped to.
		 */
		public function remove(key:Object):Object
		{
			var hash:Object = computeHash(key);
			var entry:Entry = _hashToEntries[hash];
			var previousEntry:Entry;
			var value:Object;
			while (entry != null) {
				if (areKeysEqual(key, entry.key)) {
					value = entry.value;
					
					if (previousEntry == null && entry.next == null) {
						delete _hashToEntries[hash];
					} else if (previousEntry == null && entry.next != null) {
						_hashToEntries[hash] = entry.next;
					} else if (previousEntry != null) {
						previousEntry.next = entry.next;
					}
					
					break;
				}
				
				previousEntry = entry;
				entry = entry.next;
			}
			return value;
		}
		
		/**
		 * @private
		 */
		public function toString():String
		{
			var str:String = "{";
			var len:int = length;
			var count:int = 0;
			for each (var key:Object in keys()) {
				if (count > 0) {
					str += ", ";
				}
				str += key + " => " + grab(key);
				count++;
			}
			return str + "}";
		}
		
		/**
		 * Returns an array of all the values belonging to this map.
		 * 
		 * @return A list of values.
		 */
		public function values():Array
		{
			var values:Array = [];
			for each (var entry:Entry in _hashToEntries) {
				while (entry != null) {
					values.push(entry.value);
					entry = entry.next;
				}
			}
			return values;
		}
		
		/**
		 * <code>true</code> if there are no entries in this map.
		 */
		public function get isEmpty():Boolean
		{
			return length == 0;
		}
		
		/**
		 * The number of key value pairs in this map.
		 */
		public function get length():int
		{
			return keys().length;
		}
	}
}

class Entry
{
	public var key:Object;
	public var value:Object;
	
	public var next:Entry;
	
	public function Entry(key:Object, value:Object)
	{
		this.key = key;
		this.value = value;
	}
}