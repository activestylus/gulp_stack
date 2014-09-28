src = '../../frontend'
vnd = "#{src}/scripts/vendor"
bowerOpts =
  directory: "#{src}/scripts/vendor"
  deps:
    jquery: { version: '^2.0.0', files: 'dist/jquery.js' }
    moment: { version: '^2.8.3', files: 'moment.js' }
paths =
  vendors:
    "#{vnd}/jquery/dist/jquery.min.js"
    "#{vnd}/moment/min/moment.min.js"
  scripts: ["#{src}/scripts/*.ls"]
  styles:  ["#{src}/styles/*.styl"]
  images: "#{src}/images/**/*"
  fonts: ["#{src}/fonts/**/*"]
dist   = '../../public/dist'
target =
  build    : dist
  js       : "#{dist}/js"
  jsfiles  : "#{dist}/js/*.js"
  css      : "#{dist}/css"
  vendor   : "#{dist}/js/vendor"
  appcss   : "#{dist}/css/app.css"
  appjs    : "#{dist}/css/app.js"
  images   : "#{dist}/img"
  fonts    : "#{dist}/fonts"
targetAssets = ["#{dist}/css/*.css", "#{dist}/js/*.js", "#{dist}/img/*"]

# DEPENDENCIES
browserify  = require 'gulp-browserify'
bower       = (require 'gulp-bower-deps') bowerOpts
changed     = require 'gulp-changed'
clean       = require 'gulp-clean'
concat      = require 'gulp-concat'
filesize    = require 'gulp-filesize'
gulp        = require 'gulp'
debug       = require 'gulp-debug'
gulpif      = require 'gulp-if'
gutil       = require 'gulp-util'
imagemin    = require 'gulp-imagemin'
include     = require 'gulp-include'
livereload  = require 'gulp-livereload'
livescript  = require 'gulp-livescript'
gulpif      = require 'gulp-if'
minifyCSS   = require 'gulp-minify-css'
pngcrush    = require 'imagemin-pngcrush'
revAll      = require 'gulp-rev-all'
stylus      = require 'gulp-stylus'
uglify      = require 'gulp-uglify'
watch       = require 'gulp-watch'
#TASKS
bower.installtask gulp

gulp.task 'bundle', ['bower'], ->
  gulp.src paths.vendors
    .pipe concat 'vendor.js'
    .pipe gulp.dest target.js
    .on    'error', gutil.log

gulp.task 'build_assets', ->
  gulp.src paths.images
    .pipe changed target.images
    .pipe imagemin { use: [ pngcrush() ] }
    .pipe  revAll!
    .pipe  gulp.dest target.images
    .pipe  revAll.manifest { fileName: 'manifest.json' }
    .pipe  gulp.dest target.images
    .on    'error', gutil.log

gulp.task 'js', ->
  gulp.src paths.scripts
    .pipe  changed target.js
    .pipe  include!
    .pipe  livescript { bare: true }
    .pipe  filesize!
    .pipe  gulp.dest target.js
    .pipe  livereload!
    .on    'error', gutil.log

gulp.task 'build_js', ['js'], ->
  gulp.src target.jsfiles
    .pipe  uglify { comments: false }
    .pipe  filesize!
    .pipe  revAll!
    .pipe  gulp.dest target.js
    .pipe  revAll.manifest { fileName: 'manifest.json' }
    .pipe  gulp.dest target.js
    .on    'error', gutil.log

gulp.task 'css', ->
  gulp.src paths.styles
    .pipe  changed target.css
    .pipe  stylus!
    .pipe  gulp.dest target.css
    .pipe  livereload!
    .on    'error', gutil.log

gulp.task 'build_css', ['css'], ->
  gulp.src target.appcss
    .pipe  minifyCSS!
    .pipe  filesize!
    .pipe  revAll!
    .pipe  gulp.dest target.css
    .pipe  revAll.manifest { fileName: 'manifest.json' }
    .pipe  gulp.dest target.css
    .on    'error', gutil.log

gulp.task 'build', ['build_js','build_css','build_assets']

gulp.task 'watch', ->
  livereload.listen!
  gulp.watch bower.deps, ['js'] 
  gulp.watch paths.scripts, ['js']
  gulp.watch paths.styles, ['css']
  gulp.watch dist
    .on 'change', livereload.changed
  
  watch paths.images, (files)->
    files.pipe changed target.images
      .pipe imagemin { use: [ pngcrush() ] }
      .pipe gulp.dest target.images

gulp.task 'reset', ->
  gulp.src target.build, {read: false}
    .pipe clean!
