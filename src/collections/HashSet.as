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
		 * @copy com.mixbook.collection.Collection#Collection()
		 */
		public function HashSet(collection:ICollection = null)
		{
			super(collection);
		}
		
		/**
		 * Creates a new hash set that contains the items in the given object. This
		 * method performs a <code>for each</code> iteration on the given object to
		 * populate the collection.
		 * 
		 * @param items The items to set.
		 * @return A new hash set.
		 */
		public static function from(items:Object):HashSet
		{
			var set:HashSet = new HashSet();
			for each (var item:Object in items) {
				set.add(item);
			}
			return set;
		}
		
		/**
		 * @private
		 */
		override public function add(item:Object):Boolean
		{
			if (!contains(item)) {
				_map.put(item, null);
				return true;
			}
			return false;
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
			if (contains(item)) {
				_map.remove(item);
				return true;
			}
			return false;
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