# nodenv-npm-rehash

[![Build Status](https://img.shields.io/travis/jawshooah/nodenv-npm-rehash/master.svg)](https://travis-ci.org/jawshooah/nodenv-npm-rehash)

**Never run `nodenv rehash` again.** This nodenv plugin automatically
runs `nodenv rehash` every time you install or uninstall an npm package.

Forked from [`yyuu/pyenv-pip-rehash`](https://github.com/yyuu/pyenv-pip-rehash).

## Installation

### Installing as a nodenv plugin

Make sure you have [nodenv](https://github.com/OiNutter/nodenv) 0.2.0 or later,
then run:

    git clone https://github.com/jawshooah/nodenv-npm-rehash.git ~/.nodenv/plugins/nodenv-npm-rehash


### Installing with Homebrew (for OS X users)

Mac OS X users can install nodenv-npm-rehash with the
[Homebrew](http://brew.sh) package manager.

*This is the recommended method of installation if you installed nodenv
 with Homebrew.*

```
$ brew install jawshooah/nodenv/nodenv-npm-rehash
```

Or, if you would like to install the latest development release:

```
$ brew install --HEAD jawshooah/nodenv/nodenv-npm-rehash
```

## Usage

1. `npm install --global` a package that provides executables.
2. Marvel at how you no longer need to type `nodenv rehash`.

## How It Works

nodenv-npm-rehash hooks every invokation of `npm` commands via `nodenv`.
If the first argument for `npm` is `install` or `uninstall`, it invokes `nodenv rehash` automatically.

## License

(The MIT License)

Copyright (c) 2015 Joshua Hagins

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINnpmENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
