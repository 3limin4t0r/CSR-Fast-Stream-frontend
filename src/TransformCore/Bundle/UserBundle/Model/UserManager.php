<?php

namespace TransformCore\Bundle\UserBundle\Model;

use FOS\UserBundle\Model\UserInterface;
use FOS\UserBundle\Model\UserManagerInterface;
use FOS\UserBundle\Util\CanonicalizerInterface;
use Symfony\Component\Security\Core\Encoder\EncoderFactoryInterface;
use TransformCore\Bundle\UserBundle\Entity\User;

/**
 * Class UserManager
 *
 * @TODO inject http client
 *
 * @package TransformCore\Bundle\UserBundle\Model
 */
class UserManager implements UserManagerInterface
{

    /**
     * Constructor.
     *
     * @param EncoderFactoryInterface $encoderFactory
     * @param CanonicalizerInterface $usernameCanonicalizer
     * @param CanonicalizerInterface $emailCanonicalizer
     */
    public function __construct(
        EncoderFactoryInterface $encoderFactory,
        CanonicalizerInterface $usernameCanonicalizer,
        CanonicalizerInterface $emailCanonicalizer
    )
    {
        $this->encoderFactory = $encoderFactory;
        $this->usernameCanonicalizer = $usernameCanonicalizer;
        $this->emailCanonicalizer = $emailCanonicalizer;
    }

    /**
     * Creates an empty user instance.
     *
     * @return UserInterface
     */
    public function createUser()
    {
        return new User();
    }

    /**
     * Deletes a user.
     *
     * @param UserInterface $user
     *
     * @return void
     */
    public function deleteUser(UserInterface $user)
    {
        // TODO: Implement deleteUser() method.
    }

    /**
     * Finds one user by the given criteria.
     *
     * @param array $criteria
     *
     * @return UserInterface
     */
    public function findUserBy(array $criteria)
    {
        // TODO: Implement findUserBy() method.
    }

    /**
     * Find a user by its username.
     *
     * @param string $username
     *
     * @return UserInterface or null if user does not exist
     */
    public function findUserByUsername($username)
    {
        try {
            $client = new \GuzzleHttp\Client();
            $res = $client->post('http://localhost:8001/authenticates',
                array(
                    'body' => array(
                        'username' => $username
                    )
                )
            );
        } catch (\Exception $e) {
            var_dump($e->getMessage());
            exit;
        }

        return (new User())
            ->setId($res->json()['data']['User']['id'])
            ->setUsername($res->json()['data']['User']['username'])
            ->setPlainPassword($res->json()['data']['User']['password'])
            ->setLocked($res->json()['data']['User']['locked'])
            ->setEnabled($res->json()['data']['User']['enabled']);
    }

    /**
     * Finds a user by its email.
     *
     * @param string $email
     *
     * @return UserInterface or null if user does not exist
     */
    public function findUserByEmail($email)
    {
        // TODO: Implement findUserByEmail() method.
    }

    /**
     * Finds a user by its username or email.
     *
     * @param string $usernameOrEmail
     *
     * @return UserInterface or null if user does not exist
     */
    public function findUserByUsernameOrEmail($usernameOrEmail)
    {
        // TODO: Implement findUserByUsernameOrEmail() method.
    }

    /**
     * Finds a user by its confirmationToken.
     *
     * @param string $token
     *
     * @return UserInterface or null if user does not exist
     */
    public function findUserByConfirmationToken($token)
    {
        // TODO: Implement findUserByConfirmationToken() method.
    }

    /**
     * Returns a collection with all user instances.
     *
     * @return \Traversable
     */
    public function findUsers()
    {
        // TODO: Implement findUsers() method.
    }

    /**
     * Returns the user's fully qualified class name.
     *
     * @return string
     */
    public function getClass()
    {
        // TODO: Implement getClass() method.
    }

    /**
     * Reloads a user.
     *
     * @param UserInterface $user
     *
     * @return void
     */
    public function reloadUser(UserInterface $user)
    {
        // TODO: Implement reloadUser() method.
    }

    /**
     * Updates a user.
     *
     * @param UserInterface $user
     *
     * @return void
     */
    public function updateUser(UserInterface $user)
    {
        // TODO: Implement updateUser() method.
        // @TODO: Encode password OR in B/E?
        try {
            $client = new \GuzzleHttp\Client();
            $res = $client->post('http://localhost:8001/registers',
                array(
                    'body' => array(
                        'username' => $user->getUsername(),
                        'password' => $user->getPlainPassword(),
                    )
                )
            );
        } catch (\Exception $e) {
            var_dump($e->getMessage());
            exit;
        }
    }

    /**
     * Updates the canonical username and email fields for a user.
     *
     * @param UserInterface $user
     *
     * @return void
     */
    public function updateCanonicalFields(UserInterface $user)
    {
        // TODO: Implement updateCanonicalFields() method.
    }

    /**
     * Updates a user password if a plain password is set.
     *
     * @param UserInterface $user
     *
     * @return void
     */
    public function updatePassword(UserInterface $user)
    {
        // TODO: Implement updatePassword() method.
    }

}
