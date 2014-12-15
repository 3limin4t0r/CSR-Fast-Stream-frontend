<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;


class MyFormLastName extends AbstractType
{
 

    public function getName()
    {
        return 'MyFormLastName';
    }



    public function buildForm(FormBuilderInterface $builder, array $options)
    {

        $builder->add('lastName', 'text', array(
            'label' => 'Last Name',
            'max_length' => PseudoUser::MAX_NAME_LENGTH,
            'required' => true
        ));   

    }
}
