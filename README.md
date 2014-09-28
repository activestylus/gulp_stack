This is a highly opinionated and production-ready replacement for sprockets. I got tired of those ridiculously long compile times and managed to shave a good 10-15 minutes off my deploys.

Under the Hood
==============

* Compile Livescript
* Compile Stylus
* Concatenate all vendor libs
* Uses gulp-include to concat app files (a la Sprockets)
* Add cache busting digest to files
* LiveReload in development

Directory Structure
===================
```
myapp
├── frontend
|  ├── styles
|  ├── scripts
|  ├── images
├── public
|  ├── dist
|  |  ├── js,css,images compiled here
```