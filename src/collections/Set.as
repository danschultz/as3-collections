package collections
{
	/**
	 * The base implementation for set collections. This class provides a default
	 * implementation of <code>equals()</code>, but relies on its sub-classes to
	 * perform the insertion and removal of elements to the set.
	 * 
	 * @author Dan Schultz
	 */
	public class Set extends Collection
	{
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function Set(items:Object = null)
		{
			super(items);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function equals(collection:ICollection):Boolean
		{
			if (this == collection) {
				return true;
			}
			
			if (collection is Set && length == collection.length) {
				return contains(collection)
			}
			
			return false
		}
	}
}