component{
	property name='leakAnalyzer' inject='leakAnalyzer@singleton-leak-detector';

	function leaks( event, rc, prc ){
		prc.leakData = leakAnalyzer.getLeaks();
		prc.trackedData = leakAnalyzer.getTrackedSingletons();
		event.setView( "report/leaks" );
	}

	function tracked( event, rc, prc ){
		prc.leakData = leakAnalyzer.getLeaks();
		prc.trackedData = leakAnalyzer.getTrackedSingletons();
		event.setView( "report/tracked" );
	}

}
