<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;



class MyForm extends AbstractType {
 

    public function buildForm(FormBuilderInterface $builder, array $options)
    {

        switch ($options['flow_step']) {
            case MyFormFlow::FLOW_USER_FIRSTNAME:

                // $validValues = array(2, 4);
                // $builder->add('numberOfWheels', 'choice', array(
                //     'choices' => array_combine($validValues, $validValues),
                //     'empty_value' => '',
                // ));

                break;
            case MyFormFlow::FLOW_USER_LASTNAME:

                // $builder->add('engine', 'form_type_vehicleEngine', array(
                //     'empty_value' => '',
                // ));

                break;
            case MyFormFlow::FLOW_USER_EMAIL:

                break;

            case MyFormFlow::FLOW_USER_TERMS:

                break;

            case MyFormFlow::FLOW_USER_REASONS:

                break;

            case MyFormFlow::FLOW_USER_CONFIRMATION:

                break;

            default:
                break;
        }
    }


    public function getName()
    {
        return 'foocreateVehicle';
    }

}
