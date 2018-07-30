# Flask
- 官网文档: http://flask.pocoo.org/docs/1.0/
# 安装
```
# pip install flask
# flask --help
Usage: flask [OPTIONS] COMMAND [ARGS]...

  A general utility script for Flask applications.

  Provides commands from Flask, extensions, and the application. Loads the
  application defined in the FLASK_APP environment variable, or from a
  wsgi.py file. Setting the FLASK_ENV environment variable to 'development'
  will enable debug mode.

    $ export FLASK_APP=hello.py
    $ export FLASK_ENV=development
    $ flask run

Options:
  --version  Show the flask version
  --help     Show this message and exit.

Commands:
  routes  Show the routes for the app.
  run     Runs a development server.
  shell   Runs a shell in the app context.

# flask run -h 0.0.0.0
   * Serving Flask app "hello.py" (lazy loading)
   * Environment: development
   * Debug mode: on
   * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
   * Restarting with stat
   * Debugger is active!
   * Debugger PIN: 473-135-065
  10.1.16.45 - - [30/Jul/2018 16:42:03] "GET / HTTP/1.1" 200 -
  10.1.16.45 - - [30/Jul/2018 16:42:03] "GET /favicon.ico HTTP/1.1" 404 -
  10.1.16.45 - - [30/Jul/2018 16:42:05] "GET / HTTP/1.1" 200 -
```
