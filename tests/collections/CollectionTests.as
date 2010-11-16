package collections
{
	import flash.utils.ByteArray;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.collection.emptyArray;
	import org.hamcrest.object.equalTo;

	public class CollectionTests
	{
		private var _collection:CollectionsMock;
		
		[Before]
		public function setup():void
		{
			_collection = new CollectionsMock();
		}
		
		[Test]
		public function testAddAll():void
		{
			assertThat(_collection.addAll([1, 2, 3]), equalTo(true));
			assertThat(_collection.toArray(), array(1, 2, 3));
			
			assertThat(_collection.addAll([]), equalTo(false));
			assertThat(_collection.toArray(), array(1, 2, 3));
		}
		
		[Test]
		public function testClear():void
		{
			_collection.addAll([1, 2, 3, 4]);
			_collection.clear();
			assertThat(_collection.length, equalTo(0));
		}
		
		[Test]
		public function testConstructor():void
		{
			assertThat(new CollectionsMock().toArray(), emptyArray());
			assertThat(new CollectionsMock([1, 2, 3]).toArray(), array(1, 2, 3));
		}
		
		[Test]
		public function testContains():void
		{
			_collection.addAll([1, 2, 3]);
			
			assertThat(_collection.contains(1), equalTo(true));
			assertThat(_collection.contains("1"), equalTo(false));
			assertThat(_collection.contains(4), equalTo(false));
			assertThat(_collection.contains(null), equalTo(false));
		}
		
		[Test]
		public function testContainsUsingEquals():void
		{
			_collection.addAll([new Element(1), new Element(2), new Element(3)]);
			
			assertThat(_collection.contains(new Element(1)), equalTo(true));
			assertThat(_collection.contains(new Element(4)), equalTo(false));
			assertThat(_collection.contains(1), equalTo(false));
			assertThat(_collection.contains(null), equalTo(false));
		}
		
		[Test]
		public function testContainsNull():void
		{
			_collection.add(null);
			assertThat(_collection.contains(null), equalTo(true));
		}
		
		[Test]
		public function testContainsAll():void
		{
			_collection.addAll([1, 2, 3]);
			
			assertThat(_collection.containsAll(_collection), equalTo(true));
			assertThat(_collection.containsAll([1, 2]), equalTo(true));
			assertThat(_collection.containsAll([3]), equalTo(true));
			assertThat(_collection.containsAll([]), equalTo(true));
			assertThat(_collection.containsAll([3, 4]), equalTo(false));
		}
		
		[Test]
		public function testDifference():void
		{
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 2, 3]).toArray(), array(4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 3, 5]).toArray(), array(2, 4));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1]).toArray(), array(2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([5]).toArray(), array(1, 2, 3, 4));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([0]).toArray(), array(1, 2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([]).toArray(), array(1, 2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 2, 3, 4, 5]).toArray(), emptyArray());
		}
		
		[Test]
		public function testIntersection():void
		{
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([1, 2, 3]).toArray(), array(1, 2, 3));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([1]).toArray(), array(1));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([0, 1, 2]).toArray(), array(1, 2));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([4, 5, 6]).toArray(), array(4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([0, 1, 2, 3, 4, 5, 6]).toArray(), array(1, 2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([4, 5, 6, 7, 8, 9]).toArray(), array(4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).intersection([]).toArray(), emptyArray());
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
		
		[Test]
		public function testRemoveAll():void
		{
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 2, 3]).toArray(), array(4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 3, 5]).toArray(), array(2, 4));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1]).toArray(), array(2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([5]).toArray(), array(1, 2, 3, 4));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([0]).toArray(), array(1, 2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([]).toArray(), array(1, 2, 3, 4, 5));
			assertThat(new CollectionsMock([1, 2, 3, 4, 5]).difference([1, 2, 3, 4, 5]).toArray(), emptyArray());
		}
		
		[Test]
		public function testExternalization():void
		{
			_collection.addAll([1, 2, 3, 4, 5]);
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(_collection);
			bytes.position = 0;
			
			assertThat((bytes.readObject() as CollectionsMock).toArray(), array(1, 2, 3, 4, 5));
		}
	}
}
