module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')


    path:
      dist: './web/dist/<%= pkg.name %>-<%= pkg.version %>/'


    clean:
      dist:
        src: ['<%= path.dist %>**']


    coffee:
      app:
        files: [
          expand: true,
          cwd: 'web/src/app/'
          dest: '<%= path.dist %>js'
          src: '*.coffee'
          ext: '.js'
        ]


    coffeelint:
      all: ['Gruntfile.coffee', 'src/app/app.coffee']


    copy:
      api:
        files: [
          dot: true
          expand: true
          cwd: 'web/src/api/0/'
          src: ['**']
          dest: '<%= path.dist %>api/0/'
        ,
          expand: true
          cwd: 'composer_modules/slim/slim/Slim/'
          src: ['**']
          dest: '<%= path.dist %>api/0/lib/Slim/'
        ]

      app:
        files: [
          expand: true
          cwd: 'web/src/app/'
          src: ['index.php']
          dest: '<%= path.dist %>'
        ,
          expand: true
          cwd: 'bower_modules/angular/'
          src: ['angular.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/angular-route/'
          src: ['angular-route.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/angular-ui-bootstrap-bower/'
          src: ['ui-bootstrap-tpls.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/bootstrap/dist/css/'
          src: ['bootstrap.min.css']
          dest: '<%= path.dist %>/css/'
        ,
          expand: true
          cwd: 'bower_modules/bootstrap/dist/fonts/'
          src: ['**']
          dest: '<%= path.dist %>/fonts/'
        ,
          expand: true
          cwd: 'bower_modules/bootstrap/dist/js/'
          src: ['bootstrap.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/chartjs'
          src: ['Chart.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/font-awesome/css/'
          src: ['font-awesome.min.css']
          dest: '<%= path.dist %>/css/'
        ,
          expand: true
          cwd: 'bower_modules/font-awesome/fonts/'
          src: ['**']
          dest: '<%= path.dist %>/fonts/'
        ,
          expand: true
          cwd: 'bower_modules/jquery/'
          src: ['jquery.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/lodash/dist'
          src: ['lodash.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/momentjs/min'
          src: ['moment.min.js']
          dest: '<%= path.dist %>/js/'
        ,
          expand: true
          cwd: 'bower_modules/ng-grid'
          src: ['ng-grid.min.css']
          dest: '<%= path.dist %>/css/'
        ,
          expand: true
          cwd: 'bower_modules/ng-grid'
          src: ['ng-grid-2.0.7.min.js']
          dest: '<%= path.dist %>/js/'
        ]

      deploy:
        dot: true
        expand: true
        cwd: '<%= path.dist %>'
        src: ['**']
        dest: '/Library/Webserver/Documents/trailer/'


    html2js:
      options:
        base: 'web/src'
        module: 'appViews'
      all:
        src: ['web/src/app/*_view.html']
        dest: '<%= path.dist %>/js/app-views.js'


    jshint:
      all: ['*.json']


    ngmin:
      all:
        src: ['<%= path.dist %>js/app.js']
        dest: '<%= path.dist %>js/app.js'


    watch:
      all:
        files: ['web/src/api/0/**', 'web/src/app/**']
        tasks: [
          'jshint'
          'coffeelint'
          'coffee'
          'newer:copy:api'
          'newer:copy:app'
          'html2js'
          'ngmin'
          'newer:copy:deploy'
        ]


    require('load-grunt-tasks')(grunt)


    grunt.registerTask 'deploy', [
      'copy:deploy'
    ]


    grunt.registerTask 'default', [
      'jshint'
      'coffeelint'
      'coffee'
      'copy:api'
      'copy:app'
      'html2js'
      'ngmin'
    ]
