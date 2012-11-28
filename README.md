# infuser
---
### Infuse web pages with your own JS and CSS
Heavily inspired by [dotjs](https://github.com/defunkt/dotjs), **infuser** matches and loads JS, CoffeeScript, and CSS files from `~/.infuser` into Chrome based on the target web page's domain name.

## Example

A request to `https://www.google.com/`, for example, will compile and load a JS file and a CSS file by matching the following:

#### Compiled `/google.com.js`
```
~/.infuser/_before/*.js
~/.infuser/_before/*.coffee
~/.infuser/before.js
~/.infuser/before.coffee
~/.infuser/.com/*.js
~/.infuser/.com/*.coffee
~/.infuser/.com.js
~/.infuser/.com.coffee
~/.infuser/.google.com/*.js
~/.infuser/.google.com/*.coffee
~/.infuser/.google.com.js
~/.infuser/.google.com.coffee
~/.infuser/google.com/*.js
~/.infuser/google.com/*.coffee
~/.infuser/google.com.js
~/.infuser/google.com.coffee
~/.infuser/_after/*.js
~/.infuser/_after/*.coffee
~/.infuser/_after.js
~/.infuser/_after.coffee
```
*Note: the `www.` prefix is ignored.*

#### Compiled `/google.com.css`
```
~/.infuser/_before/*.css
~/.infuser/before.css
~/.infuser/.com/*.css
~/.infuser/.com.css
~/.infuser/.google.com/*.css
~/.infuser/.google.com.css
~/.infuser/google.com/*.css
~/.infuser/google.com.css
~/.infuser/_after/*.css
~/.infuser/_after.css
```


## Install

**infuser** requires [Node.js with npm](http://nodejs.org/) (`brew install nodejs`), [forever](https://github.com/nodejitsu/forever) (`npm install -g forever`), and the **infuser** Chrome plugin or userscript.

To install:

1. `git clone git://github.com/holic/infuser.git`
2. `cd infuser`
3. `npm install`
4. `forever start lib/server.js`
5. Then install the Chrome extension or userscript in **infuser**'s `extension` directory by dragging the `manifest.json` or `infuser.user.js` into [your Chrome extensions](chrome://chrome/extensions) interface. The userscript may also be usable in Firefox or Safari, but it's untested.