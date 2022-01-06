gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'

OPTIONS =
	files:
		coffee: ['dockerfile-template.coffee', 'lib.coffee', 'gulpfile.coffee']

gulp.task 'coffee', ->
	gulp.src(OPTIONS.files.coffee)
	.pipe(coffee(header:true))
	.on('error', gutil.log)
	.pipe(gulp.dest('.'))

gulp.task 'build', gulp.series [
	'coffee'
]

gulp.task 'default', gulp.series ['build']
