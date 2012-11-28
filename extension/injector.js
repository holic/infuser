(function() {

	var domain = this.location.hostname.replace(/^www\./, ''),
		js = 'https://localhost:3131/' + domain + '.js';
		
	var xhr = new XMLHttpRequest();
	xhr.open('GET', js, true);
	xhr.onreadystatechange = function() {
		if (xhr.readyState != 4) return;
		if (xhr.status != 200) return console.error('[injector][%s] Failed to load script, is Adblock enabled?', domain);
		try {
			eval(xhr.responseText);
			console.log('[injector][%s] Loaded script %s', domain, js);
		}
		catch (e) {
			console.trace()
			console.error('[injector][%s] Failed to load script %s\n\n', domain, js, e.stack)
		}
	};
	xhr.send();

}).call(this);