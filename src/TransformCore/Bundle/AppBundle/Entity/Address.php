<?php
namespace TransformCore\Bundle\AppBundle\Entity;

/**
 * Class Detail
 * @package TransformCore\Bundle\AppBundle\Entity
 */
class Address
{
    const MAX_NAME_LENGTH = 30;


    /**
     * @var int
     */
    private $id;

    /**
     * @var string
     */
    private $firstLine;

    /**
     * @var string
     */
    private $secondLine;


    /**
     * @var string
     */
    private $postCode;


    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param string $id
     * @return User
     */
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * @return string
     */
    public function getFirstLine()
    {
        return $this->firstLine;
    }

    /**
     * @param string $firstName
     * @return Detail
     */
    public function setFirstLine($firstLine)
    {
        $this->firstLine = $firstLine;
        return $this;
    }

    /**
     * @return string
     */
    public function getSecondLine()
    {
        return $this->secondLine;
    }

    /**
     * @param string $secondLine
     * @return Detail
     */
    public function setSecondLine($secondLine)
    {
        $this->secondLine = $secondLind;
        return $this;
    }

    /**
     * @return string
     */
    public function getPostCode()
    {
        return $this->postCode;
    }

    /**
     * @param string $dob
     * @return User
     */
    public function setPostCode($postCode)
    {
        $this->postCode = $postCode;
        return $this;
    }

}
