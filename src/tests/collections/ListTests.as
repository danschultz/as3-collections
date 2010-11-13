package tests.collections
{
	import collections.ArrayList;
	
	import flash.events.Event;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class ListTests
	{
		private var _list:ListMock;
		
		[Before]
		public function setup():void
		{
			_list = new ListMock();
		}
		
		[Test]
		public function testAdd():void
		{
			assertThat(_list.add(1), equalTo(true));
			assertThat(_list.add(2), equalTo(true));
		}
		
		[Test]
		public function testContains():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_list.contains(1), equalTo(true));
			assertThat(_list.contains(5), equalTo(true));
			assertThat(_list.contains(0), equalTo(false));
		}
		
		[Test]
		public function testEquals():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_list.equals(_list), equalTo(true));
			assertThat(_list.equals(new ListMock([1, 2, 3, 4, 5])), equalTo(true));
			assertThat(_list.equals(new ListMock([5, 4, 3, 2, 1])), equalTo(false));
			assertThat(_list.equals(new ListMock()), equalTo(false));
		}
		
		[Test]
		public function testFirst():void
		{
			assertThat(new ListMock([1, 2]).first(), equalTo(1));
			assertThat(new ListMock([1, 2]).first(2), array(1, 2));
			assertThat(new ListMock([1, 2]).first(3), array(1, 2));
			assertThat(new ListMock().first(), equalTo(undefined));
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
		public function testLast():void
		{
			assertThat(new ListMock([1, 2]).last(), equalTo(2));
			assertThat(new ListMock([1, 2]).last(2), array(1, 2));
			assertThat(new ListMock([1, 2]).last(3), array(1, 2));
			assertThat(new ListMock().last(), equalTo(undefined));
		}
		
		[Test]
		public function testPop():void
		{
			assertThat(_list.pop(), equalTo(undefined));
			
			_list.addAll([1, 2, 3]);
			assertThat(_list.pop(), equalTo(3));
			assertThat(_list.toArray(), array(1, 2));
		}
		
		[Test]
		public function testRange():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_list.range(0).toArray(), array(1, 2, 3, 4, 5));
			assertThat(_list.range(0, 1).toArray(), array(1));
			assertThat(_list.range(4).toArray(), array(5));
		}
		
		[Test]
		public function testRemove():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(_list.remove(1), equalTo(true));
			assertThat(_list.remove(1), equalTo(false));
			assertThat(_list.remove(5), equalTo(true));
			assertThat(_list.toArray(), array(2, 3, 4));
		}
		
		[Test]
		public function testSetItemAt():void
		{
			assertThat(_list.setItemAt(2, 0), equalTo(undefined));
			assertThat(_list.setItemAt(1, 0), equalTo(2));
			assertThat(_list.setItemAt(2, 1), equalTo(undefined));
			assertThat(_list.setItemAt(3, 2), equalTo(undefined));
			assertThat(_list.setItemAt(3, 0), equalTo(1));
			assertThat(_list.setItemAt(2, 1), equalTo(2));
			assertThat(_list.setItemAt(1, 2), equalTo(3));
			assertThat(_list.toArray(), array(3, 2, 1));
		}
		
		[Test]
		public function testShift():void
		{
			assertThat(_list.shift(), equalTo(undefined));
			
			_list.addAll([1, 2, 3]);
			assertThat(_list.shift(), equalTo(1));
			assertThat(_list.toArray(), array(2, 3));
		}
		
		[Test]
		public function testArrayAccessOperator():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			assertThat(_list[0], equalTo(1));
			assertThat(_list[4], equalTo(5));
		}
		
		[Test(expects="ArgumentError")]
		public function testArrayAccessOperatorThrowsError():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			assertThat(_list[new Element(1)], equalTo(1));
		}
		
		[Test]
		public function testArrayDeleteOperator():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			delete _list[0];
			assertThat(_list.toArray(), array(2, 3, 4, 5));
			
			delete _list[3];
			assertThat(_list.toArray(), array(2, 3, 4));
		}
		
		[Test]
		public function testArrayInOperator():void
		{
			_list.addAll([1, 2, 3, 4, 5]);
			
			assertThat(0 in _list, equalTo(true));
			assertThat(4 in _list, equalTo(true));
			assertThat(5 in _list, equalTo(false));
		}
		
		[Test]
		public function testArraySetOperator():void
		{
			_list[0] = 2;
			assertThat(_list.toArray(), array(2));
			
			_list[1] = 2;
			assertThat(_list.toArray(), array(2, 2));
			
			_list[0] = 1;
			assertThat(_list.toArray(), array(1, 2));
		}
	}
}

import collections.List;

class ListMock extends List
{
	private var _items:Array = [];
	
	public function ListMock(items:Array = null)
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