/*
root & level 1 xml node value retreival

USAGE:

var x:XMLManager = XMLManager.getInstance();
var d:Dictionary = new Dictionary();
d["config"] = que2.getContent("config");
d["language"] = que2.getContent("language");
x.init(d);

//t.string("config->default application language = " + x.getValueByID("config","default application language","node","config") );
//t.string("config->google analytics tracking code = " + x.getValueByID("config","google analytics tracking code","node","config") );
//t.string("language-item1 = " + x.getValueByID("language","item1","node") );
//t.string("language-option1 = " + x.getValueByID("language","option1","node","mainmenu") );
//t.string("language-option2 = " + x.getValueByID("language","option2","node","mainmenu") );


*/
package com.darcey.managers.XMLHandler
{	
	import com.darcey.debug.Ttrace;
	import com.darcey.utils.DTools;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	
	// ---------------------------------------------------------------------------------------------------------------------------
	public class XMLHandler extends EventDispatcher
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		
		private var path:String = ""
		private var xmlFiles:Dictionary;
		
		private var initComplete:Boolean = false;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// Singleton -----------------------------------------------------------------------------------------------------------------
		private static var Singleton:XMLHandler;
		public static function getInstance():XMLHandler { if ( Singleton == null ){ Singleton = new XMLHandler(); } return Singleton;}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function XMLHandler()
		{
			// Setup project custom t.stringr
			t = new Ttrace(true);
			t.string("com.darcey.managers.xmlManager.XMLManager()");
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function init(xmlFiles:Dictionary,path:String=""):void
		{
			trace("#################################################################");
			trace("#################################################################");
			trace("#################################################################");
			trace("#################################################################");
			
			t.string("com.darcey.managers.xmlManager.XMLManager.init()");
			
			// Var ini
			this.xmlFiles = xmlFiles;
			this.path = path;
			
			for (var i in xmlFiles){ t.string(i); /* Gives us the key;*/ }
			
			/*
			xmlData = xmlFiles["config"];
			var id:String = "enable videos";
			trace(xmlData);
			trace("id[" + id + "] = " + xmlData.config.node.(@id == id) );
			
			
			trace("################## = \n" + xmlData.child("config") +"\n");
			trace("################## = \n" + xmlData.child(1) +"\n");
			trace("################## = \n" + xmlData.children()[1].toXMLString() +"\n");
			trace("################## = " + XML(xmlData.child(0))..attribute("show ram and fps monitor").length() +"\n");
			
			
			
			var x2:XML = new XML(xmlData.child("config"));
			trace("x2 = " + x2..node.(@id == id) );
			*/
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function getValueByID(xmlFileName:String, id:String,  xmlNodeName:String = "",firstChildName:String = ""):*
		{
			// var ini
			var result:* = null;
			var xmlData:XML = null;
			var firstChildXML:XML = null;
			
			// Ensure we got a correct input
			if (xmlFileName == ""){ t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: You must specify an xml file name."); return null; }
			if (xmlNodeName == ""){ t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: You must specify an xml node name."); return null; }
			if (id == ""){ t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: You must specify an id."); return null; }
			
			// Check xml file is in the dictionary
			if (xmlFiles[xmlFileName] == null){
				t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: File [" + xmlFileName + "]");
				return false;
			}
			
			// Get the xml file we want to look in
			xmlData = xmlFiles[xmlFileName];
			if (xmlData == null || xmlData.length() == 0){
				t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: Unable to get xml file name [" + xmlFileName + "]");
				return null;
			}
			
			
			// Get result for when a first child name is specified
			if (firstChildName != ""){
				// ----------------------------------------------------------------------------------------------------------------------------------------------------
				// Check we can get XML data for the firstchild 1st
				if (!xmlData.hasOwnProperty(firstChildName))
				{
					t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: Unable to get xml file name [" + xmlFileName + "]");
					return null;
				} else {
					firstChildXML = new XML(xmlData.child(firstChildName));
				}
				
				
				// Check node name exists
				if (!firstChildXML.hasOwnProperty(xmlNodeName)){
					t.warn("com.darcey.managers.xmlmanager.XMLManager.getValueByID(): WARNING: Unable to get node name in first childs xml data [" + xmlNodeName + "]");
					return null;
				}
				
				
				// Check result can be found
				if (firstChildXML..child(xmlNodeName).(@id == id).length() > 0)
				{
					result = firstChildXML..child(xmlNodeName).(@id == id)
					//result = firstChildXML..node.(@id == id);
					//trace("firstChildXML = \n" + firstChildXML);
				} else {
					return null;
				}
				// ----------------------------------------------------------------------------------------------------------------------------------------------------
			} else {
				// ----------------------------------------------------------------------------------------------------------------------------------------------------				
				// Check result can be found
				if (xmlData..child(xmlNodeName).(@id == id).length() > 0)
				{
					result = xmlData..child(xmlNodeName).(@id == id)
				} else {
					return null;
				}
				// ----------------------------------------------------------------------------------------------------------------------------------------------------
			}
			
			
			// Clean up
			xmlData = null;
			firstChildXML = null;
			
			// Return
			return result;
			
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		
	}
	// ---------------------------------------------------------------------------------------------------------------------------
}