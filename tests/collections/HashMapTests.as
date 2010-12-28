package collections
{
	
	import org.flexunit.assertThat;
	import org.hamcrest.collection.hasItem;
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
			_map.put(new Element(1), "a");
			
			assertThat(_map.containsKey(1), equalTo(true));
			assertThat(_map.containsKey(new Element(1)), equalTo(true));
			assertThat(_map.containsKey(new Element(2)), equalTo(false));
		}
		
		[Test]
		public function testContainsValue():void
		{
			_map.put(1, "a");
			assertThat(_map.containsValue("a"), equalTo(true));
			assertThat(_map.containsValue("b"), equalTo(false));
		}
		
		[Test]
		public function testEquals():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			
			assertThat(_map.equals(_map.clone()), equalTo(true));
		}
		
		[Test]
		public function testDoesNotEqualsWhenDifferentLengths():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			
			var clone:HashMap = _map.clone();
			clone.remove(1);
			assertThat(_map.equals(clone), equalTo(false));
		}
		
		[Test]
		public function testDoesNotEqualsWhenDifferentKeysAndSameLength():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			
			var map:HashMap = new HashMap();
			map.put(2, "b");
			map.put(3, "c");
			map.put(4, "d");
			
			assertThat(_map.equals(map), equalTo(false));
		}
		
		[Test]
		public function testDoesNotEqualsWhenDifferentValuesAndSameLength():void
		{
			_map.put(1, "a");
			_map.put(2, "b");
			_map.put(3, "c");
			
			var map:HashMap = new HashMap();
			map.put(1, "c");
			map.put(2, "b");
			map.put(3, "a");
			
			assertThat(_map.equals(map), equalTo(false));
		}
		
		[Test]
		public function testGrab():void
		{
			_map.put(1, "a");
			_map.put(new Element(1), "b");
			
			assertThat(_map.grab(1), equalTo("a"));
			assertThat(_map.grab(new Element(1)), equalTo("b"));
		}
		
		[Test]
		public function testGrabWithCollidingHashes():void
		{
			_map.put(new Element(1, "a"), "a");
			_map.put(new Element(1, "b"), "b");
			_map.put(new Element(1, "c"), "c");
			
			assertThat(_map.grab(new Element(1, "a")), equalTo("a"));
			assertThat(_map.grab(new Element(1, "b")), equalTo("b"));
			assertThat(_map.grab(new Element(1, "c")), equalTo("c"));
			assertThat(_map.grab(new Element(1)), equalTo(undefined));
		}
		
		[Test]
		public function testKeys():void
		{
			var keys:Array = [1, 2, new Element(1)];
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
			
			assertThat(_map.put(new Element(1), "c"), nullValue());
			assertThat(_map.length, equalTo(2));
		}
		
		[Test]
		public function testRemove():void
		{
			_map.put(1, "a");
			_map.put(new Element(1), "b");
			_map.put(2, "c");
			
			assertThat(_map.remove(1), equalTo("a"));
			assertThat(_map.remove(new Element(1)), equalTo("b"));
			assertThat(_map.remove(2), equalTo("c"));
			assertThat(_map.length, equalTo(0));
		}
		
		[Test]
		public function testRemoveWithCollidingHashes():void
		{
			var tests:Array = [
				{insert:[new Element(1, "a"), new Element(2, "b"), new Element(3, "c")], remove:[new Element(1, "a"), new Element(2, "b"), new Element(3, "c")]},
				{insert:[new Element(1, "a"), new Element(2, "b"), new Element(3, "c")], remove:[new Element(2, "b"), new Element(1, "a"), new Element(3, "c")]},
				{insert:[new Element(1, "a"), new Element(2, "b"), new Element(3, "c")], remove:[new Element(3, "c"), new Element(1, "a"), new Element(2, "b")]}
			];
			
			for each (var test:Object in tests) {
				for each (var elementToInsert:Element in test.insert) {
					_map.put(elementToInsert, elementToInsert.str);
				}
				
				assertThat(_map.length, equalTo(test.insert.length));
				
				for each (var elementToRemove:Element in test.remove) {
					assertThat(_map.remove(elementToRemove), equalTo(elementToRemove.str));
				}
				
				assertThat(_map.isEmpty, equalTo(true));
			}
		}
		
		[Test]
		public function testValues():void
		{
			_map.put(1, "a");
			_map.put(new Element(1), "b");
			_map.put(2, "c");
			
			var values:Array = _map.values();
			for each (var value:Object in _map) {
				assertThat(values, hasItem(value));
			}
		}
		
		[Test]
		public function testKeyIsReservedKeywordOnObject():void
		{
			var tests:Array = ["hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "setPropertyIsEnumerable", "toLocaleString", "toString", "valueOf"];
			for each (var test:String in tests) {
				var error:Error;
				try {
					new HashMap().put(test, 1);
				} catch (e:Error) {
					error = e;
				}
				assertThat("test failed for keyword '" + test + "'", error, nullValue());
			}
		}
	}
}