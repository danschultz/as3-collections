package collections
{
	[RemoteClass(alias="collections.Collections")]
	public class CollectionsMock extends Collection
	{
		private var _elements:Array = [];
		
		public function CollectionsMock(items:Array = null)
		{
			super(items);
		}
		
		override public function add(item:Object):Boolean
		{
			_elements.push(item);
			return true;
		}
		
		private function indexOf(item:Object):int
		{
			for (var i:int = 0; i < _elements.length; i++) {
				if (areElementsEqual(_elements[i], item)) {
					return i;
				}
			}
			return -1;
		}
		
		override public function remove(item:Object):Boolean
		{
			var index:int = indexOf(item);
			if (index != -1) {
				_elements.splice(index, 1);
				return true;
			}
			return false;
		}
		
		override public function toArray():Array
		{
			return _elements.concat();
		}
		
		override public function get length():int
		{
			return _elements.length;
		}
	}
}