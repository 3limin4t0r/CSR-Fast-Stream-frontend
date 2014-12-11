# parameters
GIT_TAG=build-$(TRAVIS_BRANCH)-$(TRAVIS_BUILD_NUMBER)

check:
	php app/check.php

# COMPOSER ------------------------------------------------------------------------------------
composer.install:
	if [ ! -f "composer.phar" ] ; then curl -s http://getcomposer.org/installer | php ; fi
	php composer.phar install --dev --no-interaction

composer.update:
	php composer.phar upate

# TEST ---------------------------------------------------------------------------------------

test.run:
	bin/robo parallel:run

test.bdd:
	bin/behat --config test/behat.yml --suite=transformcore_app

test.spec:
	bin/phpspec run  --config test/phpspec.yml

test.unit:
	bin/phpunit --configuration app

# BUILD --------------------------------------------------------------------------------------

scrutinizer.coverage:
	wget https://scrutinizer-ci.com/ocular.phar
	php ocular.phar code-coverage:upload --format=php-clover test/build/coverage.xml

build.package: build.user build.version build.changelog build.assets build.tag

build.user:
	git config --global user.email "builds@travis-ci.com"
	git config --global user.name "Travis CI"

build.version:
	replace '{{ version_self }}' $(GIT_TAG) -- version.ini 
	git commit -m "Set build VERSION number $(GIT_TAG)" version.ini

build.changelog:
	git log --all --format='%h%x09%an%x09%ad%x09%s' > changelog
	git commit -m "Created changelog" changelog

build.assets:
	php app/console assetic:dump
	git add web/css/*
	git add web/js/*
	git commit -m "Web assets added" web/

build.tag:
	git tag $(GIT_TAG) -a -m "Generated tag from TravisCI build $(TRAVIS_BUILD_NUMBER)"
	@git push --quiet https://$(GITHUBKEY)@github.com/TransformCore/CSR-Fast-Stream-frontend $(GIT_TAG) > /dev/null 2>&1

# DEV -------------------------------------------------------------------------------------

dev.run: dev.branch composer.install dev.server

dev.update: dev.branch composer.update dev.server

dev.branch:
	git fetch --tags
	git checkout ${branch}


dev.server:
	php app/console server:run -vvv

# LOGS ------------------------------------------------------------------------------------

logs:
	cat app/logs/*.log
