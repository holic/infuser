var domain = this.location.hostname.replace(/^www\./, ''),
	js = 'https://localhost:3131/' + domain + '.js';
	
var xhr = new XMLHttpRequest();
xhr.open('GET', js, true);
xhr.onreadystatechange = function() {
	if (xhr.readyState != 4) return;
	if (xhr.status != 200) return console.error('injector: Failed to load script for %s, is Adblock enabled?', domain);
	eval(xhr.responseText);
};
xhr.send();
