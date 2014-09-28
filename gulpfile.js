require('gulp-livescript')
require('./Gulpfile.ls')

// var gulp = require('gulp')
// var gulpBump = require('gulp-bump')
// var gulpUtil = require('gulp-util')
// var gulpLiveScript = require('gulp-livescript');

// var paths = {
//   scripts: ['app/assets/**/*.ls'],
//   styles:  ['app/assets/styles/**/*.styl'],
// };

// gulp.task('ls', function() {
//   return gulp.src('./app/assets/**/*.ls')
//     .pipe(gulpLiveScript({bare: true})
//     .on('error', gulpUtil.log))
//     .pipe(gulp.dest('./public/build/scripts'));
// });

// // gulp.task('stylus', function() {
// //   return gulp.src('./app/*.sass')
// //     .pipe(gulpLiveScript({bare: true})
// //     .on('error', gulpUtil.log))
// //     .pipe(gulp.dest('./public/javascripts'));
// // });

// gulp.task('watch', function() {
//   gulp.watch(paths.scripts, ['ls']);
//   // gulp.watch(paths.scripts, ['stylus']);
//   //gulp.watch(paths.images, ['images']);
// });