<?php

/**
 * Class Robo
 * @package Test
 */
class RoboFile extends \Robo\Tasks
{

    public function parallelRun()
    {
        // @TODO: Use make commands?
        // @TODO: Bug failing process -> successful build
        // ... Ref: https://github.com/TransformCore/CSR-Fast-Stream-frontend/issues/21
        $this->taskParallelExec()
            ->process('bin/phpspec run  --config test/phpspec.yml --format=pretty')
            ->process('bin/behat --config test/behat.yml --suite=transformcore_app --format=pretty')
            ->printed()
            ->run();
    }
}
