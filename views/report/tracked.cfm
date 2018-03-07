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
				<h4 class="text-right">Tracked <span class="badge badge-secondary">#structCount(prc.trackedData)#</span> &nbsp;&nbsp; Leaked <span class="badge leak-color-badge">#structCount(prc.leakData)#</span> </h4>
			</div>
			<table class="table table-sm table-striped">
				<thead>
					<tr>
						<th scope="col"><h5><sub><i class="fa fa-dot-circle"></i></sub></h5></th>
						<th scope="col"><h5>Handler</h5></th>
						<th scope="col"><h5>Path</h5></th>
						<th scope="col"><h5 class="text-center">Status</h5></th>
						<th scope="col"><h5 class="text-center">Detail</h5></th>
					</tr>
				</thead>
				<tbody>
					<cfset i = 1>
					<cfloop collection="#prc.trackedData#" item="trackedSingletonName">
						<cfset trackedSingletonPath = getMetadata( prc.trackedData[ trackedSingletonName ].instance ).path >
						<tr>
							<th scope="row">#i#</th>
							<td>#trackedSingletonName#</td>
							<td><small>#trackedSingletonPath#</small></td>
							<cfif structKeyExists(prc.leakData, trackedSingletonName )>
								<td class="text-center"><i class="fa fa-tint leak-color"></i></td>
								<td class="text-center"><a title="Check Details" href="#event.buildLink( 'leakDetector/report/leaks')####trackedSingletonPath#"><i class="fa fa-link"></i></a></td>
							<cfelse>
								<td class="text-center"><i class="fa fa-check" style="color:green"></i></td>
								<td class="text-center"><i class="fa fa-unlink" style="color:silver"></i></td>
							</cfif>
						</tr>
						<cfset i++>	
					</cfloop>
				</tbody>
			</table>
		</cfif>
	</div>
		
				
</cfoutput>