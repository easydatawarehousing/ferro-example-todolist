# README
This repo is a simple example for getting started with the 
[opal-ferro](https://github.com/easydatawarehousing/opal-ferro).
ruby gem. It is a Rails 5.1 application with some frontend code.

This application implements a simple todo-list. This list only resides
in the webbrowser, data is not sent to or saved in the backend.

## Preparing
Clone this repo and use bundler to get dependencies:

    bundle install

Run development website:

    export RAILS_ENV=development
    rails s

Then visit http://localhost:3000

## Making changes
All the (Ferro) action is in the app/assets/javascripts/components
folder.

## More information
To find more information about Ferro and to see a running example
of this todo-list go
[here](https://easydatawarehousing.github.io/ferro/example3).