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
		
		structNew()
			.append( 
				wirebox
					.getScope( 'singleton' )
					.getSingletons()
			)
			.each( function( k, v ) {
				wirebox.getInstance( 'leakAnalyzer@singleton-leak-detector' ).registerSingleton( k, v );
			} );
		
	}
	

	function afterConfigurationLoad() {
		// Force handler caching to be on so this module can detect leaks in your handlers
		controller.setSetting( 'handlerCaching', true );
		controller.getHandlerService().setHandlerCaching( true );
		// Turn off singleton reload as well.
		controller.getSetting( "Wirebox" ).singletonReload = false;		
	}
	
}