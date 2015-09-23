template = require 'lodash.template'

# Proccess a dockerfile template, replacing variables with their values.
#
# Variables have the format %%VARIABLE_NAME%%, where the variable name
# starts with an uppercase letter and then uppercase letters or underscores.
#
# Lines that are Dockerfile comments are not processed, but included in the output.
#
# @param {String} body The dockerfile template contents.
# @param {Object} variables Variable names and their replacement values as key-value pairs.
#
# Examples:
# processTemplate('FROM %%BASE_IMAGE%%', { 'BASE_IMAGE': 'debian')
# => 'FROM debian'
#
# processTemplate('# %%BASE_IMAGE%% is not replaced in comments', { 'BASE_IMAGE': 'debian' })
# => '# %%BASE_IMAGE%% is not replaced in comments'
exports.process = (body, variables) ->
	body.split('\n')
	.map (line) ->
		# The '#' symbol is interpreted as a comment only at the start of the line
		if line[0] != '#'
			template(line, interpolate: /%%([A-Z][A-Z_]+)%%/)(variables)
		else
			line
	.join('\n')
