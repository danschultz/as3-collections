package collections
{
	/**
	 * A map is an object that maps keys to values.
	 * 
	 * @author Dan Schultz
	 */
	public interface IMap
	{
		/**
		 * Clears all the keys and their values from the hash map.
		 */
		function clear():void;
		
		/**
		 * Checks if the given key is mapped to a value in this hash map.
		 * 
		 * @param key The key to check for.
		 * @return <code>true</code> if the key was found.
		 */
		function containsKey(key:Object):Boolean;
		
		/**
		 * Checks if the given value is being mapped to by a key.
		 * 
		 * @param value The value to check for.
		 * @return <code>true</code> if the value was found.
		 */
		function containsValue(value:Object):Boolean;
		
		/**
		 * Returns the set of <code>Entry</code>s that this map contains. An entry 
		 * represents a key value mapping.
		 * 
		 * @return A set of <code>Entry</code>s.
		 */
		function entries():Array;
		
		/**
		 * Checks if two maps are equal. Two maps are equal when their lengths are 
		 * the same, and their keys map to the same values.
		 * 
		 * @param map The other hash map.
		 * @return <code>true</code> if the two maps are equal.
		 */
		function equals(map:IMap):Boolean;
		
		/**
		 * Retrieves the value that is mapped to the given key.
		 * 
		 * @param key The key to retrieve the value for.
		 * @return The key's value.
		 */
		function grab(key:Object):*;
		
		/**
		 * Returns the set of keys contained in this map.
		 * 
		 * @return The set of keys.
		 */
		function keys():Array;
		
		/**
		 * Maps the given key to the given value. If the key already maps to a value,
		 * the value is replaced with the new value, and the old value is returned.
		 * 
		 * @param key The key to map.
		 * @param value The value to map to.
		 * @return The old value.
		 */
		function put(key:Object, value:Object):*;
		
		/**
		 * Copies all the entries from the given map to this map. 
		 * 
		 * @param map The map to copy.
		 * @return This instance.
		 */
		function putAll(map:Object):IMap;
		
		/**
		 * Removes the mapping for the given key, and returns the value the key was mapped
		 * to.
		 * 
		 * @param key The key to remove.
		 * @return The value the key mapped to.
		 */
		function remove(key:Object):*;
		
		/**
		 * Removes all mappings for the given keys. This method accepts an <code>Array</code>, 
		 * <code>Collection</code>, or any object that supports a <code>for each..in</code> 
		 * iteration.
		 * 
		 * @param keys The keys to remove.
		 * @return This instance.
		 */
		function removeAll(keys:Object):IMap;
		
		/**
		 * Returns an array of all the values belonging to this map.
		 * 
		 * @return A list of values.
		 */
		function values():Array;
		
		/**
		 * <code>true</code> if there are no entries in this map.
		 */
		function get isEmpty():Boolean;
		
		/**
		 * The number of key value pairs in this map.
		 */
		function get length():int;
	}
}