package collections
{
	import flash.utils.IExternalizable;

	[RemoteClass(alias="collections.ArrayList")]
	
	[Deprecated(replacement="collections.ArraySequence", since="1.2.0", message="In order to not conflict with Flex collections, Lists have been renamed to Sequences.")]
	/**
	 * A mutable list of elements that can contain duplicate elements. This 
	 * collection supports <code>null</code> elements.
	 * 
	 * @author Dan Schultz
	 */
	public class ArrayList extends List implements IExternalizable
	{
		private var _items:Array = [];
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function ArrayList(items:Object = null)
		{
			if (items is Array) {
				_items = items.concat();
				_length = _items.length;
				items = null;
			}
			
			super(items);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function at(index:int):*
		{
			if (index < 0 || index >= length) {
				throw new RangeError("Index " + index + " is outside range of list.");
			}
			return _items[index];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAt(item:Object, index:int):void
		{
			if (index < 0 || index > length) {
				throw new RangeError("Cannot insert element at index " + index);
			}
			_length++;
			_items.splice(index, 0, item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function indexOf(item:Object):int
		{
			var len:int = length;
			for (var i:int = 0; i < len; i++) {
				if (areElementsEqual(item, _items[i])) {
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAt(index:int):*
		{
			if (index < 0 || index >= length) {
				throw new RangeError("Cannot remove element at index " + index);
			}
			_length--;
			return _items.splice(index, 1)[0];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toArray():Array
		{
			return _items.concat();
		}
		
		private var _length:int = 0;
		/**
		 * @inheritDoc
		 */
		override public function get length():int
		{
			return _length;
		}
	}
}