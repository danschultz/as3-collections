package collections
{
	import flash.utils.IExternalizable;
	
	[RemoteClass(alias="collections.ArraySequence")]
	
	/**
	 * A mutable sequence of elements that can contain duplicate elements. This 
	 * collection supports <code>null</code> elements.
	 * 
	 * @author Dan Schultz
	 */
	public class ArraySequence extends Sequence implements IExternalizable
	{
		private var _items:Array = [];
		
		/**
		 * @copy collections.Collection#Collection()
		 */
		public function ArraySequence(items:Object = null)
		{
			if (items is Array) {
				_items = items.concat();
				items = null;
			}
			
			super(items);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add(item:Object):Boolean
		{
			_items.push(item);
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAt(item:Object, index:int):void
		{
			if (index < 0 || index > length) {
				throw new RangeError("Cannot insert element at index " + index);
			}
			_items.splice(index, 0, item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function at(index:int):*
		{
			if (index < 0 || index >= length) {
				throw new RangeError("Index " + index + " is outside range of sequence.");
			}
			return _items[index];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function indexOf(item:Object):int
		{
			if (item != null && item.hasOwnProperty("equals")) {
				var len:int = length;
				for (var i:int = 0; i < len; i++) {
					if (areElementsEqual(item, _items[i])) {
						return i;
					}
				}
				return -1;
			}
			return _items.indexOf(item);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAt(index:int):*
		{
			if (index < 0 || index >= length) {
				throw new RangeError("Cannot remove element at index " + index);
			}
			return _items.splice(index, 1)[0];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toArray():Array
		{
			return _items.concat();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get length():int
		{
			return _items.length;
		}
	}
}