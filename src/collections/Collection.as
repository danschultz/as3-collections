package collections
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
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
	 * @author Dan Schultz
	 */
	public class Collection extends Proxy implements ICollection
	{
		/**
		 * Constructor.
		 * 
		 * @param collection The collection of items to add to this collection.
		 */
		public function Collection(collection:ICollection = null)
		{
			if (collection != null) {
				addAll(collection);
			}
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
		final public function addAll(items:ICollection):Boolean
		{
			var affected:Boolean = false;
			for each (var item:Object in items) {
				affected = add(item) || affected;
			}
			return affected;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function clear():void
		{
			for each (var item:Object in this) {
				remove(item);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains(item:Object):Boolean
		{
			for each (var obj:Object in this) {
				if (obj === item) {
					return true;
				}
				
				if (obj.hasOwnProperty("equals") && item.hasOwnProperty("equals")) {
					try {
						if (obj.equals(item)) {
							return true;
						}
					} catch (e:Error) {
						
					}
				}
			}
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		final public function containsAll(items:ICollection):Boolean
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
		final public function difference(items:ICollection):void
		{
			for each (var item:Object in this) {
				if (items.contains(item)) {
					remove(item);
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		final public function equals(collection:ICollection):Boolean
		{
			if (this === collection) {
				return true;
			}
			
			if (getQualifiedClassName(this) == getQualifiedClassName(collection) && length == collection.length) {
				var items1:Array = toArray();
				var items2:Array = collection.toArray();
				var len:int = length;
				for (var i:int = 0; i < len; i++) {
					if (items1[i] !== items2[i]) {
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
		final public function intersection(items:ICollection):void
		{
			for each (var item:Object in this) {
				if (!items.contains(item)) {
					remove(item);
				}
			}
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
		final public function removeAll(items:ICollection):Boolean
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
		 * @inheritDoc
		 */
		final public function get isEmpty():Boolean
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
		 *  @private
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