<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;


class MyFormTerms extends AbstractType
{
 

    public function getName()
    {
        return 'MyFormTerms';
    }


    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('termsAccepted', 'text', array(
                'label' => 'Terms Accepted',
                'max_length' => PseudoUser::MAX_NAME_LENGTH,
                'required' => true
        ));     
    }
}
