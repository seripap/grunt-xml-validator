(function() {
  module.exports = function(grunt) {
    return grunt.registerMultiTask('xml_validator', 'Grunt plugin to validate XML files', function() {
      var DOMParser, ProgressBar, bar, fail, valid;
      DOMParser = require('xmldom').DOMParser;
      ProgressBar = require('progress');
      bar = new ProgressBar('Validating XML [:bar] :percent :etas', {
        width: 20,
        total: this.filesSrc.length
      });
      valid = 0;
      fail = false;
      this.filesSrc.forEach(function(f) {
        var doc, xml;
        xml = grunt.file.read(f);
        doc = new DOMParser({
          locator: {},
          errorHandler: function(level, msg) {
            fail = true;
            return grunt.log.error(f + "\tnot valid");
          }
        }).parseFromString(xml, 'text/xml');
        return bar.tick();
      });
      if (fail) {
        return grunt.fail.warn('Some files are not valid');
      } else {
        return grunt.log.ok(this.filesSrc.length + ' files valid');
      }
    });
  };

}).call(this);
