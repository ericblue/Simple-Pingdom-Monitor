#!/usr/bin/env perl
use Mojolicious::Lite;


# Embedded web server with endpoints for Pingdom Monitoring
# /check/example		Process monitor for Example process
#
# Return success or error XML message conforms to Pingdom's custom http check standard
# This example checks for the existence of a running pid but can be extended to do any check
# and return success or failure 
# 
# Can be run via: ./pingdom.pl daemon -l http://localhost:5000

sub check_process {

    my ($name) = @_;
    
    my $status;
    my $pidinfo = `ps -ef | grep $name | grep -v grep`;
    if (length($pidinfo) > 1) {
       $status = "OK";
    } else {   
        $status = "ERROR";
    }
    
    return $status;
    
}

sub render_status {
    
    my ($c, $status, $total_time) = @_;
    
     my $response = qq{
        <pingdom_http_custom_check>
	    <status>$status</status>
	    <response_time>$total_time</response_time>
	</pingdom_http_custom_check> 
    };
 
    $c->render(format => 'xml', data => $response);
    

}

get '/' => sub {
    my $c = shift;
    $c->render(template => 'index');
    
};

get '/check/example' => sub {
    my $c = shift; 
  
    my $start = time();

    my $status = check_process("example_process_name");

    my $stop = time();

    # time in ms
    my $total_time = ($stop - $start) * 1000;

    render_status($c, $status, $total_time);
 

};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Pingdom Monitor';
<h1>Welcome to the Simple Pingdom Monitor</h1>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
