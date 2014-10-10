# Mongoose Webdriver

[![NPM
version](http://img.shields.io/npm/v/mongoose-webdriver.svg?style=flat)](https://www.npmjs.org/package/mongoose-webdriver)
[![Build Status](http://img.shields.io/travis/goodeggs/mongoose-webdriver/master.svg?style=flat)](https://travis-ci.org/goodeggs/mongoose-webdriver)
[![MIT License](http://img.shields.io/badge/license-mit-blue.svg?style=flat)](https://github.com/goodeggs/mongoose-webdriver/blob/master/LICENSE.md)

Make [mongoose](http://mongoosejs.com/) queries in the [selenium-webdriver](http://docs.seleniumhq.org/projects/webdriver/) control flow.

## Usage

```
npm install mongoose-webdriver
```

```javascript
mongooseWebdriver = require('mongoose-webdriver');
```

## FAQs

- **Does it work with [Protractor](http://angular.github.io/protractor/)?**
  Yes! Mongoose-webdriver will work with Protractor. It will even wait for
  Angular to finish all it's background http requests before it runs your
  Mongoose queries.

## Contributing

Please follow our [Code of Conduct](https://github.com/goodeggs/mongoose-webdriver/blob/master/CODE_OF_CONDUCT.md) when contributing to this project.

```
$ git clone https://github.com/goodeggs/mongoose-webdriver && cd mongoose-webdriver
$ npm install
$ npm test
```
