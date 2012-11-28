// ==UserScript==
// @name           infuser
// @namespace      kingersoll@gmail.com
// @version        0.0.1
// @include        http://*/*
// @include        https://*/*
// ==/UserScript==

(function() {

	var domain = this.location.hostname.replace(/^www\./, ''),
		url = 'https://localhost:3131/' + domain,
		js = url + '.js'
		css = url + '.css';
	
	var parent = document.head || document.documentElement || document.body;


	var script = document.createElement('script');
	script.src = js;
	script.async = true;
	script.onload = function() {
		// this.parentNode.removeChild(this);
		console.info('[infuser][%s] Loaded script %s', domain, js);
	};
	script.onerror = function() {
		console.error('[infuser][%s] Failed to load script %s\n\tIs the server running?\n\tIs AdBlock preventing the script from loading?', domain, js);
	};
	parent.appendChild(script);


	var styles = document.createElement('link');
	styles.rel = 'stylesheet';
	styles.href = css;
	styles.onload = function () {
		// this.parentNode.removeChild(this);
		console.info('[infuser][%s] Loaded stylesheet %s', domain, css);
	};
	styles.onerror = function() {
		console.error('[infuser][%s] Failed to load stylesheet %s\n\tIs the server running?\n\tIs AdBlock preventing the stylesheet from loading?', domain, css);
	};
	parent.appendChild(styles);


}).call(this);
