package collections
{
	import flash.utils.IExternalizable;
	
	[RemoteClass(alias="collections.ArraySet")]
	
	[Deprecated(replacement="collections.HashSet", since="1.2.0", message="HashSet now supports ordering of its elements.")]
	/**
	 * An array set is a collection that does not contain duplicate items, and
	 * guarentees the iteration order in which they're added. This collection may 
	 * contain <code>null</code> values. If an element is inserted twice, the 
	 * old element is moved to the end of the list.
	 * 
	 * <p>
	 * This set is backed by both a <code>HashSet</code> and an <code>ArrayList</code>.
	 * There is a performance penalty when removing elements from this set, because
	 * of the additional overhead required to iterate and find the element to remove
	 * from the <code>ArrayList</code>. If iteration order is not required, a 
	 * <code>HashSet</code> is recommended.
	 * </p>
	 * 
	 * @see collections.HashSet
	 * 
	 * @author Dan Schultz
	 */
	public class ArraySet extends HashSet implements IExternalizable
	{
		private var _elements:ArrayList = new ArrayList();
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function ArraySet(items:Object = null)
		{
			super(items);
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
		 * @inheritDoc
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
		 * @inheritDoc
		 */
		override public function toArray():Array
		{
			return _elements.toArray();
		}
	}
}