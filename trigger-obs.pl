#!/usr/bin/perl
use strict;
use warnings;

# when you need to install dependencies locally, this would be useful
#use File::Basename;
#use lib dirname($0).'/perllib';

use CGI;
use WWW::Mechanize::GZip;

# your OpenSUSE Build Service username
my $user = 'thatsme';
# your OpenSUSE Build Service password
my $passw = 'c00lsecret';
# secret key that needs to be given as parameter to avoid DDoS
my $key = 'mys3cretkey4daweb';


# get and verify details
my $q = CGI->new();
my $givnkey = $q->param('key');
my $package = $q->param('package');
my $project = $q->param('project');
if (not defined $givnkey or $givnkey ne $key) {
	$q->header(-status=>'403 Authorization required');
	print 'Authorization required';
	exit 0;
}
defined $package or die 'Need to supply package';
defined $project or die 'Need to supply project';
$package =~ /^[-+=_a-zA-Z0-9: ]+$/ or die 'Invalid package';
$project =~ /^[-+=_a-zA-Z0-9: ]+$/ or die 'Invalid project';


my $mech = WWW::Mechanize::GZip->new();

# login
$mech->get('https://build.opensuse.org/');
$mech->submit_form(
	form_id => 'login_form',
	fields => {
		'username' => $user,
		'password' => $passw,
	},
);
$mech->success() or die 'Login failed (status '.$mech->status().')';
$mech->content() =~ /Logout/i or die 'Logging into OpenSUSE Build Service failed';

# for each package, trigger a rebuild
foreach my $pkg (split(/\s+/, $package)) {
	$mech->get("https://build.opensuse.org/package/execute_services?package=$pkg&project=$project");
	$mech->success() or warn "Failed to trigger package $pkg";
}

