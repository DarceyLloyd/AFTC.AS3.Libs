package com.darcey.managers.AssetHandler
{
	// -------------------------------------------------------------------------------------------------------------------------------
	import com.darcey.debug.Ttrace;
	import com.greensock.loading.SWFLoader;
	
	import flash.display.Loader;
	import flash.display.MovieClip;

	// -------------------------------------------------------------------------------------------------------------------------------
	
	
	
	// -------------------------------------------------------------------------------------------------------------------------------
	public class AssetHandler
	{
		// ---------------------------------------------------------------------------------------------------------------------------
		private var t:Ttrace;
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function AssetHandler() { t = new Ttrace(false); }
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		// For use with standard loading methods
		// ---------------------------------------------------------------------------------------------------------------------------
		public function getAssetFromLoader(loader:Loader,libraryLinkageName:String):*
		{
			t.string("getAssetClassFromLoader(loader, libraryLinkageName)");
			////trace("e.target.loader.contentLoaderInfo.applicationDomain.getDefinition(s) = " + e.target.loader.contentLoaderInfo.applicationDomain.getDefinition("FLAmcBullet") );
			var asset:*;
			
			try {
				asset = loader.contentLoaderInfo.applicationDomain.getDefinition(libraryLinkageName);
			} catch (e:Error) {
				t.wdiv();
				t.warn("AssetHandler.getAssetClassFromLoader(): Unable to retrieve asset class with linkage id [" + libraryLinkageName + "]");
				t.wdiv();
			}
			
			return asset;
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// ---------------------------------------------------------------------------------------------------------------------------
		public function getAssetClassFromLoaderMaxSWF(swfLoader:SWFLoader,libraryLinkageName:String):*
		{
			t.string("AssetHandler.getAssetFromLoaderMaxSWF(swfLoader, libraryLinkageName)");
			//t.string("swfLoader.getClass(libraryLinkageName) = " + swfLoader.getClass(libraryLinkageName));
			
			return swfLoader.getClass(libraryLinkageName);
		}
		// ---------------------------------------------------------------------------------------------------------------------------
		
		
		
		// --------------------------------------------------------------------------------------------
		// Loaded SWF content is accessed via this
		// --------------------------------------------------------------------------------------------
		public function getAssetFromSWF(arg_mc:MovieClip,arg_sClass:String):*
		{
			var mc:MovieClip = arg_mc;
			var c:Class = mc.loaderInfo.applicationDomain.getDefinition(arg_sClass) as Class;
			if (c != null)
			{
				return new c();
			} else {
				throw new Error("*************** ASSET " + arg_sClass + " CANNOT BE FOUND *****************");
			}
		}
		// --------------------------------------------------------------------------------------------
		
		
	}
	// -------------------------------------------------------------------------------------------------------------------------------
}