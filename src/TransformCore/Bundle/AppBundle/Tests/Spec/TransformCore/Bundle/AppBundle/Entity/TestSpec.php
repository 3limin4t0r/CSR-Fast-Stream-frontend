<?php

namespace Spec\TransformCore\Bundle\AppBundle\Entity;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;

class TestSpec extends ObjectBehavior
{
    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\Entity\Test');
    }


    function it_should_set_then_get_id()
    {
        $id = 123;

        $this->setId($id);
        $this->getId()->shouldReturn($id);
    }

    function it_should_set_then_get_name()
    {
        $name = 'testname';

        $this->setName($name);
        $this->getName()->shouldReturn($name);
    }
}
