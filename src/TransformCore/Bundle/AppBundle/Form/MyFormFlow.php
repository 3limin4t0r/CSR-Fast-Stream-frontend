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


    /**
     * @var FormTypeInterface
     */
    protected $formType;


    public function setFormType(FormTypeInterface $formType)
    {
        $this->formType = $formType;
    }


    public function getName()
    {
        return 'createVehicle';
    }



    protected function loadStepsConfig()
    {
    
        return array(
            array(
                'label' => 'firstname',
                'type' => $this->formType,
            ),
            array(
                'label' => 'lastname',
                'type' => $this->formType
                // 'skip' => function($estimatedCurrentStepNumber, FormFlowInterface $flow) {
                //     return $estimatedCurrentStepNumber > 1 && !$flow->getFormData()->canHaveEngine();
                // },
            ),
            array(
                'label' => 'email',
                'type' => $this->formType,
            ),
            array(
                'label' => 'terms',
                'type' => $this->formType,
            ),
            array(
                'label' => 'reasons',
                'type' => $this->formType,
            ),
            array(
                'label' => 'confirmation',
            ),
        );
    }
}
