<a href="https://promisesaplus.com/">
    <img src="https://promisesaplus.com/assets/logo-small.png" alt="Promises/A+ logo"
         title="Promises/A+ 1.0 compliant" align="right" style="width:64px;" />
</a>

# then-mongodb

Let's use Promise/A+ to mongo driver!

Based on mongodb-core and when, to create a simple but easy to use interface for mongo.

And a simple auto-loadable model layer for easy app use.

**Most UPDATES are in develop branch, the master branch will be merged until function test done.**

This Project is still under **DEVELOP! DO NOT USE IT** until it get released!

Any suggest are welcome.

# Modules

## Mongodb object map

MongoDB | Map | This Module
------: | :-: | :----------
Server | 1:1 | Server
Collection | 1:1 | Model
Document | 1:1 | Entity

## Server

Server is the base connection object to mongodb.

Any Operation with server need NameSpace, Operation as raw mode.

## Model

Model with two function:

1. A model class which just bind collection NS;
2. A model loader which can (auto)load your models;

Before model promise do anything, they need a server to do it.

Any Operation with Model mapped to Collection.

## Entity

Entity was made by model:

1. New made by model(or just a object warped)
2. Find from a model(like find from collection)

Any Operation with Entity mapped to Document.
