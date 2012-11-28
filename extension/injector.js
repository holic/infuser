(function() {

	var domain = this.location.hostname.replace(/^www\./, ''),
		js = 'https://localhost:3131/' + domain + '.js';
	
	var script = document.createElement('script'),
		parent = document.head || document.documentElement || document.body;
	script.src = js;
	script.async = true;
	script.onload = function() {
		this.parentNode.removeChild(this);
		console.log('[injector][%s] Loaded script %s', domain, js);
	};
	script.onerror = function() {
		console.error('[injector][%s] Failed to load script %s\n\tIs the server running?\n\tIs AdBlock preventing the script from loading?', domain, js);
	};
	parent.appendChild(script);

}).call(this);