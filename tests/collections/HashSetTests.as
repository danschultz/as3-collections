package collections
{
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class HashSetTests
	{
		private var _set:HashSet;
		
		[Before]
		public function setup():void
		{
			_set = new HashSet();
		}
		
		[Test]
		public function testAdd():void
		{
			assertThat(_set.add(1), equalTo(true));
			assertThat(_set.add(1), equalTo(false));
			
			assertThat(_set.length, equalTo(1));
			assertThat(_set.toArray(), array(1));
		}
		
		[Test]
		public function testAddUsingHash():void
		{
			assertThat(_set.add(new Element(1)), equalTo(true));
			assertThat(_set.add(new Element(1)), equalTo(false));
			assertThat(_set.add(new Element(2)), equalTo(true));
			assertThat(_set.length, equalTo(2));
		}
		
		[Test]
		public function testAddNull():void
		{
			assertThat(_set.add(1), equalTo(true));
			assertThat(_set.add(null), equalTo(true));
			
			assertThat(_set.length, equalTo(2));
			assertThat(_set.toArray(), array(1, null));
		}
		
		[Test]
		public function testContains():void
		{
			_set.addAll([1, 2, 3, 4, 5]);
			assertThat(_set.contains(1), equalTo(true));
			assertThat(_set.contains(5), equalTo(true));
			assertThat(_set.contains(-1), equalTo(false));
		}
		
		[Test]
		public function testContainsUsingHash():void
		{
			_set.addAll([1, new Element(1), new Element(2), 2]);
			
			assertThat(_set.contains(1), equalTo(true));
			assertThat(_set.contains(new Element(1)), equalTo(true));
			assertThat(_set.contains(new Element(2)), equalTo(true));
			assertThat(_set.contains(new Element(3)), equalTo(false));
			assertThat(_set.contains(3), equalTo(false));
		}
		
		[Test]
		public function testRemove():void
		{
			_set.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_set.remove(1), equalTo(true));
			assertThat(_set.remove(new Element(1)), equalTo(false));
			assertThat(_set.remove(3), equalTo(true));
			assertThat(_set.remove(5), equalTo(true));
			assertThat(_set.toArray(), array(2, 4));
		}
	}
}