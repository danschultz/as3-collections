package collections
{
	import flash.utils.IExternalizable;
	
	[RemoteClass(alias="collections.HashSet")]
	
	/**
	 * A hash set is a collection that contains no duplicate items, and makes no 
	 * guarentee to the order of iteration of its elements. This collection may 
	 * contain <code>null</code> values.
	 * 
	 * @see collections.ArraySet
	 * 
	 * @author Dan Schultz
	 */
	public class HashSet extends Set implements IExternalizable
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
		 * @inheritDoc
		 */
		override public function add(item:Object):Boolean
		{
			return _map.put(item, null) === undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains(item:Object):Boolean
		{
			return _map.containsKey(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item:Object):Boolean
		{
			return _map.remove(item) !== undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toArray():Array
		{
			return _map.keys();
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