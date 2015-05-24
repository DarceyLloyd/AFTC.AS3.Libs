package com.darcey.parsers
{
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	import com.darcey.debug.Ttrace;
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	public class XMLParser
	{
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		private static var msg:String = "";
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function XMLParser(){}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getSubElement(xml:XML,node:String):XML
		{
			var data:XML;
			if (xml[node].length() > 0){
				return new XML(xml[node]);
			} else {
				msg = "";
				msg += "#### ERROR > XMLParser";
				msg += "#### XMLParser > parent: XML Tag doesn't exist [xmltrue." + node + "]";
				new Error(msg);
				return null;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getElementByIdUsingDynamicPath(xmlData:XML,path:String,id:String,dataType:String="string"):*
		{
			//trace("XMLParser.getElementByIdUsingDynamicPath(xmlData, path:"+path+", id:"+id+", dataType:"+dataType+")");
			
			//trace("getElementByIdUsingDynamicPath()");
			// Loop find last xml path of xml content to search
			var pathItems:Array = path.split(".");
			//trace(pathItems);
			
			var subXML:XML = xmlData;
			
			// Path recursive processing
			for (var i:uint=0; i < pathItems.length-1; i++)
			{
				subXML = new XML(getSubElement(subXML,pathItems[i]));
				//trace("############################ SEARCHING " + pathItems[i]);
			}
			
			//trace(subXML);
			
			// Last node search ID
			//trace("############################ SEARCHING FOR ID [ " + id + "]");
			var containerNode:String = pathItems[pathItems.length-1];
			//trace("############################ containerNode [ " + containerNode + "]");
			
			var xmlValue:*;
			if (subXML[containerNode].(@id == id).length() > 0){
				xmlValue = subXML[containerNode].(@id == id);
				//trace("######" + xmlValue)
			} else {
				msg = "";
				msg += "#### ERROR > XMLParser";
				msg += "#### XMLParser > parent > node @id: Path or ID not found xmlData." + path + ".(@id=" + id + ")";
				new Error(msg);
				return;
			}
			
			pathItems = null;
			subXML = null;
			
			return getReturnDataType(xmlValue,dataType);
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getAttributeByIdUsingDynamicPath(xmlData:XML,path:String,id:String,attribute:String,dataType:String):*
		{
			//trace("getElementByIdUsingDynamicPath()");
			// Loop find last xml path of xml content to search
			var pathItems:Array = path.split(".");
			//trace(pathItems);
			
			var subXML:XML = xmlData;
			
			// Path recursive processing
			for (var i:uint=0; i < pathItems.length-1; i++)
			{
				subXML = new XML(getSubElement(subXML,pathItems[i]));
				//trace("############################ SEARCHING " + pathItems[i]);
				
			}
			
			//trace(subXML);
			
			// Last node search ID
			//trace("############################ SEARCHING FOR ID [ " + id + "]");
			var containerNode:String = pathItems[pathItems.length-1];
			//trace("############################ containerNode [ " + containerNode + "]");
			
			var xmlValue:String;
			if (subXML[containerNode].(@id == id).length() > 0){
				xmlValue = new XML(subXML[containerNode].(@id == id).@[attribute]);
			} else {
				msg = "";
				msg += "#### ERROR > XMLParser";
				msg += "#### XMLParser > parent > node @id: Path or ID not found xmlData." + path + ".(@id=" + id + ")";
				new Error(msg);
				return null;
			}
			
			pathItems = null;
			subXML = null;
			
			return getReturnDataType(xmlValue,dataType);
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getElementById(xmlData:XML,parent:String,node:String,id:String,dataType:String = "string"):*
		{
			//var elementFound:int = xmlData.copy.node.(@id == id).length();
			//trace("xmlData[parent].length() = " + xmlData[parent].length() );
			//trace("xmlData[parent][node].length() = " + xmlData[parent][node].length() );
			//trace("xmlData[parent][node].(@id == id).length() = " + xmlData[parent][node].(@id == id).length() );
			//trace(xmlData[parent][node].(@id == id));
			
			var xmlValue:String = "";
			
			var validXMLPath:Boolean = false;
			if (xmlData[parent].length() > 0){
				if (xmlData[parent][node].length() > 0){
					validXMLPath = true;
				} else {
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### XMLParser > parent > node: XML Tag doesn't exist [xmlData." + parent + "." + node + "]";
					new Error(msg);
					return;
				}
			} else {
				msg = "";
				msg += "#### ERROR > XMLParser";
				msg += "#### XMLParser > parent: XML Tag doesn't exist [xmlData." + parent + "]";
				new Error(msg);
				return;
			}
			
			
			var idFound:Boolean = false;
			if (validXMLPath){
				if (xmlData[parent][node].(@id == id).length() > 0){
					idFound = true;
					xmlValue = xmlData[parent][node].(@id == id);
				} else {
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### XMLParser > parent > node @id: ID not found [xmlData." + parent + "." + node + "@id=" + id + "]";
					new Error(msg);
					return;
				}
			}
						
			
			
			
			
			// Resturn value data type casting
			switch (dataType.toLowerCase())
			{
				case "boolean":
					xmlValue = xmlValue.toLowerCase();
					if (xmlValue == "1" || xmlValue == "y" || xmlValue == "yes"){
						return true;
					} else {
						return false;
					}
					break;
				
				case "float":
					return parseFloat(xmlValue);
					break;
				
				case "int":
					return parseInt(xmlValue);
					break;
				
				case "number":
					return parseInt(xmlValue);
					break;
				
				case "uint":
					return uint(xmlValue);
					break;
				
				case "string":
					//split("\r").join(""); // Keeps \n but removes \r
					return String(xmlValue).split("\r").join("");
					break;
				
				case "xml":
					return xmlValue;
					break;
								
				default:
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### Unhandled return data type of [" + dataType + "]";
					msg += "#### Options available are: string, boolean, float(number), int, uint";
					new Error(msg);
					return null;
					break;
			}
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getAttributeById(xmlData:XML,parent:String,node:String,id:String,attribute:String):String
		{
			//trace("xmlData[parent][node].length() = " + xmlData[parent][node].length() );
			//trace("xmlData[parent][node].(@id == id).length() = " + xmlData[parent][node].(@id == id).length() );
			//trace("xmlData[parent][node].(@id == id) = " + xmlData[parent][node].(@id == id));
			//trace("xmlData[parent][node].(@id == id) = " + xmlData[parent][node].(@id == id).@[attribute]);
			
			var xmlValue:String = "";
			
			var validXMLPath:Boolean = false;
			if (xmlData[parent].length() > 0){
				if (xmlData[parent][node].length() > 0){
					validXMLPath = true;
				} else {
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### XMLParser > parent > node: XML Tag doesn't exist [xmlData." + parent + "." + node + "]";
					new Error(msg);
					return null;
				}
			} else {
				msg = "";
				msg += "#### ERROR > XMLParser";
				msg += "#### XMLParser > parent: XML Tag doesn't exist [xmlData." + parent + "]";
				new Error(msg);
				return null;
			}
			
			
			if (validXMLPath){
				if (xmlData[parent][node].(@id == id).length() > 0){
					if (xmlData[parent][node].(@id == id).@[attribute].length() > 0){
						xmlValue = xmlData[parent][node].(@id == id).@[attribute];
					} else {
						msg = "";
						msg += "#### ERROR > XMLParser";
						msg += "#### XMLParser > parent > node @id=="+id+": Attribute not found [xmlData." + parent + "." + node + "@id=" + id + "].@[" + attribute + "]";
						new Error(msg);
						return null;
					}
				} else {
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### XMLParser > parent > node @id: ID not found [xmlData." + parent + "." + node + "@id=" + id + "]";
					new Error(msg);
					return null;
				}
			}
			
			
			return String(xmlValue);
			
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getReturnDataType(xmlValue:*,dataType:String):*
		{			
			// Resturn value data type casting
			switch (dataType.toLowerCase())
			{
				case "boolean":
					//trace("##### Processing boolean");
					xmlValue = xmlValue.toLowerCase();
					if (xmlValue == "1" || xmlValue == "y" || xmlValue == "yes"){
						return true;
					} else {
						return false;
					}
					break;
				
				case "float":
					//trace("##### Processing float");
					return parseFloat(xmlValue);
					break;
				
				case "int":
					//trace("##### Processing int");
					return parseInt(xmlValue);
					break;
				
				case "number":
					//trace("##### Processing number");
					return parseInt(xmlValue);
					break;
				
				case "uint":
					//trace("##### Processing uint");
					return uint(xmlValue);
					break;
				
				case "string":
					//trace("##### Processing string");
					return String(xmlValue);
					break;
				
				case "xml":
					//trace("##### Processing xml");
					return new XML(xmlValue);
					break;
				
				default:
					msg = "";
					msg += "#### ERROR > XMLParser";
					msg += "#### Unhandled return data type of [" + dataType + "]";
					msg += "#### Options available are: string, boolean, float, number, int, uint";
					new Error(msg);
					return null;
					break;
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		
		
		
		
		
		
		/*
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public static function getCopyById(id:String):String
		{
			var elementFound:int = xmlData.copy.node.(@id == id).length();
			if (elementFound == 0){
				trace("#######################################################################################################");
				trace("XMLModel.getCopyById(id): ID of [" + id + "] doesn't exist, please check your XML");
				trace("#######################################################################################################");
				return "XMLModel.getCopyById(id): ID of [" + id + "] doesn't exist, please check your XML";
			} else {
				return XML(xmlData.config.node.(@id == id)).toString();
			}
		}
		// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		*/
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}