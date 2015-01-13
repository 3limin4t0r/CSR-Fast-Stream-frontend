<?php

namespace Spec\TransformCore\Bundle\AppBundle\DependencyInjection;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class TransformCoreAppExtensionSpec extends ObjectBehavior
{
    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\DependencyInjection\TransformCoreAppExtension');
    }

    /**
     * @TODO: Improve Spec
     */
    function it_should_load(ContainerBuilder $container)
    {
        $this->load(array(), $container);
    }
}
