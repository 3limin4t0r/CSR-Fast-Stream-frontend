<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;


class MyFormFlow extends FormFlow {

    const FLOW_USER_FIRSTNAME       = 1;
    const FLOW_USER_LASTNAME        = 2;
    const FLOW_USER_EMAIL           = 3;
    const FLOW_USER_TERMS           = 4;
    const FLOW_USER_REASONS         = 5;
    const FLOW_USER_CONFIRMATION    = 6;


    public function getName()
    {
        return 'MyFormFlow';
    }


    protected function loadStepsConfig()
    {
        return array(
            array(
                'label' => 'firstName',
                'type' => new MyFormFirstName(),
            ),
            array(
                'label' => 'lastName',
                'type' => new MyFormLastName()
                // 'skip' => function($estimatedCurrentStepNumber, FormFlowInterface $flow) {
                //     return $estimatedCurrentStepNumber > 1 && !$flow->getFormData()->canHaveEngine();
                // },
            ),
            array(
                'label' => 'email',
                'type' => new MyFormEmail(),
            ),
            array(
                'label' => 'terms',
                'type' => new MyFormTerms(),
            ),
            array(
                'label' => 'reasons',
                'type' => new MyFormReasons(),
            ),
            array(
                'label' => 'confirmation',
                'type' => new MyFormConfirmation()
            ),
        );
    }
}
