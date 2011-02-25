package collections
{
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;

	public class ArraySequenceTests
	{
		private var _sequence:ArraySequence;
		
		[Before]
		public function setup():void
		{
			_sequence = new ArraySequence();
		}
		
		[Test]
		public function testAt():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			assertThat(_sequence.at(0), equalTo(1));
			assertThat(_sequence.at(4), equalTo(5));
		}
		
		[Test]
		public function testAddAt():void
		{
			_sequence.addAt(1, 0);
			_sequence.addAt(3, 1);
			_sequence.addAt(2, 1);
			
			assertThat(_sequence.toArray(), array(1, 2, 3));
		}
		
		[Test]
		public function testIndexOf():void
		{
			_sequence.addAll([1, 2, 2, 3, 4, 5]);
			
			assertThat(_sequence.indexOf(1), equalTo(0));
			assertThat(_sequence.indexOf(2), equalTo(1));
			assertThat(_sequence.indexOf(5), equalTo(5));
			assertThat(_sequence.indexOf(0), equalTo(-1));
			assertThat(_sequence.indexOf(null), equalTo(-1));
		}
		
		[Test]
		public function testIndexOfNull():void
		{
			_sequence.addAll([1, null, 2]);
			assertThat(_sequence.indexOf(null), equalTo(1));
		}
		
		[Test]
		public function testIndexOfUsingEquals():void
		{
			_sequence.addAll([new Element(1), new Element(2), new Element(3)]);
			
			assertThat(_sequence.indexOf(new Element(1)), equalTo(0));
			assertThat(_sequence.indexOf(new Element(4)), equalTo(-1));
			assertThat(_sequence.indexOf(1), equalTo(-1));
			assertThat(_sequence.indexOf(null), equalTo(-1));
		}
		
		[Test]
		public function testRemoveAt():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_sequence.removeAt(0), equalTo(1));
			assertThat(_sequence.removeAt(3), equalTo(5));
			assertThat(_sequence.length, equalTo(3));
		}
	}
}