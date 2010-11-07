package collections
{
	/**
	 * A hash set is a collection that contains no duplicate items. This collection
	 * may contain <code>null</code> values.
	 * 
	 * @author Dan Schultz
	 */
	public class HashSet extends Collection
	{
		private var _map:HashMap = new HashMap();
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function HashSet(items:Object = null)
		{
			super(items);
		}
		
		/**
		 * @private
		 */
		override public function add(item:Object):Boolean
		{
			_map.put(item, null);
			return true;
		}
		
		/**
		 * @private
		 */
		override public function contains(item:Object):Boolean
		{
			return _map.containsKey(item);
		}
		
		/**
		 * @private
		 */
		override public function remove(item:Object):Boolean
		{
			return _map.remove(item) != undefined;
		}
		
		/**
		 * @private
		 */
		override public function toArray():Array
		{
			return _map.keys();
		}
		
		/**
		 * @private
		 */
		override public function get length():int
		{
			return _map.length;
		}
	}
}