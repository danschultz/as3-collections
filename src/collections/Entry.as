package collections
{
	/**
	 * A class that represents a key-value mapping.
	 * 
	 * @author Dan Schultz
	 */
	public class Entry
	{
		/**
		 * The key for the entry.
		 */
		public var key:Object;
		
		/**
		 * The value for the entry.
		 */
		public var value:Object;
		
		/**
		 * Constructor.
		 * 
		 * @param key The key for the entry.
		 * @param value The value for the entry.
		 */
		public function Entry(key:Object, value:Object)
		{
			this.key = key;
			this.value = value;
		}
		
		/**
		 * @private
		 */
		public function toString():String
		{
			return key + "=>" + value;
		}
	}
}