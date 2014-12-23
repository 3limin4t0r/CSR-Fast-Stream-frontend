<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;
use TransformCore\Bundle\AppBundle\Entity\Address;



class MyFormAddress extends AbstractType
{
 
    public function getName()
    {
        return 'MyFormAddress';
    }


    // public function setDefaultOptions(OptionsResolverInterface $resolver)
    // {
    //     $resolver->setDefaults(array(
    //         'data_class' => 'TransformCore\Bundle\AppBundle\Entity\Address'
    //     ));
    //     return $resolver;
    // }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('firstLine', 'text', array(
            'label' => 'First line of address',
            'max_length' => Address::MAX_NAME_LENGTH,
            'required' => true
        ))->add('secondLine', 'text', array(
            'label' => 'Second line of address',
            'max_length' => Address::MAX_NAME_LENGTH,
            'required' => true
        ))->add('firstLine', 'text', array(
            'label' => 'Post Code',
            'max_length' => Address::MAX_NAME_LENGTH,
            'required' => true
        ));
    }
}
