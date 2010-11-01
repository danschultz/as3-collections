package collections
{
	/**
	 * An array set is a collection that does not contain duplicate items, and
	 * are stored in the same order in which they're added. This collection may 
	 * contain <code>null</code> values. If an element is inserted twice, the 
	 * old element is removed and inserted at the end of the list.
	 * 
	 * @author Dan Schultz
	 */
	public class ArraySet extends HashSet
	{
		private var _elements:ArrayList = new ArrayList();
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function ArraySet(collection:ICollection = null)
		{
			super(collection);
		}
		
		/**
		 * Inserts the given item into this set. If the element already exists in
		 * this collection, it is first removed then added to the end of the set.
		 * 
		 * @inheritDoc
		 */
		override public function add(item:Object):Boolean
		{
			remove(item);
			super.add(item);
			_elements.add(item);
			return true;
		}
		
		/**
		 * @private
		 */
		override public function remove(item:Object):Boolean
		{
			if (super.remove(item)) {
				_elements.remove(item);
				return true;
			}
			return false;
		}
		
		/**
		 * @private
		 */
		override public function toArray():Array
		{
			return _elements.toArray();
		}
	}
}