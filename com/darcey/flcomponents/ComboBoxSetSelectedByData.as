package com.darcey.flcomponents
{
	import fl.controls.ComboBox;

	public class ComboBoxSetSelectedByData
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		public function ComboBoxSetSelectedByData(cb:ComboBox,data:String)
		{
			//trace("LanguageMenu().setSelected(" + languageCode + ")");
			cb.selectedIndex = getItemIndex(data);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		// ---------------------------------------------------------------------------------------------------------------------------
		// Due to the this component sucking we have to loop through all it's elements
		private function getItemIndex(dataSelected:String):int
		{
			var index:int = 0;
			for (var i:int = 0; i < this.length; i++)
			{
				if (this.getItemAt(i).data.toString() == dataSelected)
				{
					////trace("this.getItemAt("+i+").data = " + this.getItemAt(i).data);
					index = i;
					break;
				}
			}
			return index;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
	}
}