<?php
namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;

/**
 * THIS IS A DUPLICATE FROM THE BACKEND
 * This would go into the Domain Model repo?
 *
 * Class User
 * @package TransformCore\Bundle\AppBundle\Form
 */
class Detail extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('firstname', 'text', array(
            'label' => 'Firstname',
        ));

        $builder->add('lastname', 'text', array(
            'label' => 'Lastname',
        ));
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'TransformCore\Bundle\AppBundle\Entity\Detail',
            'intention' => 'Detail',
//            'translation_domain' => 'AcmeDemoBundle'
        ));
    }

    public function getName()
    {
        return 'detail';
    }
}