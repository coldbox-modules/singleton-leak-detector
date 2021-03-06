A debugging module to help detect var scoping issues in your singletons.  Instead of using static code analysis, this module latches onto WireBox to track each of the singleton CFCs that get created.  The contents of each CFC's variables scope will have a snapshot stored upon its creation so it can be compared later in the life of your application to see if vars have leaked out of your methods and into the shared `variables` scope.

## Installation

Install this module as a development dependency in your app:

```
install singleton-leak-detector --saveDev
```

## Usage

To this module, make sure you don't have settings like `wirebox.singletonReload` enabled.  Use your site, or better yet, run some automated tests against it that cover as much code as possible.  Then navigate to this URL in the brower:

```
http://yoursite.com/leakDetector
```

That page will show you all of the singletons that appear to be leaky.  This is defined as any singleton (including ColdBox handlers) that has had additional vars created or modified in the `variables` scope of the CFC instance since it was created.  This is a sign that local variables from methods are "leaking" out into the variables scope on accident.

For new variables, the var name and value will be shown to you.   For modified variables, the new and old values will be displayed.  It is up to you to find the variable declarations in your code and fix them.

## ColdBox Settings

For this module to work, it needs `handlerCaching` set to `true` and `wirebox.singletonReload` set to `false`.  If you don't have those settings in place, the module will set them for you.  

## Verify

To confirm that this module is tracking all of the singletons in your app, click the "Show all tracked Singletons" button. Please note that this module will only start tracking singletons once WireBox has created them.  This means if you don't hit a part of the site that uses a CFC, it may not even be created yet.  This is why it's important to have an automated script that can run through scenarios on your app to ensure that as much of the code has been hit as possible.  This module will only detect leaky code if it has been run!

## False Positives

This library may pick up variables in your code that are not in fact leaks, but rather variables you set over time in a singleton to cache values, etc.  Any CFC instances will be ignored, but that is mostly just because duplicating them is dangerous and comparing them is problematic.  This may get improved in the future.  Other variables that are ignored are:

* cfquery's `executiontime` variable
* `cfstoredproc` variables
* variables named `instance`.  

To help reduce the false positives, you can do a couple things.

### Initialize variables in the `init()` method.

Since this library snapshots the `variables` scope when each singleton is created (after `init()` has been called) make sure you've initialized any variables by then.

### If you store state, use a property

If there is a variable you purposefully want to change over the life of a singleton, such as a counter, use a `cfproperty` to declare that variable.  This library will ignore all variables that are declared as properties.  If your CFC extends another CFC, we pay attention to all inherited properties. 

## Feedback

This project is very new and we'd love feedback on how we can best allow you to filter out false positives in order to get useful feedback on your leaky singletons.  

