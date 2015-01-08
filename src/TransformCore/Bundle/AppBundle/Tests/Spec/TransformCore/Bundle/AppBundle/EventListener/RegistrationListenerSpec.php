<?php

namespace Spec\TransformCore\Bundle\AppBundle\EventListener;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use FOS\UserBundle\Event\UserEvent;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\User;

class RegistrationListenerSpec extends ObjectBehavior
{
    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\EventListener\RegistrationListener');
    }

    function its_on_registration_init(UserEvent $userEvent, User $user)
    {
        $user
            ->setUsername(Argument::type('string'))
            ->shouldBeCalled();

        $userEvent
            ->getUser()
            ->shouldBeCalled()
            ->willReturn($user);

        $this->onRegistrationInit($userEvent);
    }
}
