<?php

namespace TransformCore\Bundle\UserBundle\Model;

use FOS\UserBundle\Security\UserProvider as BaseUserProvider;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\Exception\UsernameNotFoundException;
use Symfony\Component\Security\Core\User\UserInterface;
use TransformCore\Bundle\UserBundle\Entity\User;

class UserProvider extends BaseUserProvider
{
    /**
     * {@inheritDoc}
     */
    public function refreshUser(UserInterface $user)
    {
        if (!$user instanceof User && !$this->supportsClass(get_class($user))) {
            throw new UnsupportedUserException(sprintf('Expected an instance of FOS\UserBundle\Model\User, but got "%s".', get_class($user)));
        }

        if (null === $reloadedUser = $this->userManager->findUserBy(array('id' => $user->getId()))) {
            throw new UsernameNotFoundException(sprintf('User with ID "%d" could not be reloaded.', $user->getId()));
        }

        return $reloadedUser;
    }

    protected function findUser($username)
    {
        return $this->userManager->findUserByUsername($username);
    }
}
