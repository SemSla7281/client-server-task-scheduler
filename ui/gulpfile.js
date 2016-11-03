var gulp = require('gulp');
    watch = require('gulp-watch');
    browserSync = require('browser-sync').create();
    concat = require('gulp-concat');

gulp.task('scripts', function() {
  return gulp.src('src/**/*.js')
    .pipe(concat('main.js'))
    .pipe(gulp.dest('dist'));
});

gulp.task('styles', function() {
  return gulp.src('assets/**/*.css')
    .pipe(concat('main.css'))
    .pipe(gulp.dest('dist'));
});

gulp.task('bs-reload', function () {
  browserSync.reload();
});

gulp.task('watch', function() {
  browserSync.init({
    server: ".",
    port: 8080,
    ui: false,
    notify: false
  });

  gulp.watch('src/**/*.js', ['bs-reload']);
  gulp.watch("assets/*.css", ['bs-reload']);
  gulp.watch(['src/**/*.html', 'index.html'], ['bs-reload']);
});

gulp.task('default', ['watch', 'scripts', 'styles']);
