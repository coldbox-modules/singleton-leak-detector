<cfoutput>
	<button onClick="javascript:window.location.href='#event.buildLink( 'leakDetector/report/tracked' )#'">Show all tracked Singletons</button>
	
		<cfif !prc.leakData.count() >
			<b>No leaky singletons detected!</b>
		</cfif>
		<cfloop collection="#prc.leakData#" item="leakySingletonName">
			<h1>#leakySingletonName#</h1>
			<cfset leakySingleton = prc.leakData[ leakySingletonName ]>
			
			<div style="margin-left: 2em;">
			
				<cfif leakySingleton.newVariables.count() >
					<h2>New Variables</h2>
					<div style="margin-left: 2em;">
						<cfloop collection="#leakySingleton.newVariables#" item="newVariableName">
							<cfset newVariable = leakySingleton.newVariables[ newVariableName ]>
							<h3>#newVariableName#</h3>
							<div style="margin-left: 2em;">
								<cfdump var="#newVariable#" top="3">
							</div>
						</cfloop>
					</div>
				</cfif>
				
				<cfif leakySingleton.modifiedVariables.count() >
					<h2>Modified Variables</h2>
					<div style="margin-left: 2em;">
						<cfloop collection="#leakySingleton.modifiedVariables#" item="modifiedVariableName">
							<cfset modifiedVariable = leakySingleton.modifiedVariables[ modifiedVariableName ]>
							<h3>#modifiedVariableName# original value</h3>
							<div style="margin-left: 2em;">
								<cfdump var="#modifiedVariable.oldValue#" top="3">
							</div>
							<h3>#modifiedVariableName# new value</h3>
							<div style="margin-left: 2em;">
								<cfdump var="#modifiedVariable.newValue#" top="3">
							</div>
						</cfloop>
					</div>
				</cfif>
			
			</div>
			
			<hr>
			
		</cfloop>
		
		
		
</cfoutput>