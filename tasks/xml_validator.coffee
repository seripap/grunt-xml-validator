#
# grunt-xml-validator
# https://github.com/panzic/grunt-xml-validator
#
# Copyright (c) 2014 Carlo 'kj'
# Licensed under the MIT license.
#

module.exports = (grunt) ->

	grunt.registerMultiTask('xml_validator', 'Grunt plugin to validate XML files', () ->

		DOMParser = require('xmldom').DOMParser
		ProgressBar = require('progress')
		bar = new ProgressBar('Checking XMLs [:bar] :percent :etas', {
			width: 20,
			total: this.filesSrc.length
		})

		valid = 0
		fail = false
		this.filesSrc.forEach( (f) ->

			xml = grunt.file.read(f)

			doc = new DOMParser({
				locator:{},

				errorHandler: (level, msg) ->
					fail = true
					grunt.log.error f + "\tnot valid"

			}).parseFromString(xml,'text/xml')
			bar.tick()
		)

		if fail
			grunt.fail.warn 'Some files are not valid'
		else
			grunt.log.ok this.filesSrc.length + ' files valid'

	)
