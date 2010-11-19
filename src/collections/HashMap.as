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
	public class HashMap extends Map implements IMap
	{
		private var _hashToEntries:Dictionary = new Dictionary();
		
		/**
		 * Constructor.
		 */
		public function HashMap()
		{
			super();
		}
		
		private function computeHash(key:Object):Object
		{
			if (key != null && key.hasOwnProperty("equals") && key.hasOwnProperty("hashCode")) {
				return key.hashCode();
			}
			return key;
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
		override public function entries():Array
		{
			var result:Array = [];
			for each (var entry:Entry in _hashToEntries) {
				result.push( new Entry(entry.key, entry.value) );
			}
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function findEntryForKey(key:Object):Entry
		{
			var entry:HashMapEntry = _hashToEntries[computeHash(key)];
			while (entry != null) {
				if (Collection.areElementsEqual(key, entry.key)) {
					break;
				}
				entry = entry.next;
			}
			return entry;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function keys():Array
		{
			var result:Array = [];
			for each (var entry:HashMapEntry in _hashToEntries) {
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
		override protected function insertEntry(key:Object, value:Object):*
		{
			var oldValue:*;
			
			var entry:HashMapEntry = findEntryForKey(key) as HashMapEntry;
			if (entry == null) {
				entry = new HashMapEntry(key, value);
				
				var hash:Object = computeHash(key);
				var entryForHash:HashMapEntry = _hashToEntries[hash];
				
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
			} else {
				oldValue = entry.value;
			}
			
			entry.value = value;
			return oldValue;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeEntryWithKey(key:Object):*
		{
			var hash:Object = computeHash(key);
			var previousEntry:HashMapEntry;
			var value:*;
			
			var entry:HashMapEntry = _hashToEntries[hash];
			while (entry != null) {
				if (Collection.areElementsEqual(key, entry.key)) {
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
			
			return value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function values():Array
		{
			var values:Array = [];
			for each (var entry:HashMapEntry in _hashToEntries) {
				while (entry != null) {
					values.push(entry.value);
					entry = entry.next;
				}
			}
			return values;
		}
	}
}

import collections.Entry;

class HashMapEntry extends Entry
{
	public var next:HashMapEntry;
	
	public function HashMapEntry(key:Object, value:Object)
	{
		super(key, value);
	}
}