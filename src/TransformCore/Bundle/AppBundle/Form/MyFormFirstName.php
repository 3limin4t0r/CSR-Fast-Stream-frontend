<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;


class MyFormFirstName extends AbstractType
{
 

    public function getName()
    {
        return 'MyFormFirstName';
    }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('firstName', 'text', array(
                'label' => 'First Name',
                'max_length' => PseudoUser::MAX_NAME_LENGTH,
                'required' => true
        ));    
    }
}
