| --------- | master | develop | feature |
| --------- | ------ | ------- | ------- |
| Build     | [![Build Status](https://travis-ci.org/TransformCore/CSR-Fast-Stream-frontend.svg?branch=master)](https://travis-ci.org/TransformCore/CSR-Fast-Stream-frontend) | [![Build Status](https://travis-ci.org/TransformCore/CSR-Fast-Stream-frontend.svg?branch=develop)](https://travis-ci.org/TransformCore/CSR-Fast-Stream-frontend) | --- |
| Coverage  | [![Code Coverage](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/?branch=master) | [![Code Coverage](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/badges/coverage.png?b=develop)](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/?branch=develop) | --- |
| Analysis  | [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/?branch=master) | [![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/badges/quality-score.png?b=develop)](https://scrutinizer-ci.com/g/TransformCore/CSR-Fast-Stream-frontend/?branch=develop) | --- |
| json deps | --- | [![Dependency Status](https://www.versioneye.com/user/projects/548074486c47671a210004a1/badge.svg?style=flat)](https://www.versioneye.com/user/projects/548074486c47671a210004a1) | --- |
| lock deps | --- | [![Dependency Status](https://www.versioneye.com/user/projects/548074516c476712ab000379/badge.svg?style=flat)](https://www.versioneye.com/user/projects/548074516c476712ab000379) | --- |

# CSR-Fast-Stream-frontend

Latest deploy (inc. branches) https://csr-frontend-ci.herokuapp.com/en/

**Note: if you get an error, wait a minute & try again (refresh the page), the Application is probably deploying out or has gone to sleep.**

## Table of Contents

* [Contribution guidelines](/CONTRIBUTING.md)
* [Definition of Done](/doc/DefinitionOfDone.md)
* [Versioning successful builds - Release Candidates](/doc/Versioning.md)
* [Localisation](/doc/Localisation.md)
* [PageLayout](/doc/PageLayout.md)
* [Registration](/doc/Registration.md)

## Setup App

1. Install dependencies with **Composer**

```
php composer.phar install
```

## Run App

1. `make dev.run`

Optionally add a **branch / release tag** `make dev.run branch=feature/story-123`

This will run the following:
* Switch to **branch / release** tag if requested
* Install any/all dependencies (composer install)
* Rebuild the database with fixtures
* Start WebServer

2. Then go to `http://localhost:8000`

## Run full test suite in parallel

```
make test.run
```

This Rebuild the database & will run the commands below.

### Behat command (using config in test/behat.yml)

```
make symfony.test.bdd
```

### PHPSpec

```
make symfony.test.spec
```

### PHPUnit

```
make symfony.test.unit
```

## Rebuild database

[Reference](https://github.com/eddiejaoude/dev-helper-cmds#database)

```
make symfony.dev.rebuild
```

---

These commands are only **wrappers**, you can still use the original commands if you wish.

More information on commands available visit [Make CMDs lib](https://github.com/eddiejaoude/dev-helper-cmds#built-in-commands)

---
---

## Contributions

Please read on [Contribution Guildlines](/CONTRIBUTING.md)
