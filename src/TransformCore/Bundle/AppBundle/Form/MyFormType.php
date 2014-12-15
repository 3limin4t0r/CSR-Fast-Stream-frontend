<?php
namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolverInterface;


class MyFormType extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options)
    {
 
        /**
        * use builder->add syntax to construct form with arguments:
        * <model field>, <alias to form sub-type/service>, <something else>
        *
        */

        switch ($options['flow_step']) {

            case MyFormFlow::FLOW_USER_FIRSTNAME:
                $builder->add('firstName', 'myform_firstName', array());
                break;

            case MyFormFlow::FLOW_USER_LASTNAME:
                $builder->add('lastName', 'myform_lastName', array());
                break;

            case MyFormFlow::FLOW_USER_EMAIL:
                $builder->add('email', 'myform_email', array());
                break;

            case MyFormFlow::FLOW_USER_TERMS:
                $builder->add('termsAccepted', 'myform_terms', array());
                break;

            case MyFormFlow::FLOW_USER_REASONS:
                $builder->add('reasonsForInterest', 'myform_reasons', array());
                break;

            case MyFormFlow::FLOW_USER_CONFIRMATION:
                $builder->add('confirmation', 'myform_confirmation', array());
                break;
            default:
                break;
        }
    }


    public function getName()
    {
        return 'MyFormType';
    }
}
