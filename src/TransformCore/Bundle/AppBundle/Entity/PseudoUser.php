<?php
/**
 */
namespace TransformCore\Bundle\AppBundle\Entity;

use Symfony\Component\Validator\Constraints as Assert;

/**
 * THIS IS NOT A DATABASE TABLE.
 *
 * It is only used for some data-holding during the form processing
 */
class PassportHolder
{
    const ME    = 'me';
    const CHILD = 'child';
    const OTHER = 'other';

    /**
     * @Assert\Choice(choices = {"me", "child", "other"}, message="holder.choice")
     * @Assert\NotBlank(message="holder.choice")
     */
    public $holder;

     /**
     * Set holder
     *
     * @param  integer        $holder
     * @return PassportHolder
     */
    public function setHolder($holder)
    {
        $this->holder = $holder;

        return $this;
    }

    /**
     * Get holder
     *
     * @return integer
     */
    public function getHolder()
    {
        return $this->holder;
    }

    public function isHolderOther()
    {
        return ($this->getHolder() == self::OTHER);
    }

    public function isHolderMine()
    {
        return ($this->getHolder() == self::ME);
    }

    public function isHolderChild()
    {
        return ($this->getHolder() == self::CHILD);
    }
}
