<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;


class MyFormReasons extends AbstractType
{
 

    public function getName()
    {
        return 'myform_reasons';
    }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('reasonsForInterest', 'text', array(
                'label' => 'Reasons for Interest',
                'max_length' => PseudoUser::MAX_NAME_LENGTH,
                'required' => true
        ));
    }
}
