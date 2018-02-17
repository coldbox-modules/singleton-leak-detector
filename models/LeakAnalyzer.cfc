component singleton accessors=true {
	
	property name="singletons" type="struct";
	
	function init() {		
		singletons = singletons ?: {};
	}
	
	function registerSingleton( name, instance ) {
		if( 
			!getMetaData( instance ).name.lcase().startsWith( 'coldbox.system.' )
			&& !name.findNoCase( 'singleton-leak-detector' )			
		 ) {
		 	systemoutput( 'REgistering: #name#', 1  );
		 	if( !singletons.keyExists( name ) ) {
				instance[ '$scopeSpy' ] = $scopeSpy;
				var targetScope = instance.$scopeSpy();
				singletons[ name ] = {
					instance : instance,
					originalScope : targetScope 	
				};	
		 	} else {
				instance[ '$scopeSpy' ] = $scopeSpy;
		 		singletons[ name ].instance = instance;
		 	}
		}
	};

	function getLeaks() {
		var leakers = {};
		
		singletons.each( function( k, v ) {
			
			var newScope = duplicate( v.instance.$scopeSpy() );
			var details = {
				originalScope : v.originalScope,
				newScope : newScope,
				newVariables = {},
				modifiedVariables = {}
			};
			
			newScope.each( function( scopeKey, scopeValue ){
				
				// New variable that didn't exist before
				if( 
					!scopeKey.findNoCase( 'EXECUTIONTIME' ) 
					&& scopeKey != 'instance' 
					&& scopeKey != 'CFSTOREDPROC'
					&& !v.originalScope.keyExists( scopeKey )
				) {
					details.newVariables[ scopeKey ] = scopeValue;
					
				// value that has changed
				} else if( 
					!scopeKey.findNoCase( 'EXECUTIONTIME' ) 
					&& scopeKey != 'instance'
					&& scopeKey != 'CFSTOREDPROC'
					&& v.originalScope[ scopeKey ].toString() != scopeValue.toString()
				) {
					details.modifiedVariables[ scopeKey ] = {
						newValue : scopeValue,
						oldValue : 	v.originalScope[ scopeKey ]
					};
				}
				
				
				
			} );
				 
			if( details.newVariables.count() || details.modifiedVariables.count() ) {
				leakers[ k ] = details;	
			}			
			
		} );
		
		return leakers;
	}

	function getTrackedSingletons() {
		return singletons;
	}

	function $scopeSpy() {
		return variables
			.filter( function( k, v ) {
				return !isCustomFunction( v ) && !isObject( v );
			} );
	}

}