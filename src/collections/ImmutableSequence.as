package collections
{
	/**
	 * An immutable collection that wraps a sequence.
	 * 
	 * @author Dan Schultz
	 */
	public class ImmutableSequence extends ImmutableCollection implements ISequence
	{
		private var _sequence:ISequence;
		
		/**
		 * @copy collections.ImmutableCollection#ImmutableCollection()
		 */
		public function ImmutableSequence(sequence:ISequence)
		{
			super(sequence);
			_sequence = sequence;
		}
		
		/**
		 * @inheritDoc
		 */
		public function at(index:int):*
		{
			return _sequence.at(index);
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
			return _sequence.first(count);
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf(item:Object):int
		{
			return _sequence.indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		public function last(count:int = 1):*
		{
			return _sequence.last(count);
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
		public function slice(start:int, end:int = int.MAX_VALUE):ISequence
		{
			return new ImmutableSequence(_sequence.slice(start, end));
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
		public function sort(comparator:Function):ISequence
		{
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function where(block:Function):ISequence
		{
			return this;
		}
	}
}