package com.darcey.debug
{
	// Author: Darcey.Lloyd@gmail.com

	public class TraceAllChildrenIn
	{
		public function TraceAllChildrenIn(target:*)
		{
			trace("TraceAllChildrenIn(target:"+target+")");
			
			try {
				var sName:String;
				var sID:String;
				
				
				for (var i:int = 0; i <= (target.numChildren-1); i++)
				{
					try {
						sName = target.getChildAt(i).name;
					} catch (e:Error) { sName = ""; }
					
					try {
						sID = target.getChildAt(i).id;
					} catch (e:Error) { sID = ""; }
					
					trace("\t" + "childAt("+i+"): name = " + sName + "\t\t" + target.getChildAt(i));
					//trace("\t" + "childAt("+i+"): name = " + sName + "\t\t" + target.getChildAt(i) + "\t" + "\t\t" + "id = " + sID);
				}
			} catch (e:Error) {
				trace("TraceAllChildrenIn(target:*): Target ["+target+"] has no children!");
			}
		}
	}
}