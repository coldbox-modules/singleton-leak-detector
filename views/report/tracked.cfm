<cfoutput>
	<button onClick="javascript:window.location.href='#event.buildLink( 'leakDetector/report/leaks' )#'">Show leaky Singletons</button>
	<p>
	If you don't see some of your singletons here, please check and make sure they have the "singleton" annotation in them so WireBox marks them properly.
	</p>
		<cfif !prc.trackedData.count() >
			<b>No tracked singletons detected!</b><br>
			Make sure you singles are tagged with the "singleton" annotation
		<cfelse>
			<ul>
			<cfloop collection="#prc.trackedData#" item="trackedSingletonName">
				<li>#trackedSingletonName#</li>				
			</cfloop>
			</ul>
		</cfif>
		
				
</cfoutput>