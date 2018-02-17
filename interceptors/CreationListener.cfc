component {
	property name='leakAnalyzer' inject='leakAnalyzer@singleton-leak-detector';
		
	function afterInstanceCreation() {
		var mapping = arguments.interceptData.mapping;
		var name = mapping.getName();
		if( mapping.getScope() == 'singleton' || name.findNoCase( 'handlers.' ) ) {
			leakAnalyzer.registerSingleton( name, arguments.interceptData.target );
		}
	}
	
}