<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;



class MyFormEmail extends AbstractType
{
 
    public function getName()
    {
        return 'MyFormEmail';
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('email', 'email', array(
            'label' => 'Email',
            'max_length' => PseudoUser::MAX_NAME_LENGTH,
            'required' => true
        ));   
    }
}
