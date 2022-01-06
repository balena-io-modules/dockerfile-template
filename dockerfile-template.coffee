dockerfileTemplate = require './lib'
program = require 'commander'
Promise = require 'bluebird'
fs = Promise.promisifyAll(require 'fs')
{ errno } = require 'errno'

define = (def, defs) ->
	match = def.match(/^([A-Z][A-Z_]+)=(.*)/)
	if not match
		program.help()
		program.exit()
	[ _, variable, value ] = match
	defs[variable] = value
	defs

program
.usage('[options]')
.version(require('./package.json').version)
.option '-f, --filename <templatefile>',
	'template file to process (default: Dockerfile.template)',
	'Dockerfile.template'
.option '-d, --define [VARIABLE=value]',
	'replace variable with value (repeatable option)',
	define,
	{}
.parse(process.argv)

fs.readFileAsync(program.filename, 'utf-8')
.catch Promise.OperationalError, (e) ->
	desc = errno[e.errno].description
	console.error("Error reading '#{program.filename}': #{desc}")
	process.exit(1)
.then (body) ->
	res = dockerfileTemplate.process(body, program.define)
	process.stdout.write(res)
.catch ReferenceError, (e) ->
	console.error(e.message)
.catch (e) ->
	console.error('Unknown error:', e)
