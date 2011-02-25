package collections
{
	[Deprecated(replacement="collections.ImmutableSequence", since="1.2.0", message="In order to not conflict with Flex collections, Lists have been renamed to Sequences.")]
	/**
	 * An immutable collection that wraps a list.
	 * 
	 * @author Dan Schultz
	 */
	public class ImmutableList extends ImmutableCollection implements IList
	{
		private var _list:IList
		
		/**
		 * @copy collections.ImmutableCollection#ImmutableCollection()
		 */
		public function ImmutableList(list:IList)
		{
			super(list);
			_list = list;
		}
		
		/**
		 * @inheritDoc
		 */
		public function at(index:int):*
		{
			return _list.at(index);
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAllAt(items:Object, index:int):void
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAt(item:Object, index:int):void
		{
			
		}
		
		/**
		 * @inheritDoc
		 */
		public function first(count:int = 1):*
		{
			return _list.first(count);
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf(item:Object):int
		{
			return _list.indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function last(count:int = 1):*
		{
			return _list.last(count);
		}
		
		/**
		 * @inheritDoc
		 */
		public function pop():*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function range(start:int, end:int = int.MAX_VALUE):IList
		{
			return new ImmutableList(_list.range(start, end));
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAt(index:int):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setItemAt(item:Object, index:int):*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function shift():*
		{
			return undefined;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort(comparator:Function):IList
		{
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function where(block:Function):IList
		{
			return this;
		}
	}
}