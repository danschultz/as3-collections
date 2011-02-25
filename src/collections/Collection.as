package collections
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Provides a base implementation for all collection classes.  This collection 
	 * delegates the insertion, removal and retrieval of items to its sub-classes.
	 * As such the following methods <em>must</em> be overridden and implemented to
	 * have a functional collections class:
	 * 
	 * <ul>
	 * <li><code>Collection.add()</code></li>
	 * <li><code>Collection.remove()</code></li>
	 * <li><code>Collection.toArray()</code></li>
	 * <li><code>Collection.length</code></li>
	 * </ul>
	 * 
	 * <p>
	 * <code>Collection.contains()</code> provides a default implementation for a
	 * collection. It iterates through each item of the collection and performs the
	 * following:
	 * 
	 * <ol>
	 * <li>Checks if the two elements are the same object reference.</li>
	 * <li>If not, it checks if the two elements have an <code>equals()</code> method.</li>
	 * <li>If so, it invokes the <code>equals()</code> on each of the objects.</li>
	 * </ol>
	 * 
	 * Sub-classes should override the <code>contains()</code> method, if a more
	 * efficient way can be performed.
	 * </p>
	 * 
	 * <p>
	 * Classes that extend from <code>Collection</code> also support iteration using
	 * <code>for..in</code> and <code>for each..in</code>. The <code>Collection.toArray()</code>
	 * method must be overridden to support this.
	 * </p>
	 * 
	 * <p>
	 * <strong>Example:</strong> Iterating a collection.
	 * 
	 * <listing version="3.0">
	 * var list:ArrayList = new ArrayList();
	 * list.add(1);
	 * list.add(2);
	 * list.add(3);
	 * 
	 * for each (var num:Number in list) {
	 * 	trace("num: " + num);
	 * }
	 * </listing>
	 * </p>
	 * 
	 * <p>
	 * In addition to iteration, some sub-classes support writing and reading from an AMF stream 
	 * (i.e. externalization). This can be accomplished through a <code>ByteArray</code> or through 
	 * a Flash Remoting service. It is up to the sub-class to support this functionality. To support
	 * this, sub-classes must implement <code>IExternalizable</code> and have the 
	 * <code>[RemoteClass]</code> metadata. This class will handle the heavy lifting of serializing 
	 * the collection and its elements.
	 * </p>
	 * 
	 * <p>
	 * The following collections support externalization:
	 * 
	 * <ul>
	 * <li><code>ArrayList</code></li>
	 * <li><code>ArraySet</code></li>
	 * <li><code>HashSet</code></li>
	 * </ul>
	 * </p>
	 * 
	 * <p>
	 * <strong>Example:</strong> Writing a collection to a <code>ByteArray</code>:
	 * 
	 * <listing version="3.0">
	 * var list:ArrayList = new ArrayList([1, 2, 3]);
	 * var bytes:ByteArray = new ByteArray();
	 * bytes.writeObject(list);
	 * 
	 * bytes.position = 0;
	 * var copiedList:ArrayList = bytes.readObject();
	 * trace(copiedList); // 1, 2, 3
	 * </listing>
	 * 
	 * @author Dan Schultz
	 */
	public class Collection extends Proxy implements ICollection
	{
		/**
		 * Creates a new collection that is populated with the given items. The collection
		 * is populated by performaing a <code>for each..in</code> operation on the <code>items</code>.
		 * 
		 * @param items The items to populate this collection with.
		 */
		public function Collection(items:Object = null)
		{
			addAll(items);
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(item:Object):Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAll(items:Object):Boolean
		{
			var affected:Boolean = false;
			for each (var item:Object in items) {
				affected = add(item) || affected;
			}
			return affected;
		}
		
		/**
		 * Checks if two collection elements are equal. Two elements are considered equal if:
		 * 
		 * <ol>
		 * <li><code>item1 === item2</code>, or</li>
		 * <li><code>item1</code> and <code>item2</code> have an <code>equals()</code> 
		 * 	method and <code>item1.equals(item2)</code> equates to <code>true</code>.</li>
		 * </ol>
		 * 
		 * @param item1 The first element.
		 * @param item2 The second element.
		 * @return <code>true</code> if <code>item1</code> equals <code>item2</code>.
		 */
		public static function areElementsEqual(item1:Object, item2:Object):Boolean
		{
			if (item1 === item2) {
				return true;
			}
			
			if (item1 != null && item2 != null && item1.hasOwnProperty("equals") && item2.hasOwnProperty("equals")) {
				if (item1.equals(item2)) {
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear():void
		{
			removeAll(this);
		}
		
		/**
		 * Generates a shallow copy of this collection by creating a new instance of the
		 * collection sub-class and passing in the array of its elements to the sub-classes
		 * constructor.
		 * 
		 * @inheritDoc
		 */
		public function clone():ICollection
		{
			var clazz:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			return new clazz(toArray());
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:Object):Boolean
		{
			for each (var obj:Object in this) {
				if (areElementsEqual(item, obj)) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsAll(items:Object):Boolean
		{
			for each (var item:Object in items) {
				if (!contains(item)) {
					return false;
				}
			}
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function difference(items:Object):ICollection
		{
			removeAll(items);
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function equals(collection:ICollection):Boolean
		{
			if (this === collection) {
				return true;
			}
			
			if (getQualifiedClassName(this) == getQualifiedClassName(collection) && length == collection.length) {
				var items1:Array = toArray();
				var items2:Array = collection.toArray();
				var len:int = length;
				for (var i:int = 0; i < len; i++) {
					if (areElementsEqual(items1[i], items2[i])) {
						return false;
					}
				}
				return true;
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function intersection(items:Object):ICollection
		{
			var temp:ArrayList = new ArrayList(items);
			for each (var item:Object in this) {
				if (!temp.contains(item)) {
					remove(item);
				}
			}
			return this;
		}
		
		/**
		 * @copy flash.utils.IExternalizable#readExternal()
		 */
		public function readExternal(input:IDataInput):void
		{
			addAll(input.readObject());
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(item:Object):Boolean
		{
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll(items:Object):Boolean
		{
			var affected:Boolean = false;
			for each (var item:Object in items) {
				affected = remove(item) || affected;
			}
			return affected;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray():Array
		{
			// have to return an empty array. we can't provide a default implementation,
			// because the proxy would run into an infinite loop, since it relies on this
			// method.
			return [];
		}
		
		/**
		 * @private
		 */
		public function toString():String
		{
			return toArray().toString();
		}
		
		/**
		 * @copy flash.utils.IExternalizable#writeExternal()
		 */
		public function writeExternal(output:IDataOutput):void
		{
			output.writeObject(toArray());
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isEmpty():Boolean
		{
			return length == 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length():int
		{
			return 0;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextName(index:int):String
		{
			return (index-1).toString();
		}
		
		private var _iteratingItems:Array;
		private var _len:int;
		/**
		 * @private
		 */
		override flash_proxy function nextNameIndex(index:int):int
		{
			if (index == 0) {
				_iteratingItems = toArray();
				_len = _iteratingItems.length;
			}
			return index < _len ? index+1 : 0;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextValue(index:int):*
		{
			return _iteratingItems[index-1];
		}
	}
}
