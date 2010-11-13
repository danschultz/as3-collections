package tests.collections
{
	import collections.ArrayList;
	import collections.Collection;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class CollectionTests
	{
		private var _collection:Collection;
		
		[Before]
		public function setup():void
		{
			_collection = new ArrayList();
		}
		
		[Test]
		public function testIterate():void
		{
			_collection.addAll([1, 2, 3, 4, 5]);
			
			var items:Array = _collection.toArray();
			var i:int;
			for each (var item:Object in _collection) {
				assertThat(item, equalTo(items[i++]));
			}
			assertThat(i, equalTo(items.length));
		}
	}
}