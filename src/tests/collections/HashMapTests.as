package tests.collections
{
	import collections.HashMap;
	
	import flash.utils.Dictionary;
	
	import flashx.textLayout.debug.assert;
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class HashMapTests
	{
		private var _map:HashMap;
		
		[Before]
		public function setUp():void
		{
			_map = new HashMap();
		}
		
		[Test]
		public function testClear():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			_map.clear();
			
			assertThat(_map.length, equalTo(0));
		}
		
		[Test]
		public function testClone():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			
			var clonedMap:HashMap = _map.clone();
			assertThat(clonedMap.length, equalTo(_map.length));
			for (var key:Object in _map) {
				assertThat("cloned map does not contain value for key", _map.containsKey(key), equalTo(true));
			}
		}
		
		[Test]
		public function testContainsKey():void
		{
			_map.put(1, "a");
			_map.put(new ItemA(1), "a");
			
			assertThat(_map.containsKey(1), equalTo(true));
			assertThat(_map.containsKey(new ItemA(1)), equalTo(true));
			assertThat(_map.containsKey(new ItemA(2)), equalTo(false));
		}
		
		[Test]
		public function testContainsValue():void
		{
			_map.put(1, "a");
			assertThat(_map.containsValue("a"), equalTo(true));
			assertThat(_map.containsValue("b"), equalTo(false));
		}
		
		[Test]
		public function testGrab():void
		{
			_map.put(1, "a");
			_map.put(new ItemA(1), "b");
			
			assertThat(_map.grab(1), equalTo("a"));
			assertThat(_map.grab(new ItemA(1)), equalTo("b"));
		}
		
		[Test]
		public function testKeys():void
		{
			var keys:Array = [1, 2, new ItemA(1)];
			var values:Array = ["a", "b", "c"];
			for (var i:int = 0; i < keys.length; i++) {
				_map.put(keys[i], values[i]);
			}
			
			var keysInMap:Array = _map.keys();
			assertThat(keysInMap.length, equalTo(_map.length));
			for each (var key:* in keysInMap) {
				assertThat(keys, hasItem(key));
			}
		}
		
		[Test]
		public function testPut():void
		{
			_map.put(1, "a");
			assertThat(_map.put(1, "b"), equalTo("a"));
			assertThat(_map.length, equalTo(1));
			
			assertThat(_map.put(new ItemA(1), "c"), nullValue());
			assertThat(_map.length, equalTo(2));
		}
		
		[Test]
		public function testRemove():void
		{
			_map.put(1, "a");
			_map.put(new ItemA(1), "b");
			_map.put(2, "c");
			
			assertThat(_map.remove(1), equalTo("a"));
			assertThat(_map.remove(new ItemA(1)), equalTo("b"));
			assertThat(_map.remove(2), equalTo("c"));
			assertThat(_map.length, equalTo(0));
		}
		
		[Test]
		public function testValues():void
		{
			_map.put(1, "a");
			_map.put(new ItemA(1), "b");
			_map.put(2, "c");
			
			var values:Array = _map.values();
			for each (var value:Object in _map) {
				assertThat(values, hasItem(value));
			}
		}
	}
}

class ItemA
{
	public var num:int;
	
	public function ItemA(num:int)
	{
		this.num = num;
	}
	
	public function equals(itemA:ItemA):Boolean
	{
		return num == itemA.num;
	}
	
	public function hashCode():Object
	{
		return num;
	}
}