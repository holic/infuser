express = require 'express'
https = require 'https'
url = require 'url'
fs = require 'fs'
path = require 'path'
glob = require 'glob'
npm = require '../package.json'
coffee = require 'coffee-script'

# load SSL certificate
key = fs.readFileSync './ssl/key.pem', 'binary'
cert = fs.readFileSync './ssl/cert.pem', 'binary'

app = express()
server = https.createServer {key, cert}, app

app.configure ->
	app.use express.logger 'dev'



patterns = (domain) ->
	parts = domain.split '.'

	list = []
	list.unshift "_after/*", "_after"
	list.unshift "#{domain}/*", "#{domain}"
	
	loop
		sub = parts.join '.'
		list.unshift ".#{sub}/*", ".#{sub}"
		parts.shift()
		break unless parts.length

	list.unshift "_before/*", "_before"
	list


resolve = (relative) ->
	path.resolve process.env.HOME, ".js", relative

find = (domain, exts...) ->
	list = []
	for pattern in patterns domain
		for ext in exts
			list = list.concat glob.sync resolve "#{pattern}.#{ext}"
	list

app.get '/:domain.js', (req, res, next) ->
	{domain} = req.params
	return next() unless domain

	# find files by patterns
	files = find domain, "js", "coffee"

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
			lines.push """
				console.error("[injector]", #{JSON.stringify(file)}, "\\n\\n", #{JSON.stringify(e.stack)});
			"""
		lines.push ""

	# send compiled source
	res.format
		js: -> res.send lines.join "\n"


app.get '/:domain.css', (req, res, next) ->
	{domain} = req.params
	return next() unless domain

	# find files by patterns
	files = find domain, "css"

	# compile sources
	lines = ["/*  #{npm.name} [#{npm.version}]  */"]
	for file in files
		lines.push "", "/*", "**  #{file}", "*/", ""
		try
			source = fs.readFileSync file, 'utf8'
			lines.push source
		catch e
			lines.push "/* ERROR: #{e.message} */"
		lines.push ""

	# send compiled source
	res.format
		css: -> res.send lines.join "\n"


server.listen process.env.PORT or 3131, ->
	{address, port} = server.address()
	console.log "Listening on #{address}:#{port}"
