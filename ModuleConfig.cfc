component {
	this.entryPoint			= "leakDetector";

	function configure(){
		
		// SES Routes
		routes = [
			// Module Entry Point
			{ pattern="/", handler="report", action="leaks" },
			// Convention Route
			{ pattern="/:handler/:action?" }
		];
		
		interceptors = [
			{ class = '#modulemapping#.interceptors.creationListener' }
		];
	}

	function onLoad() {
		
		wirebox
			.getScope( 'singleton' )
			.getSingletons()
			.each( function( k, v ) {
				wirebox.getInstance( 'leakAnalyzer@singleton-leak-detector' ).registerSingleton( k, v );
			} );
		
	}
	
}