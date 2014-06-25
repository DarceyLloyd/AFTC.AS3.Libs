package com.darcey.ui
{
	// Author: Darcey.Lloyd@gmail.com

	// ------------------------------------------------------------------------------------------------------------------------------
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.HSlider;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	// ------------------------------------------------------------------------------------------------------------------------------
	
	
	// ------------------------------------------------------------------------------------------------------------------------------
	public class SliderList extends Sprite
	{
		// ------------------------------------------------------------------------------------------------------------------------------
		private var componentsArray:Array;
		private var componentIndex:int = 0;
		private var sliderYStep:Number = 12;
		private var xpos:Number = 5;
		private var ypos:Number = 0;
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		public function SliderList()
		{
			componentsArray = [];
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		public function addSliderGap():void
		{
			componentIndex ++;
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		public function addObjectSlider(
			label:String,
			width:int,
			min:Number,max:Number,
			defaultValue:Number,
			objectToUpdate:Object,
			objectParamaterToUpdate:String
		):void {
			// Ini components array (textField will be done later)
			var params:SliderListParamatersObject = new SliderListParamatersObject();
			params.label = label;
			params.objectToUpdate = objectToUpdate;
			params.objectParamaterToUpdate = objectParamaterToUpdate;
			params.uiComponent = new HSlider();
			
			// Add component to components array
			componentsArray["Component " + componentIndex] = params;
			
			// Configure component add to display list
			HSlider(params.uiComponent).name = "Component " + componentIndex;
			HSlider(params.uiComponent).width = width;
			HSlider(params.uiComponent).minimum = min;
			HSlider(params.uiComponent).maximum = max;
			HSlider(params.uiComponent).value = defaultValue;
			HSlider(params.uiComponent).x = 0;
			HSlider(params.uiComponent).y = (componentIndex-1) * sliderYStep;
			addChild(params.uiComponent);
			
			// Setup textfield
			params.textField = addText(params.label + " " + HSlider(params.uiComponent).value.toFixed(2),10);
			TextField(params.textField).x = HSlider(params.uiComponent).x + HSlider(params.uiComponent).width + 5;
			TextField(params.textField).y = -2 + ((componentIndex-1) * sliderYStep);
			addChild(params.textField);
			
			// Inc component index
			componentIndex++;
			
			HSlider(params.uiComponent).addEventListener(Event.CHANGE,updateObjectSlider);
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		private function updateObjectSlider(e:Event):void
		{
			var hslider:HSlider = (e.target) as HSlider;
			var params:SliderListParamatersObject = componentsArray[hslider.name];
			updateText(params.label + " " + params.uiComponent.value.toFixed(2),params.textField,10);
			
			params.objectToUpdate[params.objectParamaterToUpdate] = hslider.value;
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		public function addColorSelector(
			label:String,
			defaultValue:Number,
			objectToUpdate:Object,
			objectParamaterToUpdate:String
		):void{
			// Ini components array (textField will be done later)
			var params:SliderListParamatersObject = new SliderListParamatersObject();
			params.label = label;
			params.objectToUpdate = objectToUpdate;
			params.objectParamaterToUpdate = objectParamaterToUpdate;
			params.uiComponent = new ColorChooser();
			
			// Add component to components array
			componentsArray["Component " + componentIndex] = params;
			
			// Configure component add to display list
			ColorChooser(params.uiComponent).name = "Component " + componentIndex;
			ColorChooser(params.uiComponent).value = defaultValue;
			ColorChooser(params.uiComponent).x = 0;
			ColorChooser(params.uiComponent).y = (componentIndex-1) * sliderYStep;
			addChild(params.uiComponent);
			
			// Setup textfield
			params.textField = addText(params.label,10);
			TextField(params.textField).x = ColorChooser(params.uiComponent).x + ColorChooser(params.uiComponent).width + 5;
			TextField(params.textField).y = -1 + ((componentIndex-1) * sliderYStep);
			addChild(params.textField);
			
			// Inc component index
			componentIndex++;
			
			ColorChooser(params.uiComponent).addEventListener(Event.CHANGE,updateColorChooser);
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		private function updateColorChooser(e:Event):void
		{
			var uiComponent:ColorChooser = (e.target) as ColorChooser;
			var params:SliderListParamatersObject = componentsArray[uiComponent.name];
			updateText(params.label,params.textField,10);
			
			params.objectToUpdate[params.objectParamaterToUpdate] = uiComponent.value;
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		

		
		
		
		
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		public function addTrueFalseCheckbox(
			label:String,
			selected:Boolean,
			objectToUpdate:Object,
			objectParamaterToUpdate:String
		):void{
			// Ini components array (textField will be done later)
			var params:SliderListParamatersObject = new SliderListParamatersObject();
			params.label = label;
			params.objectToUpdate = objectToUpdate;
			params.objectParamaterToUpdate = objectParamaterToUpdate;
			params.uiComponent = new CheckBox();
			
			// Add component to components array
			componentsArray["Component " + componentIndex] = params;
			
			// Configure component add to display list
			CheckBox(params.uiComponent).name = "Component " + componentIndex;
			CheckBox(params.uiComponent).selected = selected;
			CheckBox(params.uiComponent).x = 0;
			CheckBox(params.uiComponent).y = (componentIndex-1) * sliderYStep;
			addChild(params.uiComponent);
			
			// Setup textfield
			params.textField = addText(params.label,10);
			TextField(params.textField).x = CheckBox(params.uiComponent).x + CheckBox(params.uiComponent).width;
			TextField(params.textField).y = -4 + ((componentIndex-1) * sliderYStep);
			addChild(params.textField);
			
			// Inc component index
			componentIndex++;
			
			CheckBox(params.uiComponent).addEventListener(Event.CHANGE,updateCheckbox);
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		private function updateCheckbox(e:Event):void
		{
			var uiComponent:CheckBox = (e.target) as CheckBox;
			var params:SliderListParamatersObject = componentsArray[uiComponent.name];
			updateText(params.label + " " + params.uiComponent.checked,params.textField,10);
			
			params.objectToUpdate[params.objectParamaterToUpdate] = uiComponent.selected;
		}
		// ------------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		// ------------------------------------------------------------------------------------------------------------------------------
		private function addText(label:String = "message",size:int=10):TextField
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.size = size;
			tf.font = "arial";
			tf.bold = true;
			var text:TextField = new TextField();
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.autoSize = TextFieldAutoSize.LEFT;
			text.multiline = false;
			text.selectable = false;
			text.text = label;
			text.setTextFormat(tf);
			return text;
		}
		private function updateText(label:String,text:TextField,size:int = 10):void
		{
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.size = size;
			tf.font = "arial";
			tf.bold = true;
			text.text = label;
			text.setTextFormat(tf);
		}
		// ------------------------------------------------------------------------------------------------------------------------------		
		
		
		
	}
	// ------------------------------------------------------------------------------------------------------------------------------
	
	
}