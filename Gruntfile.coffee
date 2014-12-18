#
# Build System for Modeler Project
# Ben Southgate
# 10/07/14
#

deploy_path_list = [
  # INSERT DEPLOY PATH
]

css_dependencies = [
  "css/vendor/bootstrap.min.css"
  "css/main.css"
  "css/nav.css"
  "css/slider.css"
  "css/radio.css"
  "css/miniline.css"
  "css/charts.css"
  "css/grades.css"
  "css/parameters.css"
]

js_dependencies = [
  "./lib/vendor/d3.min.js"
  "./lib/vendor/queue.min.js"
  "./lib/vendor/jquery-1.11.0.js"
  "./lib/vendor/bootstrap.min.js"
  "./lib/vendor/rangeslider.min.js"
]

coffee_source = [
  #
  # BGS helper library
  #
  './src/bgs.coffee'
  #
  # Modeler Classes
  #

  # Base Classes
  './src/modeler/Plot.coffee'
  './src/modeler/Slider.coffee'
  './src/modeler/Model.coffee'

  # Equations
  './src/modeler/Equation.coffee'
  './src/modeler/SocialSecurity.coffee'
  './src/modeler/Salaries.coffee'
  './src/modeler/Accrual.coffee'
  './src/modeler/Deflated.coffee'
  './src/modeler/Account.coffee'
  './src/modeler/Contributions.coffee'

  # Models
  './src/modeler/FAS.coffee'
  './src/modeler/CashBalance.coffee'

  # Cost Calculators
  './src/modeler/FASCost.coffee'
  './src/modeler/CBCost.coffee'

  # Default Model Parameters
  './src/modeler/DefaultParameters.coffee'

  #
  # Interactive Feature Classes
  #
  './src/interactive/Grader.coffee'
  './src/interactive/PlanCost.coffee'
  './src/interactive/MiniLine.coffee'
  #
  # Main calls
  #
  './src/main.coffee'
]


module.exports = (grunt) ->
  # Register configuration
  grunt.initConfig
    copy :
      deploy :
        files : [
          {
            expand: true
            cwd : "json"
            src: ['**']
            dest: "dist/json"
          }
        ].concat(
          {
            expand: true
            cwd : "dist/"
            src: ['**']
            dest: path
          } for path in deploy_path_list
        )
    uglify:
      options:
        mangle: true
        banner : """
/* --- interactive pension model (bsouthga@gmail.com) --- */

"""
      js:
        files:
          './dist/js/main.min.js' : js_dependencies.concat [
            './lib/urban.js'
          ]
    coffee:
      compile:
        options :
          join : true
        files:
          # Concatenate all components and compile
          './lib/urban.js': coffee_source
    watch:
      coffee :
        files: [
          './src/*.coffee',
          './src/interactive/*.coffee',
          './src/modeler/*.coffee'
        ],
        tasks: ['coffee']
      html :
        files : ['./index.html']
      css :
        files : ['./css/*.css']
      options :
        livereload : true
    processhtml :
      dist :
        files :
          './index_dist.html' : ['./index.html']
    htmlmin :
      dist :
        options :
          removeComments: true,
          collapseWhitespace: true
        files :
          './dist/index.html' : './index_dist.html'
    cssmin :
      options :
        keepSpecialComments : 0
        banner : """
/* --- interactive pension model (bsouthga@gmail.com) --- */

"""
      dist :
        files :
          './dist/css/main.min.css' : css_dependencies
    browserSync:
      bsFiles:
        src : [
          './src/*.coffee',
          './src/modeler/*.coffee',
          './src/interactive/*.coffee',
          './css/*.css',
          './index.html'
        ]
      options:
        watchTask: true
        server:
            baseDir: "./"

  libs = [
   'grunt-contrib-uglify'
   'grunt-contrib-watch'
   'grunt-contrib-coffee'
   'grunt-contrib-concat'
   'grunt-contrib-copy'
   'grunt-contrib-htmlmin'
   'grunt-contrib-cssmin'
   'grunt-browser-sync'
   'grunt-processhtml'
  ]
  grunt.loadNpmTasks(pkg) for pkg in libs

  # Coffee compiling, uglifying and watching in order
  grunt.registerTask 'default', [
    'coffee',
    'browserSync',
    'watch'
  ]

  grunt.registerTask 'deploy', [
    'coffee'
    'uglify'
    'cssmin'
    'processhtml'
    'htmlmin'
    'copy'
  ]
