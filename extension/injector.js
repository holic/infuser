var domain = this.location.hostname.replace(/^www\./, '');

// var xhr = new XMLHttpRequest();
// xhr.open('GET', 'https://localhost:3131/' + domain + '.js', true);
// xhr.onreadystatechange = function() {
// 	if (xhr.readyState == 4) {
// 		eval(xhr.responseText);
// 	}
// }
// xhr.send();

var script = document.createElement('script');
script.type = 'text/javascript'
script.async = true
script.src = 'https://localhost:3131/' + domain + '.js';

var parent = document.querySelector('head, body');
if (parent) {
	parent.appendChild(script);
}
else {
	console.error('Could not find parent for script', script);
}
