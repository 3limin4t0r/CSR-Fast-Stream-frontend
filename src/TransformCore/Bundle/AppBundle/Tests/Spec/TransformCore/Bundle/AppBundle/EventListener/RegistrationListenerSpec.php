<?php

namespace Spec\TransformCore\Bundle\AppBundle\EventListener;

use FOS\UserBundle\Event\FormEvent;
use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use FOS\UserBundle\Event\UserEvent;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\User;

class RegistrationListenerSpec extends ObjectBehavior
{

    function let(UrlGeneratorInterface $router)
    {
        $this->beConstructedWith($router, true);
    }
    
    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\EventListener\RegistrationListener');
    }

    function its_on_registration_init(UrlGeneratorInterface $router, UserEvent $userEvent, User $user)
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

    function its_on_registration_success(UrlGeneratorInterface $router, FormEvent $event)
    {
        $router
            ->generate('transform_core_app_account')
            ->shouldBeCalled()
            ->willReturn('/en/account');

        $this->beConstructedWith($router, true);

        $event
            ->setResponse(Argument::type('Symfony\Component\HttpFoundation\RedirectResponse'))
            ->shouldBeCalled();

        $this->onRegistrationSuccess($event);
    }
}
