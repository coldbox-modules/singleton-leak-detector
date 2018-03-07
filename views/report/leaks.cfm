<cfoutput>
	<cfif !prc.leakData.count() >
		<div class="row">
			<div class="col-md-12 alert alert-primary" role="alert">
				<i class="fa fa-info-circle"></i> <b>No leaky singletons detected!</b>
			</div>
		</div>
	</cfif>


	<cfloop collection="#prc.leakData#" item="leakySingletonName">
		<cfset leakySingleton = prc.leakData[ leakySingletonName ]>
		<cfset leakySingletonPath = getMetadata( prc.trackedData[ leakySingletonName ].instance ).path >
		<div id="#leakySingletonPath#" class="col-md-12 margin30">
			<table class="table table-sm" style="border: 1px sold silver">
				<thead>
					<tr style="background-color:##f2f2f2">
						<th colspan="3">
							<h4>#leakySingletonName#<sub></h4>
							<small>#leakySingletonPath#</small>
						</th>
						<th><i class="fa fa-tint"></i></sub></th>
					</tr>
				</thead>
				<tbody>
					<cfif leakySingleton.newVariables.count() >
						<tr>
							<th scope="row" colspan="3" class="marginLeft10"><h5>&nbsp; New Variables</h5></th>
						</tr>
						<cfloop collection="#leakySingleton.newVariables#" item="newVariableName">
							<tr>
								<cfset newVariable = leakySingleton.newVariables[ newVariableName ]>
								<td colspan="1">&nbsp; &nbsp; #newVariableName#</td>
								<td colspan="2"><cfdump var="#newVariable#" top="3"></td>
							</tr>	
						</cfloop>
					</cfif>
					<cfif leakySingleton.modifiedVariables.count() >
						<tr>
							<th scope="row" colspan="3"><h5>&nbsp; Modified Variables</h5></th>
						</tr>
						<cfloop collection="#leakySingleton.modifiedVariables#" item="modifiedVariableName">
							<tr>
								<cfset modifiedVariable = leakySingleton.modifiedVariables[ modifiedVariableName ]>
								<td>&nbsp; &nbsp; #modifiedVariableName#</td>
								<td>original value <cfdump var="#modifiedVariable.oldValue#" top="3"></td>
								<td>new value <cfdump var="#modifiedVariable.newValue#" top="3"></td>
							</tr>	
						</cfloop>
					</cfif>
				</tbody>
			</table>
		</div>																
	</cfloop>
</cfoutput>