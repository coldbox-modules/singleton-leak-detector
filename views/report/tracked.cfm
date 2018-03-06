<cfoutput>
	<div class="row">
		<div class="col-md-12 alert alert-primary" role="alert">
			<i class="fa fa-info-circle"></i> If you don't see some of your singletons here, please check and make sure they have the "<b>singleton</b>" annotation in them so WireBox marks them properly.
		</div>
	</div>
	<div class="row margin10">
		<cfif !prc.trackedData.count() >
			<div class="col-md-12 alert alert-danger" role="alert">
				<i class="fa fa-exclamation-triangle"></i> <b>No tracked singletons detected!</b> Make sure your singles are tagged with the "<b>singleton</b>" annotation.
			</div>
		<cfelse>
			<div class="col-md-12">
				<h4 class="text-right">Total <span class="badge badge-secondary">#structCount(prc.trackedData)#</span></h4>
			</div>
			<table class="table table-sm table-striped">
				<thead>
					<tr>
						<th scope="col"><h5><sub><i class="fa fa-dot-circle"></i></sub></h5></th>
						<th scope="col"><h5>Tracked Handlers</h5></th>
					</tr>
				</thead>
				<tbody>
					<cfset i = 1>
					<cfloop collection="#prc.trackedData#" item="trackedSingletonName">
						<tr>
							<th scope="row">#i#</th>
							<td>#trackedSingletonName#</td>
						</tr>
						<cfset i++>	
					</cfloop>
				</tbody>
			</table>
		</cfif>
	</div>
		
				
</cfoutput>