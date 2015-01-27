# Interactive SLEPP Pension Modeler

## Running Model server/desktop-side through NodeJS

The Model code can be used to simulate pensions on the desktop by running the code through NodeJS, after running `npm install` to install dependencies. See [model_test.coffee](https://github.com/UI-Research/pension-modeler/blob/master/test/model_test.coffee) for an example usage.

## Building Web Application

[NodeJS](http://nodejs.org/) is required to build. Once installed, run the following commands:

First install dependencies, then run the following to install local references:

```
npm install
```

"grunt" to build the project and start a dev server

```
grunt
```

runt "grunt deploy" to push the distribution code to the server

```
grunt deploy
```