component singleton accessors=true {
	
	property name="singletons" type="struct";
	property name="controller" inject="coldbox";
	
	function init() {
		// A data structure to track our singletons
		singletons = singletons ?: {};
	}
	
	/**
	* Add a new singleton to the list of singletons being tracked.
	* If a singleton by this name already exists, we accept the new instance, 
	* but keep using the original variables scope from the first one.
	* 
	* @name The name of the instance to register
	* @instance The actual CFC instance
	*/
	function registerSingleton( name, instance ) {
		if( 
			!getMetaData( instance ).name.lcase().startsWith( 'coldbox.system.' )
			&& !name.findNoCase( 'singleton-leak-detector' )			
		 ) {
		 	systemoutput( 'REgistering: #name#', 1  );
		 	if( !singletons.keyExists( name ) ) {
				instance[ '$scopeSpy' ] = $scopeSpy;
				var targetScope = instance.$scopeSpy( controller );
				singletons[ name ] = {
					instance : instance,
					originalScope : targetScope 	
				};	
		 	} else {
				instance[ '$scopeSpy' ] = $scopeSpy;
		 		singletons[ name ].instance = instance;
		 	}
		}
	}

	
	/**
	* Return a struct of data representing leaky CFCs.
	*/
	struct function getLeaks() {
		var leakers = {};
		
		// For every singleton we're tracking
		singletons.each( function( k, v ) {
			
			// Create a copy of the singleton's current variables scope
			var newScope = duplicate( v.instance.$scopeSpy( controller ) );
			// Initialize details about the CFC
			var details = {
				originalScope : v.originalScope,
				newScope : newScope,
				newVariables = {},
				modifiedVariables = {}
			};
			
			// For every varible in the new internal scope
			newScope.each( function( scopeKey, scopeValue ){
				
				// See if it didn't exist before
				if( 
					// cfquery seems to litter cfquery.execuiontime stuff around
					!scopeKey.findNoCase( 'EXECUTIONTIME' )  
					// Ignore variables.instance. 
					&& scopeKey != 'instance' 
					// cfstoredprocs litter this variable around
					&& scopeKey != 'CFSTOREDPROC'
					&& !v.originalScope.keyExists( scopeKey )
				) {
					details.newVariables[ scopeKey ] = scopeValue;
					
				// ... or if its value has changed
				} else if( 
					// cfquery seems to litter cfquery.execuiontime stuff around
					!scopeKey.findNoCase( 'EXECUTIONTIME' ) 
					// Ignore variables.instance. 
					&& scopeKey != 'instance'
					// cfstoredprocs litter this variable around
					&& scopeKey != 'CFSTOREDPROC'
					// new and old versions of the varible are different
					&& v.originalScope[ scopeKey ].toString() != scopeValue.toString()
				) {
					details.modifiedVariables[ scopeKey ] = {
						newValue : scopeValue,
						oldValue : 	v.originalScope[ scopeKey ]
					};
				}
				
			} );
			
			// If we found at least one new or modified variable, then tag it as leaky!
			if( details.newVariables.count() || details.modifiedVariables.count() ) {
				leakers[ k ] = details;	
			}			
			
		} );
		
		return leakers;
	}

	
	/**
	* Return the full struct of tracked singletons.
	*/
	struct function getTrackedSingletons() {
		return singletons;
	}

	
	/**
	* A mixin to add to our singleons we're tracking
	*/
	function $scopeSpy( required controller ) {
		var md = controller.getUtil().getInheritedMetaData( this );
		var props = md.properties.map( function( prop ){ 
			return prop.name;
		} );
		// Return the variables scope...
		return variables
			// ... but ignore UDFs, CFCs (mostly for performance) and properties
			// Ignoring CONDITIONALS_SQL_MAP since it's part of the base ORM service
			.filter( function( k, v ) {
				return !isCustomFunction( v ) && !props.findNoCase( k ) && !isObject( v ) && k != 'CONDITIONALS_SQL_MAP';
			} );
	}

}