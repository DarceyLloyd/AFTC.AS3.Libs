package com.darcey.flcomponents
{
	import fl.controls.ComboBox;
	import fl.data.DataProvider;

	public class PopuplateComboBox
	{
		public function PopuplateComboBox(cb:ComboBox,labels:Array,data:Array,prompt:String = "Select")
		{
			var dp:DataProvider = new DataProvider();
			for (var i:Number = 0; i < labels.length; i++ ) {
				dp.addItem( { label: labels[i], data:data[i] } );
			}
			
			//dp.sortOn("label",Array.DESCENDING);
			dp.sortOn("label");
			cb.useHandCursor = true;
			cb.dataProvider = dp;
			//cb.selectedIndex = 0;
			//cb.prompt = " ";
			
			// Fix for prompt must be " " instead of "" if developer wants it blank
			if (prompt == ""){
				prompt = " ";
			}
			
			cb.prompt = prompt;
		}
	}
}