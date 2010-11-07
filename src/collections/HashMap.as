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
	 * that you pass as a key to support this functionality. This is supported by the
	 * use of two methods that are implemented on the key object: <code>hashCode()</code>
	 * and <code>equals()</code>. When a key is inserted, the key is checked for the
	 * existance of each of these methods. If they exist, the result from 
	 * <code>hashCode()</code> is used to map the key to a value. If two keys have
	 * the same hash code, then they're compared using their <code>equals()</code>
	 * method.
	 * 
	 * <p>
	 * <strong>Note:</strong> Care should be taken when a mutable object is used
	 * as a key in a map. This map implementation will not rehash an object if its
	 * property changes in such a way that it modifies its <code>hashCode()</code>
	 * value.
	 * <p>
	 * 
	 * @author Dan Schultz
	 */
	public class HashMap implements IMap
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
			
			if (key1 != null && key2 != null && key1.hasOwnProperty("equals") && key2.hasOwnProperty("equals")) {
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
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function containsKey(key:Object):Boolean
		{
			return findEntryForKey(key) != null;
		}
		
		/**
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function equals(obj:HashMap):Boolean
		{
			if (this == obj) {
				return true;
			}
			
			if (length == obj.length) {
				for (var key:Object in keys()) {
					if (grab(key) !== obj.grab(key)) {
						return false;
					}
				}
				
				return true;
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function entries():Array
		{
			var result:Array = [];
			for each (var entry:Entry in _hashToEntries) {
				result.push( new Entry(entry.key, entry.value) );
			}
			return result;
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
		 * @inheritDoc
		 */
		public function grab(key:Object):*
		{
			var entry:Entry = findEntryForKey(key);
			return entry != null ? entry.value : undefined;
		}
		
		/**
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function put(key:Object, value:Object):*
		{
			var oldValue:*;
			
			var entry:Entry = findEntryForKey(key);
			if (entry == null) {
				entry = new Entry(key, value);
				
				var hash:Object = computeHash(key);
				var entryForHash:Entry = _hashToEntries[hash];
				
				// there isn't an entry yet for the key's hash. assign the hash to the 
				// first entry.
				if (entryForHash == null) {
					_hashToEntries[hash] = entry;
				}
				// there's already entries for the key's hash. assign the new entry to
				// last entries 'next' property.
				else {
					while (entryForHash.next != null) {
						entryForHash = entryForHash.next;
					}
					entryForHash.next = entry;
				}
				
				_length++;
			} else {
				oldValue = entry.value;
			}
			
			entry.value = value;
			return oldValue;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(key:Object):*
		{
			var hash:Object = computeHash(key);
			var previousEntry:Entry;
			var value:*;
			
			var entry:Entry = _hashToEntries[hash];
			while (entry != null) {
				if (areKeysEqual(key, entry.key)) {
					value = entry.value;
					
					// this is the only entry for the hash, so just purge the hash.
					if (previousEntry == null && entry.next == null) {
						delete _hashToEntries[hash];
					}
					// this entry was the first entry in the hash. set the hash to this
					// entries next entry.
					else if (previousEntry == null && entry.next != null) {
						_hashToEntries[hash] = entry.next;
					}
					// remove this entry by removing its reference from the previous entry.
					else if (previousEntry != null) {
						previousEntry.next = entry.next;
					}
					
					break;
				}
				
				previousEntry = entry;
				entry = entry.next;
			}
			
			_length--;
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
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		public function get isEmpty():Boolean
		{
			return length == 0;
		}
		
		private var _length:int = 0;
		/**
		 * @inheritDoc
		 */
		public function get length():int
		{
			return _length;
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