<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\User;


class MyFormAccount extends AbstractType
{
 

    public function getName()
    {
        return 'MyFormAccount';
    }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add(
            'email', 'email', array(
                'label' => 'email address',
                'max_length' => User::MAX_NAME_LENGTH,
                'required' => true
            )
        )->add(
            'password', 'password', array(
                'label' => 'password',
                'max_length' => User::MAX_NAME_LENGTH,
                'required' => true
            )
        );
        // ->add(
        //     'password2', 'password', array(
        //         'label' => 'email address',
        //         'max_length' => User::MAX_NAME_LENGTH,
        //         'required' => true
        //     )
            
    }
}
