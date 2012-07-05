Open(SUSE) Build Service Trigger Script
=======================================

The [Open Build Service] is a package builder for various distributions. One
can define rules to obtain sources, and from that packages are built and
repositories are made. The [OpenSUSE Build Service] is such a service that is
available to all.

One thing is missing though: the ability to trigger the source service
execution programmatically. This scripts provides exactly that: it triggers
the '''Run services now''' action.


It is possible to run this from a build script, or use it as a service hook,
e.g. from [Github]. For the latter, some security is required, which is
provided by means of specifying a secret key as part of the url, which must
match the one set in the script.

Besides the secret key, it is needed to set your OpenSUSE Build Service
username and password, for this is a protected action.

To run from the command-line, use something like this:

    $ trigger-obs.pl key=mys3cretkey4daweb project=home:thatsme package=super-tools


To use it from the web, install the trigger-obs.pl as a cgi script, using
a url like http://example.com/cgi-bin/trigger-obs.pl?key=mys3cretkey4daweb&project=home:thatsme&package=super-tools

[obs-trigger]: http://github.com/wvengen/obs-trigger
[Open Build Service]: http://open-build-service.org/
[OpenSUSE Build Service]: https://build.opensuse.org/
[Github]: http://github.com/
