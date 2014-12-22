<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\Detail;


class MyFormDetail extends AbstractType
{
    public function getName()
    {
        return 'MyFormDetail';
    }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('firstName', 'text', array(
            'label' => 'First Name',
            'max_length' => Detail::MAX_NAME_LENGTH,
            'required' => true
        ))
        ->add('lastName', 'text', array(
            'label' => 'Last Name',
            'max_length' => Detail::MAX_NAME_LENGTH,
            'required' => true
        ))
        ->add('dob', 'text', array(
            'label' => 'Date of Birth',
            'max_length' => Detail::MAX_NAME_LENGTH,
            'required' => true
        ));   
    }
}
