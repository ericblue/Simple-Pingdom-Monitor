# Simple-Pingdom-Monitor
Simple Pingdom Monitor - Embedded Mojolicious HTTP server with basic end points for return success or fail on custom HTTP checks

[Usage]

```
# ./pingdom.pl
Usage: APPLICATION COMMAND [OPTIONS]

  mojo version
  mojo generate lite_app
  ./myapp.pl daemon -m production -l http://*:8080
  ./myapp.pl get /foo
  ./myapp.pl routes -v

Tip: CGI and PSGI environments can be automatically detected very often and
     work without commands.

Options (for all commands):
  -h, --help          Get more information on a specific command
      --home <path>   Path to home directory of your application, defaults to
                      the value of MOJO_HOME or auto-detection
  -m, --mode <name>   Operating mode for your application, defaults to the
                      value of MOJO_MODE/PLACK_ENV or "development"

Commands:
 cgi       Start application with CGI
 cpanify   Upload distribution to CPAN
 daemon    Start application with HTTP and WebSocket server
 eval      Run code against application
 generate  Generate files and directories from templates
 get       Perform HTTP request
 inflate   Inflate embedded files to real files
 prefork   Start application with preforking HTTP and WebSocket server
 psgi      Start application with PSGI
 routes    Show available routes
 test      Run tests
 version   Show versions of available modules

See 'APPLICATION help COMMAND' for more information on a specific command.
```

[Launching]

```
# ./pingdom.pl daemon -l http://*:5000
[Mon Jan  2 14:45:14 2017] [info] Listening at "http://*:5000"
Server available at http://127.0.0.1:5000
[Mon Jan  2 14:45:22 2017] [debug] GET "/"
[Mon Jan  2 14:45:22 2017] [debug] Routing to a callback
[Mon Jan  2 14:45:22 2017] [debug] Rendering template "index.html.ep" from DATA section
[Mon Jan  2 14:45:22 2017] [debug] Rendering template "layouts/default.html.ep" from DATA section
[Mon Jan  2 14:45:22 2017] [debug] 200 OK (0.002745s, 364.299/s)
[Mon Jan  2 14:45:32 2017] [debug] GET "/missing"
[Mon Jan  2 14:45:32 2017] [debug] Template "not_found.development.html.ep" not found
[Mon Jan  2 14:45:32 2017] [debug] Template "not_found.html.ep" not found
[Mon Jan  2 14:45:32 2017] [debug] Rendering template "mojo/debug.html.ep"
[Mon Jan  2 14:45:32 2017] [debug] Rendering template "mojo/menubar.html.ep"
[Mon Jan  2 14:45:32 2017] [debug] Your secret passphrase needs to be changed
[Mon Jan  2 14:45:32 2017] [debug] 404 Not Found (0.025866s, 38.661/s)
[Mon Jan  2 14:45:39 2017] [debug] GET "/check/example"
[Mon Jan  2 14:45:39 2017] [debug] Routing to a callback
[Mon Jan  2 14:45:40 2017] [debug] 200 OK (0.0556s, 17.986/s)

```

[Example Output]

```
Request: http://localhost:5000/check/example

Output: text/xml

<pingdom_http_custom_check>
    <status>ERROR</status>
    <response_time>1000</response_time>
</pingdom_http_custom_check> 

- OR if Check succeeds - 

<pingdom_http_custom_check>
    <status>OK</status>
    <response_time>1000</response_time>
</pingdom_http_custom_check> 

```
