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
class User extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('email', 'text', array(
            'label' => 'Email address',
        ));
    }

    public function setDefaultOptions(OptionsResolverInterface $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'TransformCore\Bundle\AppBundle\Entity\User',
            'intention' => 'User',
//            'translation_domain' => 'AcmeDemoBundle'
        ));
    }

    public function getName()
    {
        return 'user';
    }
}