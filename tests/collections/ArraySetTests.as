package collections
{
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ArraySetTests
	{
		private var _set:ArraySet;
		
		[Before]
		public function setup():void
		{
			_set = new ArraySet();
		}
		
		[Test]
		public function testAdd():void
		{
			_set.addAll([1, 2, 3, 4, 5]);
			_set.add(1);
			assertThat(_set.toArray(), array(2, 3, 4, 5, 1));
		}
		
		[Test]
		public function testRemove():void
		{
			_set.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_set.remove(3), equalTo(true));
			assertThat(_set.remove(-1), equalTo(false));
			assertThat(_set.remove(5), equalTo(true));
			assertThat(_set.toArray(), array(1, 2, 4));
		}
	}
}