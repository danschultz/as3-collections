package collections
{
	/**
	 * Provides a base implementation for immutable collection wrappers. This collection
	 * delegates calls for immutable methods to the collection that it wraps. These methods
	 * include:
	 * 
	 * <ul>
	 * <li><code>ICollection.contains()</code></li>
	 * <li><code>ICollection.containsAll()</code></li>
	 * <li><code>ICollection.equals()</code></li>
	 * <li><code>ICollection.isEmpty</code></li>
	 * <li><code>ICollection.length</code></li>
	 * </ul>
	 * 
	 * <p>
	 * For mutable methods, such as <code>ICollection.add()</code> and <code>ICollection.remove()</code>, 
	 * the elements are not inserted into the wrapped collection. All mutable methods are guarenteed 
	 * to not throw run-time errors, and do not need to be wrapped inside try-catch blocks.
	 * </p>
	 * 
	 * <p>
	 * Immutable collection wrappers and its sub-classes inherit from <code>Collection</code>.
	 * As such, these immutable collection types support <code>for each..in</code> iteration.
	 * </p>
	 * 
	 * @author Dan Schultz
	 */
	public class ImmutableCollection extends Collection implements ICollection
	{
		/**
		 * Creates a new immutable collection that wraps the given collection.
		 * 
		 * @param collection The collection to make immutable.
		 */
		public function ImmutableCollection(collection:ICollection)
		{
			super();
			_collection = collection;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add(item:Object):Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone():ICollection
		{
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function remove(item:Object):Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toArray():Array
		{
			return _collection.toArray();
		}
		
		private var _collection:ICollection;
		/**
		 * A reference to the wrapped collection.
		 */
		protected function get collection():ICollection
		{
			return _collection;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get length():int
		{
			return _collection.length;
		}
	}
}