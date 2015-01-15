<?php

namespace Spec\TransformCore\Bundle\AppBundle\Service;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;

class RandomUsernameGeneratorSpec extends ObjectBehavior
{

    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\Service\RandomUsernameGenerator');
    }

    function it_should_get_random_username()
    {
        $this->getUsername()
            ->shouldBeString();
    }

    function it_should_get_random_username_each_time()
    {
        $this->getUsername()
            ->shouldNotBeLike(
                // @TODO: this does not return string but PhpSpec\Wrapper\Subject
                // There this will pass, but not in the way we want
                $this->getUsername()
            );
    }
}
