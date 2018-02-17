component {
	property name='leakAnalyzer' inject='leakAnalyzer@singleton-leak-detector';
	
	/**
	* Listen for new singletons and handlers being creatd by WireBox and register them
	*/
	function afterInstanceCreation() {
		var mapping = arguments.interceptData.mapping;
		var name = mapping.getName();
		if( mapping.getScope() == 'singleton' || name.findNoCase( 'handlers.' ) ) {
			leakAnalyzer.registerSingleton( name, arguments.interceptData.target );
		}
	}
	
}