<cfoutput>
	<cfif !prc.leakData.count() >
		<div class="row">
			<div class="col-md-12 alert alert-primary" role="alert">
				<i class="fa fa-info-circle"></i> <b>No leaky singletons detected!</b>
			</div>
		</div>
	</cfif>

	<div class="row margin30">

		<div class="col-md-12 text-right margin30">
			<p>Tracked <span class="badge badge-secondary">#structCount(prc.trackedData)#</span> &nbsp;&nbsp; Leaked <span class="badge leak-color-badge">#structCount(prc.leakData)#</span> <button id="showHideAll" class="btn btn-light" type="button" data-toggle="collapse" data-target="##showHideAllBody">Collapse All</button> </p>
		</div>
		<cfset i = 1>
		<cfloop collection="#prc.leakData#" item="leakySingletonName">
			<cfset leakySingleton = prc.leakData[ leakySingletonName ]>
			<cfset leakySingletonPath = getMetadata( prc.trackedData[ leakySingletonName ].instance ).path >
			<div id="#leakySingletonPath#" class="col-md-12 margin30">
				<table class="table table-sm" style="border: 1px sold silver">
					<thead>
						<tr style="background-color:##f2f2f2">
							<th colspan="3">
								<h4>#leakySingletonName#</h4>
								<button id="#i#" class="btn btn-light showHideButton" style="font-size:10px" type="button" data-toggle="collapse" data-target="##collapse-div-#i#"><i id="icon-#i#" class="fa fa-minus showHideIcon"></i></button> &nbsp;&nbsp;
								New <span class="badge badge-warning">#structCount(leakySingleton.newVariables)#</span> &nbsp; Mod <span class="badge badge-danger">#structCount(leakySingleton.modifiedVariables)#</span>
							</th>
						</tr>
					</thead>
					<tbody class="collapse show" id="collapse-div-#i#">
						<cfif leakySingleton.newVariables.count() >
							<tr>
								<th scope="row"><h5>&nbsp; New Variables</h5></th>
								<th>Value</th>
								<th></th>
							</tr>
							<cfloop collection="#leakySingleton.newVariables#" item="newVariableName">
								<tr>
									<cfset newVariable = leakySingleton.newVariables[ newVariableName ]>
									<td>&nbsp; &nbsp; &nbsp; #newVariableName#</td>
									<td><cfdump var="#newVariable#"></td>
									<td></td>
								</tr>	
							</cfloop>
						</cfif>
						<cfif leakySingleton.modifiedVariables.count() >
							<tr>
								<th scope="row"><h5>&nbsp; Modified Variables</h5></th>
								<th><b>Original Value</b></th>
								<th><b>New Value</b></th>
							</tr>
							<cfloop collection="#leakySingleton.modifiedVariables#" item="modifiedVariableName">
								<tr>
									<cfset modifiedVariable = leakySingleton.modifiedVariables[ modifiedVariableName ]>
									<td>&nbsp; &nbsp; &nbsp; #modifiedVariableName#</td>
									<td><cfdump var="#modifiedVariable.oldValue#"></td>
									<td><cfdump var="#modifiedVariable.newValue#"></td>
								</tr>	
							</cfloop>
						</cfif>
						<tr style="background-color:##f2f2f2">
							<th colspan="3"><small>#leakySingletonPath#</small></th>
						</tr>
					</tbody>
				</table>
			</div>
			<cfset i++>																
		</cfloop>
	</div>
</cfoutput>