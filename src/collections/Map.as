package collections
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * A base map class that provides a scaffolding for more specific types of maps. 
	 * This class delegates the insertion, retrieval and removal of its elements to 
	 * sub-classes. As such, the following methods must be overridden and implemented
	 * to provide a functional map:
	 * 
	 * <ul>
	 * <li>Map.containsKey()</li>
	 * <li>Map.entries()</li>
	 * <li>Map.grab()</li>
	 * <li>Map.put()</li>
	 * <li>Map.remove()</li>
	 * <li>Map.length</li>
	 * </ul>
	 * 
	 * <p>
	 * <code>Map.keys()</code> and <code>Map.values()</code> provides a default implementation 
	 * for maps. Its implementation iterates through each map entry and returns either the 
	 * set of keys, or list of values depending on the retrieval method. If a more efficient
	 * way can be performed, it is recommended to override these methods.
	 * </p>
	 * 
	 * @author Dan Schultz
	 */
	public class Map extends Proxy implements IMap
	{
		/**
		 * Creates a new map that is populated with the given entries. The map is populated
		 * by performing a <code>for each..in</code> operation on the <code>map</code>.
		 * 
		 * @param map The key-value mappings to populate this map with.
		 */
		public function Map(map:Object = null)
		{
			putAll(map);
		}
		
		/**
		 * @inheritDoc
		 */
		final public function clear():void
		{
			removeAll(keys());
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsKey(key:Object):Boolean
		{
			return false;
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
		 * @inheritDoc
		 */
		public function grab(key:Object):*
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
		public function put(key:Object, value:Object):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function putAll(map:Object):IMap
		{
			if (map is IMap) {
				for each (var entry:Entry in map.entries()) {
					put(entry.key, entry.value);
				}
			} else {
				for (var key:Object in map) {
					put(key, map[key]);
				}
			}
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(key:Object):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function removeAll(keys:Object):IMap
		{
			for each (var key:Object in keys) {
				remove(key);
			}
			return this;
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
		
		/**
		 * @inheritDoc
		 */
		public function get length():int
		{
			return 0;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextName(index:int):String
		{
			return (index-1).toString();
		}
		
		private var _iteratingKeys:Array;
		private var _len:int;
		/**
		 * @private
		 */
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index == 0) {
				_iteratingKeys = keys();
				_len = _iteratingKeys.length;
			}
			return index < _len ? index+1 : 0;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextValue(index:int):*
		{
			return grab(_iteratingKeys[index-1]);
		}
	}
}