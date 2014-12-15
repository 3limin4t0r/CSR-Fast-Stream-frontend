<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;


class MyFormConfirmation extends AbstractType
{
    
    public function getName()
    {
        return 'MyFormConfirmation';
    }

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        // no building...
    }


}
