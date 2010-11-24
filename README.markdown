# Collections Framework for ActionScript 3
This framework provides a simple and tested library for representing groups of objects 
in AS3 and Flex.

## Types of Collections
As of now, this framework supports the more common types of collections. These include:

* Maps
	* `HashMap` - Maps a key's hash to a value.
	* `ImmutableMap` - Wraps a map to make it unmodifiable.
* Lists
	* `ArrayList` - A mutable list of elements.
	* `ImmutableList` - Wraps a list to make it unmodifiable.
* Sets
	* `HashSet` - A collection that contain no duplicate elements, and doesn't preserve iteration order.
	* `ArraySet` - Similar to HashSet, but preserves the order of iteration for its elements.
	* `ImmutableSet` - Wraps a set to make it unmodifiable.

More performance tuned collections may be introduced in the future. These could include 
`TreeMap`s, `LinkedList`s, etc. However, the current set of collections, I feel, cover the vast 
majority of use cases in Flex.

Queues can be accomplished through `List` and its subclasses.

### Immutable Collections
Each generic type of collection has an unmodifiable class that can wrap it.

**Example** Creating an immutable collection.
	function createMap():IMap
	{
		var map:HashMap = new HashMap({a:1, b:2, c:3, d:4, e:5});
		return new ImmutableMap(map);
	}

This approach limits the number of classes required to provide immutability to the framework. In
addition, these wrappers will work out of the box for custom collections that are created by other
developers. This also allows clients to create and use a modifiable collection within a class. But,
provide immutable access to these collections via accessor methods.

**Example** Using immutable and mutable collections within a class.
	class Post
	{
		private var _comments:ArraySet = new ArraySet();
		
		public function Post()
		{
			
		}
		
		public function comment(text:String, commenter:User):void
		{
			_comments.add(new Comment(text, commenter));
		}
		
		public function get comments():ISet
		{
			return new ImmutableSet(_comments);
		}
	}

## Design Goals

### Equality
A primary goal when implementing these collections was giving clients better control on
object equality and hashing. In addition to an objects' identity (`===`), elements are 
checked for the existance of an `equals()` method. If this method exists, it is used 
for comparing the equality between two elements.

**Example**
Take the case where you have a `Person` object. How does equality in this library compare
to equality in AS3/Flex?

	class Person
	{
		public var id:int;
		
		public function Person(id:int)
		{
			this.id = id;
		}
		
		public function equals(p:Person):Boolean
		{
			return p != null && id == p.id;
		}
	}
	
	// a HashSet from as3-collections
	var personSet:HashSet = new HashSet([new Person(1)]);
	trace(personSet.contains(new Person(1))); // true
	
	// a Flex collection
	var personCollection:ArrayCollection = new ArrayCollection([new Person(1)]);
	trace(personCollection.contains(new Person(1))); // false
	
	// an AS3 array
	var personArray:Array = [new Person(1)];
	trace(personArray.indexOf(new Person(1)) != -1); // false
	
### Hashing
An equally important goal was to give clients more control with object hashing. Keys that 
are inserted into a map are checked for the existence of a `hashCode()` method. If the method
exists, its result turns into the hash for the key-value pair. In conjunction with `equals()`,
this functionality allows for colliding hashes.

**Example** How maps compare to `Dictionary`'s.

	class Animal
	{
		public var id:int;
		
		public function Animal(id:int)
		{
			this.id = id;
		}
		
		public function hashCode():Object
		{
			return id;
		}
	}
	
	class Dog extends Animal
	{
		public function equals(dog:Dog):Boolean
		{
			return dog != null && id == dog.id;
		}
	}
	
	class Cat extends Animal
	{
		public function equals(cat:Cat):Boolean
		{
			return cat != null && id == cat.id;
		}
	}
	
	// Maps support colliding hashes and custom object equality.
	var map:HashMap = new HashMap();
	map.put(new Dog(1), "Baron");
	map.put(new Cat(1), "Jake");
	trace(map.grab(new Dog(1))); // Baron
	
	// Dictionaries only support object identity.
	var dictionary:Dictionary = new Dictionary();
	dictionary[new Dog(1)] = "Baron";
	dictionary[new Cat(1)] = "Jake";
	trace(dictionary[new Dog(1)]); // undefined
	
	// Dictionaries also can't support colliding hashes.
	dictionary[new Dog(1).hashCode()] = "Baron";
	dictionary[new Cat(1).hashCode()] = "Jake";
	trace(dictionary[new Dog(1).hashCode()]); // Jake

### Syntax Sugar
I wanted to make working with these collections simple and familiar. There are touches of 
syntax sugar sprinkled throughout the API.

#### Iteration
All collections support `for each..in` loops. Additionally, copies of the collection are 
created during iteration. This allows for safe removal of an element within a loop.

**Example** Iterating a collection.
	var list:ArrayList = new ArrayList([1, 2, 3, 4, 5]);
	for each (var num:int in list) {
		trace(num);
	}

**Example** Safe removal of elements.
	var set:ArraySet = new ArraySet([1, 2, 3, 4, 5]);
	for each (var num:int in set) {
		if (num == 2) {
			list.remove(2);
		} else {
			trace(num);
		}
	}
	
	// traces:
	// 1
	// 3
	// 4
	// 5

#### Smart
When possible, collections try to interpret the type of data you pass to it.

**Example** `Array`'s are interoperable with `Collection`'s.
	var list:ArrayList = new ArrayList();
	list.addAll([1, 2, 3, 4, 5]);
	list.containsAll([1, 2, 3, 4, 5]); // true;
	trace(list.difference([1, 2])); // 3, 4, 5

#### Access Operators.
All lists support bracket (`[]`) access of their elements.

**Example** Reading and writing elements to a list using brackets (`[]`).
	var list:ArrayList = new ArrayList([1, 2, 3, 4, 5]);
	list[0] = 5;
	list[4] = 1;
	trace(list[1]); // 2

#### Externalization.
All collections support reading and writing to a `ByteArray`. This sets up the framework
for sending collections over the wire in AMF. Clients will need to map the collections 
on the server.

**Example** Reading and writing to a `ByteArray`.
	var set:HashSet = new HashSet([1, 2, 3, 4, 5]);
	var bytes:ByteArray = new ByteArray();
	bytes.writeObject(set);
	
	bytes.position = 0;
	var newSet:HashSet = bytes.readObject();
	trace(newSet); // 1, 2, 3, 4, 5

### Easy Sub-Classing
An important design constraint was making these collections easy to sub-class for developers.
As such, each collection type has a small and specific set of methods that must be implemented.
All are well documented within the collection base classes (i.e. `Map`, `Collection`, `Set`, `List`).
