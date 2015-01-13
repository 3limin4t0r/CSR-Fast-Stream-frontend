<?php

namespace Spec\TransformCore\Bundle\AppBundle;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;

class TransformCoreAppBundleSpec extends ObjectBehavior
{
    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\TransformCoreAppBundle');
    }
}
