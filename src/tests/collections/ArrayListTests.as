package tests.collections
{
	import collections.ArrayList;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ArrayListTests
	{
		private var _list:ArrayList;
		
		[Before]
		public function setup():void
		{
			_list = new ArrayList();
		}
		
		[Test]
		public function testAt():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			assertThat(_list.at(0), equalTo(1));
			assertThat(_list.at(4), equalTo(5));
		}
		
		[Test]
		public function testAddAt():void
		{
			_list.addAt(1, 0);
			_list.addAt(3, 1);
			_list.addAt(2, 1);
			
			assertThat(_list.toArray(), array(1, 2, 3));
		}
		
		[Test]
		public function testIndexOf():void
		{
			_list.addAll([1, 2, 2, 3, 4, 5]);
			
			assertThat(_list.indexOf(1), equalTo(0));
			assertThat(_list.indexOf(2), equalTo(1));
			assertThat(_list.indexOf(5), equalTo(5));
			assertThat(_list.indexOf(0), equalTo(-1));
			assertThat(_list.indexOf(null), equalTo(-1));
		}
		
		[Test]
		public function testIndexOfNull():void
		{
			_list.addAll([1, null, 2]);
			assertThat(_list.indexOf(null), equalTo(1));
		}
		
		[Test]
		public function testIndexOfUsingEquals():void
		{
			_list.addAll([new Element(1), new Element(2), new Element(3)]);
			
			assertThat(_list.indexOf(new Element(1)), equalTo(0));
			assertThat(_list.indexOf(new Element(4)), equalTo(-1));
			assertThat(_list.indexOf(1), equalTo(-1));
			assertThat(_list.indexOf(null), equalTo(-1));
		}
		
		[Test]
		public function testRemoveAt():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_list.removeAt(0), equalTo(1));
			assertThat(_list.removeAt(3), equalTo(5));
			assertThat(_list.length, equalTo(3));
		}
	}
}