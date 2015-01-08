<?php

namespace TransformCore\Bundle\AppBundle\EventListener;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use FOS\UserBundle\Event\UserEvent;
use FOS\UserBundle\FOSUserEvents;

/**
 * Class UserRegistrationListener
 *
 * The reason for the Listener https://github.com/FriendsOfSymfony/FOSUserBundle/issues/555#issuecomment-59510228
 *
 * @package Acme\UserBundle\EventListener
 */
class RegistrationListener implements EventSubscriberInterface
{

    /**
     * @return array
     */
    public static function getSubscribedEvents()
    {
        return array(
            FOSUserEvents::REGISTRATION_INITIALIZE => 'onRegistrationInit',
        );
    }

    /**
     * take action when registration is initialized
     * set the username to a unique id
     * @param UserEvent $event
     */
    public function onRegistrationInit(UserEvent $event)
    {
        $user = $event->getUser();
        $user->setUsername(uniqid(time(), true));
    }
}
