<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use TransformCore\Bundle\AppBundle\Entity\User;

class MyFormAccount extends AbstractType
{
 

    public function getName()
    {
        return 'MyFormAccount';
    }


    // public function setDefaultOptions(OptionsResolverInterface $resolver)
    // {
    //     $resolver->setDefaults(array(
    //         'data_class' => 'TransformCore\Bundle\AppBundle\Entity\User',
    //         'translation_domain' => 'forms'
    //     ));
    //     return $resolver;
    // }




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
