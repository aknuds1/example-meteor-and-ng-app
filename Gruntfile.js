/*global module*/
module.exports = function (grunt) {
    var shell = require('shelljs');
    grunt.initConfig({
    });

    grunt.registerTask('install', 'Install dependencies', function () {
        shell.exec('npm install');
    });

    grunt.registerTask('mrt', 'Run development server', function () {
        grunt.task.requires('install');
        shell.exec('cd src && mrt');
    });

    grunt.registerTask('default', ['install', 'mrt']);
};