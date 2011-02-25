package collections
{
	
	import flash.events.Event;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class SequenceTests
	{
		private var _sequence:SequenceMock;
		
		[Before]
		public function setup():void
		{
			_sequence = new SequenceMock();
		}
		
		[Test]
		public function testAdd():void
		{
			assertThat(_sequence.add(1), equalTo(true));
			assertThat(_sequence.add(2), equalTo(true));
		}
		
		[Test]
		public function testContains():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_sequence.contains(1), equalTo(true));
			assertThat(_sequence.contains(5), equalTo(true));
			assertThat(_sequence.contains(0), equalTo(false));
		}
		
		[Test]
		public function testEquals():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_sequence.equals(_sequence), equalTo(true));
			assertThat(_sequence.equals(new SequenceMock([1, 2, 3, 4, 5])), equalTo(true));
			assertThat(_sequence.equals(new SequenceMock([5, 4, 3, 2, 1])), equalTo(false));
			assertThat(_sequence.equals(new SequenceMock()), equalTo(false));
		}
		
		[Test]
		public function testFirst():void
		{
			assertThat(new SequenceMock([1, 2]).first(), equalTo(1));
			assertThat(new SequenceMock([1, 2]).first(2), array(1, 2));
			assertThat(new SequenceMock([1, 2]).first(3), array(1, 2));
			assertThat(new SequenceMock().first(), equalTo(undefined));
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
		public function testLast():void
		{
			assertThat(new SequenceMock([1, 2]).last(), equalTo(2));
			assertThat(new SequenceMock([1, 2]).last(2), array(1, 2));
			assertThat(new SequenceMock([1, 2]).last(3), array(1, 2));
			assertThat(new SequenceMock().last(), equalTo(undefined));
		}
		
		[Test]
		public function testPop():void
		{
			assertThat(_sequence.pop(), equalTo(undefined));
			
			_sequence.addAll([1, 2, 3]);
			assertThat(_sequence.pop(), equalTo(3));
			assertThat(_sequence.toArray(), array(1, 2));
		}
		
		[Test]
		public function testSlice():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_sequence.slice(0).toArray(), array(1, 2, 3, 4, 5));
			assertThat(_sequence.slice(0, 1).toArray(), array(1));
			assertThat(_sequence.slice(4).toArray(), array(5));
		}
		
		[Test]
		public function testRemove():void
		{
			_sequence.addAll([1, 2, 5, 5, 3, 4, 5]);
			
			assertThat(_sequence.remove(1), equalTo(true));
			assertThat(_sequence.remove(1), equalTo(false));
			assertThat(_sequence.remove(5), equalTo(true));
			assertThat(_sequence.toArray(), array(2, 3, 4));
		}
		
		[Test]
		public function testSetItemAt():void
		{
			assertThat(_sequence.setItemAt(2, 0), equalTo(undefined));
			assertThat(_sequence.setItemAt(1, 0), equalTo(2));
			assertThat(_sequence.setItemAt(2, 1), equalTo(undefined));
			assertThat(_sequence.setItemAt(3, 2), equalTo(undefined));
			assertThat(_sequence.setItemAt(3, 0), equalTo(1));
			assertThat(_sequence.setItemAt(2, 1), equalTo(2));
			assertThat(_sequence.setItemAt(1, 2), equalTo(3));
			assertThat(_sequence.toArray(), array(3, 2, 1));
		}
		
		[Test]
		public function testShift():void
		{
			assertThat(_sequence.shift(), equalTo(undefined));
			
			_sequence.addAll([1, 2, 3]);
			assertThat(_sequence.shift(), equalTo(1));
			assertThat(_sequence.toArray(), array(2, 3));
		}
		
		[Test]
		public function testArrayAccessOperator():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			assertThat(_sequence[0], equalTo(1));
			assertThat(_sequence[4], equalTo(5));
		}
		
		[Test(expects="ArgumentError")]
		public function testArrayAccessOperatorThrowsError():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			assertThat(_sequence[new Element(1)], equalTo(1));
		}
		
		[Test]
		public function testArrayDeleteOperator():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			delete _sequence[0];
			assertThat(_sequence.toArray(), array(2, 3, 4, 5));
			
			delete _sequence[3];
			assertThat(_sequence.toArray(), array(2, 3, 4));
		}
		
		[Test]
		public function testArrayInOperator():void
		{
			_sequence.addAll([1, 2, 3, 4, 5]);
			
			assertThat(0 in _sequence, equalTo(true));
			assertThat(4 in _sequence, equalTo(true));
			assertThat(5 in _sequence, equalTo(false));
		}
		
		[Test]
		public function testArraySetOperator():void
		{
			_sequence[0] = 2;
			assertThat(_sequence.toArray(), array(2));
			
			_sequence[1] = 2;
			assertThat(_sequence.toArray(), array(2, 2));
			
			_sequence[0] = 1;
			assertThat(_sequence.toArray(), array(1, 2));
		}
	}
}

import collections.Sequence;

class SequenceMock extends Sequence
{
	private var _items:Array = [];
	
	public function SequenceMock(items:Array = null)
	{
		super(items);
	}
	
	override public function at(index:int):*
	{
		return _items[index];
	}
	
	override public function addAt(item:Object, index:int):void
	{
		_items.splice(index, 0, item);
	}
	
	override public function removeAt(index:int):*
	{
		return _items.splice(index, 1)[0];
	}
	
	override public function toArray():Array
	{
		return _items.concat();
	}
	
	override public function get length():int
	{
		return _items.length;
	}
}