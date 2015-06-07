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
    browserify(files: 'assets/js/main.coffee', out: 'js/build.js', minify: true, hash: true)
    css_pipeline(files: 'assets/css/*.styl', minify: true)
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]

  server:
    'clean-urls': true
    'spa': true
    'error_page': 'index.html'
    gzip: true
