package tests.collections
{
	public class Element
	{
		public var num:int;
		public var str:String;
		
		public function Element(num:int, str:String = "")
		{
			this.num = num;
			this.str = str;
		}
		
		public function equals(item:Element):Boolean
		{
			return num == item.num && str == item.str;
		}
		
		public function hashCode():Object
		{
			return num;
		}
	}
}