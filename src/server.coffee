express = require 'express'
http = require 'http'
url = require 'url'
fs = require 'fs'
path = require 'path'
glob = require 'glob'
npm = require '../package.json'
coffee = require 'coffee-script'


app = express()
server = http.createServer app
# http://www.hacksparrow.com/node-js-https-ssl-certificate.html


resolve = (relative) ->
	path.resolve process.env.HOME, ".js", relative

find = (relative) ->
	console.log resolve(relative)
	glob.sync resolve(relative)


app.get '/:domain.js', (req, res, next) ->
	# create glob patterns
	{domain} = req.params
	parts = domain.split '.'

	patterns = []
	patterns.unshift "_after/*.js", "_after.js"
	patterns.unshift "#{domain}/*.js", "#{domain}.js"
	
	loop
		sub = parts.join '.'
		patterns.unshift ".#{sub}/*.js", ".#{sub}.js"
		parts.shift()
		break unless parts.length

	patterns.unshift "_before/*.js", "_before.js"

	# find files by patterns
	files = []
	for pattern in patterns
		# find javascripts
		files = files.concat find pattern
		# find coffeescripts
		files = files.concat find pattern.replace /\.js$/, '.coffee'

	# compile sources
	lines = ["//  #{npm.name} [#{npm.version}]"]
	for file in files
		lines.push "", "/*", "**  #{file}", "*/", ""
		try
			source = fs.readFileSync file, 'utf8'
			# compile coffeescript
			if '.coffee' is path.extname file
				source = coffee.compile source, bare: true
			lines.push "(function() {", source, "}).call(this);"
		catch e
			lines.push "// ERROR: #{e.message}"
		lines.push ""

	res.format
		js: -> res.send lines.join "\n"


server.listen process.env.PORT or 3131, ->
	{address, port} = server.address()
	console.log "Listening on #{address}:#{port}"
