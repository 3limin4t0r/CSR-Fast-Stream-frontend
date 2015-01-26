<?php
namespace TransformCore\Bundle\AppBundle\Service;

/**
 * Class RandomUsernameGenerator
 * @package TransformCore\Bundle\AppBundle\Service
 */
class RandomUsernameGenerator
{

    /**
     * @return string
     */
    public function getUsername()
    {
        return uniqid('', true);
    }
}
