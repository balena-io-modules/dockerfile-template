{ process } = require '../lib'
{ expect } = require 'chai'

describe 'process', ->
	it 'should allow empty body', ->
		expect(process('')).to.equal('')
	it 'should throw ReferenceError when body has unknown variables', ->
		expect(-> process('%%UNKNOWN%%')).to.throw(ReferenceError)
	it 'should allow variables that do not exist in the body', ->
		expect(process('test', { NOT_USED: 1 })).to.equal('test')
	it 'should replace single variable lines', ->
		expect(process('%%TEST%%', { TEST: 'value' })).to.equal('value')
	it 'should replace multiple variables per line', ->
		expect(process('FROM %%BASE%%:%%TAG%%', { BASE: 'debian', TAG: 'latest' })).to.equal('FROM debian:latest')
	it 'should replace variables in multiple lines', ->
		template = '''
			FROM %%BASE%%:%%TAG%%
			ENV TAG %%TAG%%
		'''
		variables =
			BASE: 'debian'
			TAG: 'latest'
		result = '''
			FROM debian:latest
			ENV TAG latest
		'''
		expect(process(template, variables)).to.equal(result)
	it 'should ignore lines with comments', ->
		expect(process('# %%TAG%%', TAG: 'latest')).to.equal('# %%TAG%%')

		template = '''
			FROM %%BASE%%:%%TAG%%
			ENV TAG %%TAG%%
			# %%VAR%% will be replaced on next line
			RUN echo %%VAR%%
		'''
		variables =
			BASE: 'debian'
			TAG: 'latest'
			VAR: 'value'
		result = '''
			FROM debian:latest
			ENV TAG latest
			# %%VAR%% will be replaced on next line
			RUN echo value
		'''
		expect(process(template, variables)).to.equal(result)
