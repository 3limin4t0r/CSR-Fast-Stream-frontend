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
* [Versioning successful builds - Release Candidates](/doc/Versioning.md)
* [Localisation](/doc/Localisation.md)
* [PageLayout](/doc/PageLayout.md)

## Run app

1. `make dev.run`

Optionally add a **branch / release tag** `make dev.run branch=build-feature/symfony2-behat-35`

This will run the following:
* Switch to **branch / release** tag if requested
* Install any/all dependencies (composer install)
* Start WebServer

2. Then go to `http://localhost:8000`


## Behat command (use config in test/behat.yml)

Documentation at http://docs.behat.org/en/latest/quick_intro_pt1.html

```
make test.bdd
```

## PHPSpec

To run PHPSpec suite `make test.spec`

Results:
```
                       100%                        1
1 specs
1 example (1 passed)
21ms
```

## PHPUnit

To run PHPSpec suite `make test.unit`

## Run full test suite in parallel

```
make test.run
```

```
 [Robo\Task\ParallelExecTask] bin/phpspec run  --config test/phpspec.yml
 [Robo\Task\ParallelExecTask] bin/behat --config test/behat.yml "@TransformAppBundle"
 [Robo\Task\ParallelExecTask] Processes: 1/2 [==============>-------------]  50%
 [Robo\Task\ParallelExecTask] Output for  bin/phpspec run  --config test/phpspec.yml 
/  pending: 0%  / passed: 100%  /  failed: 0%   /  broken: 0%   /  1 examples
1 specs
1 example (1 passed)
9ms

 [Robo\Task\ParallelExecTask] Processes: 2/2 [============================] 100%
 [Robo\Task\ParallelExecTask] Output for  bin/behat --config test/behat.yml "@TransformAppBundle"
No scenarios
No steps
0m0.005s


 [Robo\Task\ParallelExecTask] 2 processes ended in 0.18 s
```

## Contributions

Please read on [Contribution Guildlines](/CONTRIBUTING.md)
