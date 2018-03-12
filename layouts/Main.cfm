
<cfoutput>
<!DOCTYPE	html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Singleton Leak Detector</title>
	<meta name="author" content="Brad Wood">

	<!--- font --->
	<link href="https://fonts.googleapis.com/css?family=Arimo" rel="stylesheet">
	<!--- bootstrap --->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<!--- fontawesome --->
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>

	<style>
	.margin10{ margin: 10px; }
	.margin30{ margin-top: 30px; }
	* { font-family: Arimo; }
	h1,h2,h3,h4,h5,h6 { font-weight:bold; }
	.leak-color-badge { background-color:##ff9130; color:white; }
	.leak-color { color:##ff9130;}
	##menu-div { background-color:white; }
	</style>

</head>

<body>
	<!--- navbar --->
	<div class="container fixed-top">
		<div class="col-md-12" id="menu-div">
			<div class="btn-group margin10" role="group" aria-label="Main Actions">
				<a class="btn btn-warning leak-color-badge" href="#event.buildLink( 'leakDetector/report/leaks' )#"><i class="fa fa-tint"></i> Leaked</a>
				<a class="btn btn-dark" href="#event.buildLink( 'leakDetector/report/tracked' )#"><i class="fa fa-dot-circle"></i> Tracked</a>
			</div>
		</div>
	</div>
	<!--- container and views --->
	<div class="container">#renderView()#</div>
</body>

<footer>
	<div class="row margin30">
		<div class="col-md-12 text-center">
			<a class="btn btn-light" href="##"><i class="fa fa-arrow-up"></i> Back to Top </a>
		</div>
	</div>
</footer>
</cfoutput>