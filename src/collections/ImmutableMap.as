package collections
{
	/**
	 * Provides a generic immutable map wrapper. This map delegates calls for its
	 * immutable methods to the map that it wraps. These methods include:
	 * 
	 * <ul>
	 * <li><code>IMap.containsKey()</code></li>
	 * <li><code>IMap.entries()</code></li>
	 * <li><code>IMap.equals()</code></li>
	 * <li><code>IMap.grab()</code></li>
	 * <li><code>IMap.keys()</code></li>
	 * <li><code>IMap.values()</code></li>
	 * <li><code>IMap.length</code></li>
	 * </ul>
	 * 
	 * <p>
	 * For mutable methods, such as <code>IMap.put()</code> and <code>IMap.remove()</code>,
	 * the elements are simply ignored from being inserted into the wrapped collection. 
	 * These mutable methods will not throw run-time errors, and do not need to be checked.
	 * </p>
	 * 
	 * @author Dan Schultz
	 */
	public class ImmutableMap extends Map implements IMap
	{
		private var _map:IMap;
		
		/**
		 * Creates a new immutable map that wraps the given map.
		 * 
		 * @param map The map to make immutable.
		 */
		public function ImmutableMap(map:IMap)
		{
			super();
			_map = map;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function containsKey(key:Object):Boolean
		{
			return _map.containsKey(key);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function entries():Array
		{
			return _map.entries();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function equals(map:IMap):Boolean
		{
			return _map.equals(map);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function grab(key:Object):*
		{
			return _map.grab(key);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function keys():Array
		{
			return _map.keys();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function values():Array
		{
			return _map.values();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get length():int
		{
			return _map.length;
		}
	}
}