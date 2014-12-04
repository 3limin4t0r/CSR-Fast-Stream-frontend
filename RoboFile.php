<?php

/**
 * Class Robo
 * @package Test
 */
class RoboFile extends \Robo\Tasks
{

    public function parallelRun()
    {
        $this->taskParallelExec()
            ->process('bin/phpspec run  --config test/phpspec.yml')
            ->process('bin/behat --config test/behat.yml --suite=transformcore_app')
            ->process('bin/phpunit --configuration app')
            ->printed()
            ->run();
    }
}
