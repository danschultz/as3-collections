package collections
{
	/**
	 * The base interface in the collection hierarchy. A collection represents a group 
	 * of objects. Different types of collections exist that define if objects are 
	 * unique or ordered within the collection.
	 * 
	 * @author Dan Schultz
	 */
	public interface ICollection
	{
		/**
		 * Adds the given item to this collection.
		 * 
		 * @param item The item to insert.
		 * @return <code>true</code> if the item was inserted.
		 */
		function add(item:Object):Boolean;
		
		/**
		 * Adds all items in the given collection to this collection.
		 * 
		 * @param items The items to insert.
		 * @return <code>true</code> if any item was inserted.
		 */
		function addAll(items:ICollection):Boolean;
		
		/**
		 * Clears the items from the collection.
		 */
		function clear():void;
		
		/**
		 * Checks to see if the given item is contained within this collection.
		 * 
		 * @param item The item to check.
		 * @return <code>true</code> if the item was found.
		 */
		function contains(item:Object):Boolean;
		
		/**
		 * Checks to see if this collection contains all the items in the given 
		 * collection.
		 * 
		 * @param items The collection to check against.
		 * @return <code>true</code> if this collection contains all items in the
		 * 	given collection.
		 */
		function containsAll(items:ICollection):Boolean;
		
		/**
		 * Removes any items from this collection that belong to this collection
		 * and the given collection.
		 * 
		 * @param items The items to diff with.
		 */
		function difference(items:ICollection):void;
		
		/**
		 * Checks two collections for equality. Two collections are equal when the 
		 * collections have the same type, have the same size, and have the same 
		 * order of objects.
		 * 
		 * @param collection The collection to compare.
		 * @return <code>true</code> if two collections are equal.
		 */
		function equals(collection:ICollection):Boolean;
		
		/**
		 * Removes any items from this collection that do not belong to the given collection.
		 * 
		 * @param items The items to intersect with.
		 */
		function intersection(items:ICollection):void;
		
		/**
		 * Removes the given item from this collection.
		 * 
		 * @param item The item to remove.
		 * @return <code>true</code> if the item was removed.
		 */
		function remove(item:Object):Boolean;
		
		/**
		 * Removes all the items in the given collection from this collection.
		 * 
		 * @param items The items to remove.
		 * @return <code>true</code> if the collection was affected.
		 */
		function removeAll(items:ICollection):Boolean;
		
		/**
		 * Returns a new array containing all the items of this collection.
		 * 
		 * @return A new array.
		 */
		function toArray():Array;
		
		/**
		 * <code>true</code> if this collection doesn't contain any items.
		 */
		function get isEmpty():Boolean;
		
		/**
		 * The number of items in this collection.
		 */
		function get length():int;
	}
}