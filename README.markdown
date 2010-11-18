# Collections Framework for ActionScript 3
This framework provides a simple and tested library for representing groups of objects 
in AS3 and Flex.

## Design Goals
A major goal when implementing these collections was giving clients better control on
object equality and hashing. As opposed to object identity (`===`). When inserting elements
into these collections, object's are checked for the existance of an `equals()` method.
If this method exists, it is used for comparing two object's equality.

**Example**
Take the case where you have a `Person` object. How are they equal?

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
	
	var people:ArrayList = new ArrayList();
	people.add(new Person(1));
	
	trace(people.contains(new Person(1)); // true
	trace(people.contains(new Person(2)); // false
	trace([new Person(1)].indexOf(new Person(1)); // -1

## Types of Collections
As of now, this framework supports the more common types of collections. These include:

* Maps
	* `HashMap` – Maps a key's hash to a value.
* Lists
	* `ArrayList` – A mutable list of elements.
* Sets
	* `HashSet` – A collection that contain no duplicate elements, and doesn't preserve iteration order.
	* `ArraySet` – Similar to HashSet, but preserves the order of iteration for its elements.

More performance tuned collections may be introduced in the future. These may include 
`TreeMap`s, `LinkedList`s, etc. However, the current set of collections should cover the vast 
majority of use cases needed in Flex.

Queues can be accomplished through `List` and its subclasses.