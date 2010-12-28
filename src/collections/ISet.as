package collections
{
	/**
	 * An interface that defines a collection that does not contain duplicate elements.
	 * 
	 * @author Dan Schultz
	 */
	public interface ISet extends ICollection
	{
		/**
		 * Returns a new set that contains that elements that return <code>true</code> by
		 * the given block function. This function expects the following signature:
		 * 
		 * <p>
		 * <code>function(e:Object):Boolean</code>
		 * </p>
		 * 
		 * @param block The filter function.
		 * @return A new set.
		 */
		function where(block:Function):ISet;
	}
}