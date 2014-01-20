module.exports = (grunt) ->
    grunt.initConfig(
        pkg: grunt.file.readJSON('package.json')
        coffee:
            build:
                files:
                    'lifethree.js': ['lifethree.coffee']

        uglify:
            options:
                report: 'gzip'
                banner: '// <%= pkg.name %> - <%= grunt.template.today("yyyy-mm-dd") %>\r\n'
            compress:
                files:
                    'lifethree.min.js': ['lifethree.js']

        clean: ['lifethree.js']
    )

    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-clean')

    grunt.registerTask('default', ['coffee', 'uglify', 'clean'])