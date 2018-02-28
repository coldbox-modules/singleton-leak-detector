component{

	function index( event, rc, prc ){
		anotherLeak = "leak-detector";
		event.setView( "main/index" );
	}

	
	/**
	* leakIt
	*/
	function leakIt( event, rc, prc ){
		name = "leak-detector";
		event.setView( "Main/leakIt" );
	}	
	

}