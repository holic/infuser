# infuser
---
### Infuse web pages with your own JS and CSS
Heavily inspired by [dotjs](https://github.com/defunkt/dotjs), **infuser** matches and loads JS, CoffeeScript, and CSS files from `~/.infuser` into web pages based on their domain name.


## Install

**infuser** requires [Node.js with npm](http://nodejs.org/) (`brew install nodejs`) and [forever](https://github.com/nodejitsu/forever) (`npm install -g forever`).

To install:

1. `git clone git://github.com/holic/infuser.git`
2. `cd infuser`
3. `npm install`
4. `forever start lib/server.js`
5. Then install the Chrome extension or userscript from **infuser**'s `extension` directory. Navigate to [your Chrome extensions](chrome://chrome/extensions) and:
   * For the Chrome extension, toggle on "Developer mode", click "Load unpacked extension…", and select **infuser**'s' `extension` directory.
   * For the userscript, drag the `infuser.user.js` into the window. The userscript may also be usable in Firefox or Safari, but is untested.


## Example

A request to `https://www.google.com/`, for example, will compile and load a JS file and a CSS file by matching the following:

#### Compile order of `/google.com.js`
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

#### Compile order of `/google.com.css`
```
~/.infuser/_before/*.css
~/.infuser/_before.css
~/.infuser/.com/*.css
~/.infuser/.com.css
~/.infuser/.google.com/*.css
~/.infuser/.google.com.css
~/.infuser/google.com/*.css
~/.infuser/google.com.css
~/.infuser/_after/*.css
~/.infuser/_after.css
```

*Note: the `www.` prefix is ignored.*
