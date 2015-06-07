axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
css_pipeline = require 'css-pipeline'
browserify   = require 'roots-browserify'
dynContent   = require 'dynamic-content'


module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  extensions: [
    dynContent(write: 'content.json')
    browserify(files: 'assets/js/main.coffee', out: 'js/build.js', minify: false, hash: true, sourceMaps: true)
    css_pipeline(files: 'assets/css/*.styl')
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
    
  browserify:
    sourceMap: true
    
  server:
    'clean-urls': true
    'spa': true
    'error_page': 'index.html'
    gzip: true
