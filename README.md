# ec-loadtest Cookbook

This cookbook will spin up a Jenkins server, configured with Java and Ruby to run the Gatling tool.  And it will do it on the same subnet as an ec-metal install and make a hosts file entry for api.opscode.piab to aid in creating a functional testing environment.

To get a look at it, `kitchen converge` and go to http://localhost:9090

But it's not all automation nirvana.

With Chef server requests there are lots of things needed that cannot be checked in source control, like the .pem files to authenticate your requests against the server.  So in Test Kitchen (Vagrant) I've mapped a folder to /ec-loadtest on the VM which will enable you to make a .chef (or anything you want to call it) folder accessible and thus make your necessary .pem files available.

The cookbook also has a file named GatlingChef.rb (ht Jeremiah Sapp) - this is where the magic happens.  It will take a Gatling script and update the Chef auth header values to make the run repeatable.  It is currently geared towards working with a single user.  If the user is in multiple Chef server organizations, then a script that makes requests to multiple Orgs will work fine.

TODO: Either a script to convert an nginx log in to a Gatling script or use a Gatling Feeder to use an nginx log directly.
TODO: Have the server/hostname for the Gatling script be a variable
TODO: Jenkins job to create X nodes in Y org, there is an example of this in the oc-reporting repo.