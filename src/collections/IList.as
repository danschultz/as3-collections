package collections
{
	/**
	 * An interface that defines an orderered collection of elements.
	 * 
	 * @author Dan Schultz
	 */
	public interface IList extends ICollection
	{
		/**
		 * Returns the element of this list that is stored at the given index.
		 * If the index is less than 0 or is greater than or equal to the size of 
		 * the list, a <code>RangeError</code> is thrown.
		 * 
		 * @param index The position of the item to return.
		 * @return The item at the given position.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	or equal to the size of the list.
		 */
		function at(index:int):*;
		
		/**
		 * Adds all the elements in the given object to this list at the given index.
		 * This method accepts an <code>Array</code>, <code>Collection</code>, or any 
		 * object that supports a <code>for each..in</code> iteration.
		 * 
		 * @param items The items to add.
		 * @param index The index to insert the items at.
		 */
		function addAllAt(items:Object, index:int):void;
		
		/**
		 * Adds the given element to this list at the given index.
		 * 
		 * @param item The element to add.
		 * @param index The index to add the element at.
		 * @throws RangeError If <code>(index < 0 || index > length)</code>
		 */
		function addAt(item:Object, index:int):void;
		
		/**
		 * Returns the first <code>n</code> elements from this list. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the list is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		function first(count:int = 1):*;
		
		/**
		 * Searches for the first occurrence in this list of the given element. This
		 * method check if the given element has an <code>equals()</code> method. If
		 * so, it will attempt to use this method to see if two objects are equal.
		 * 
		 * @param item The element to get the index of.
		 * @return The index of the first occurrence of the element. If the element is
		 * 	not found, <code>-1</code> is returned.
		 */
		function indexOf(item:Object):int;
		
		/**
		 * Returns the last <code>n</code> elements from this list. If <code>n</code>
		 * is greater than 1, the return type is an array of elements. Otherwise only the
		 * element is returned, or <code>undefined</code> if the list is empty.
		 * 
		 * @param count The number of elements to return.
		 * @return An element, an array of elements, or <code>undefined</code>.
		 */
		function last(count:int = 1):*;
		
		/**
		 * Removes and returns the last element in the list. If the list is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The last element in the list, or <code>undefined</code>.
		 */
		function pop():*;
		
		/**
		 * Returns a new list that contains the elements from this list between
		 * the starting index (inclusive) and the ending index (exclusive).
		 * 
		 * @param start The starting index. If a negative number, the starting 
		 * 	point begins at the end of the list, where -1 is the last element.
		 * @param end The ending index. If you omit this parameter, the range 
		 * 	includes all elements from the starting point to the end of the list. 
		 * 	If the index is a negative number, the ending point is specified from 
		 * 	the end of the list, where -1 is the last element.
		 * @return A new list.
		 */
		function range(start:int, end:int = int.MAX_VALUE):IList;
		
		/**
		 * Removes the element of this list that is stored at the given position.
		 * 
		 * @param index The position of the item to remove.
		 * @return The object removed.
		 * @throws RangeError If <code>(index < 0 || index >= length)</code>
		 */
		function removeAt(index:int):*;
		
		/**
		 * Replaces an element at the given position with the specified element. If
		 * the index is the size of the list, the element is added to the end of the
		 * list and <code>undefined</code> is returned.
		 * 
		 * @param item The new item.
		 * @param index The position of the item to replace.
		 * @return The element that was replaced.
		 * @throws RangeError If <code>index</code> is less than 0 or greater than
		 * 	the size of the list.
		 */
		function setItemAt(item:Object, index:int):*;
		
		/**
		 * Removes and returns the first element in the list. If the list is empty,
		 * <code>undefined</code> is returned.
		 * 
		 * @return The first element in the list, or <code>undefined</code>.
		 */
		function shift():*;
		
		/**
		 * Returns a new list that is sorted according to the given function. This
		 * function should have the following signature: 
		 * <code>function comparator(a:Object, b:Object):int</code>. If the returned
		 * integer is negative, then <code>a</code> preceeds <code>b</code>. If the
		 * returned integer is 0, then <code>a</code> has the same sort order as
		 * <code>b</code>. If positive, then <code>a</code> appears after <code>b</code>. 
		 * 
		 * @param comparator The comparator function.
		 * @return A new sorted list.
		 */
		function sort(comparator:Function):IList;
	}
}