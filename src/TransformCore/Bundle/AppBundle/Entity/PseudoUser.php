<?php

namespace TransformCore\Bundle\AppBundle\Entity;


use Symfony\Component\Validator\Constraints as Assert;

/**
 * Pseudo entity (not persisited)
 *
 */
class PseudoUser
{
    const MAX_NAME_LENGTH = 30;


    /**
     * @Assert\Length(
     *      min = 2,
     *      max = 50,
     *      minMessage = "Your first name must be at least {{ limit }} characters long",
     *      maxMessage = "Your first name cannot be longer than {{ limit }} characters long"
     * )
     */
    protected $firstName;


    /**
     * @Assert\Length(
     *      min = 2,
     *      max = 50,
     *      minMessage = "Your last name must be at least {{ limit }} characters long",
     *      maxMessage = "Your last name cannot be longer than {{ limit }} characters long"
     * )
     */
    protected $lastName;

    /**
     * @Assert\Email(
     *     message = "The email '{{ value }}' is not a valid email.",
     *     checkMX = true
     * )
     */
    protected $email;


    /**
     * @Assert\True(message = "Terms accepted can only be set to true")
     */
    protected $termsAccepted;



    /**
     * @Assert\Choice(choices = {"Social media", "TV", "Career adive", "Other"}, message="Please choose valid reason")
     * @Assert\NotBlank(message="Choose valid reason")
     */
    protected $reasonsForInterest;


    // setters/getters

    public function setFirstName($name)
    {
        $this->firstName = $name;
    }

    public function getFirstName()
    {
        return $this->firstName;
    }

    public function setLastName($name)
    {
        $this->lastName = $name;
    }

    public function getLastName()
    {
        return $this->lastName;
    }


    public function setEmail($email)
    {
        $this->email = $email;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setTermsAccepted($termsAccepted)
    {
        $this->termsAccepted = $termsAccepted;
    }

    public function getTermsAccepted()
    {
        return $this->termsAccepted;
    }

    public function setReasonsForInterest($reasons)
    {
        $this->reasonsForInterest = $reasons;
    }

    public function getReasonsForInterest()
    {
        return $this->reasonsForInterest;
    }




}
