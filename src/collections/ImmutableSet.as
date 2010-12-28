package collections
{
	/**
	 * An immutable collection that wraps a set.
	 * 
	 * @author Dan Schultz
	 */
	public class ImmutableSet extends ImmutableCollection implements ISet
	{
		/**
		 * @copy collections.ImmutableCollection#ImmutableCollection()
		 */
		public function ImmutableSet(set:ISet)
		{
			super(set);
		}
		
		/**
		 * @inheritDoc
		 */
		public function where(block:Function):ISet
		{
			return this;
		}
	}
}