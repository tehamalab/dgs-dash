# dgs-dash

A web based interface for sharing and visualizing Development Goals data.

## Technology

This is a client-side application built using [AngulatJS](https://angularjs.org/) fueled by DGs platform API: https://github.com/tehamalab/dgs


## Installation

Building the source code requires `NodeJs`, `npm`, `bower`, `grunt` and `compass` as dependancies.
You may also want to install [yeoman](https://github.com/yeoman/generator-angular) in order to simplify scaffolding during development.

To use the source code for development install the above global dependencies;

Download the source code;

    git clone https://github.com/tehamalab/dgs-dash.git

Move to the project directory;

    cd dgs-dash

Install javascript dependencies;

    npm install
    bower install

You are good to go.

## Running the development server

    grunt serve

## Testing

Running `grunt test` will run the unit tests with karma.

## Building the project

    grunt

## Deployment

After successful building the using `grunt` command a folder called `dist` will created within your project directory. The `dist` forder will contain source code which can be server by almost any web server as a a collection of simple static files.

Since by default HTML5 mode is enabled in the application you may need to adjust your server configuration. For more information on AngularJS HTML 5 mode check online.

For example for Nginx you can have a site configuration file similar to

    server {
        listen 80;
        server_name yourdomain.com

        location / {
            root           /path/to/dgs-dash/dist;
            try_files      $uri$args $uri$args/ $uri  /index.html;
        }
    }
