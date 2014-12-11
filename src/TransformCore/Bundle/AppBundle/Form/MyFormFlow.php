<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;

class MyFormFlow extends FormFlow {

    const FLOW_USER_FIRSTNAME   = 1;
    const FLOW_USER_LASTNAME    = 2;
    const FLOW_USER_EMAIL       = 3;
    const FLOW_USER_TERMS       = 4;
    const FLOW_USER_REASONS     = 5;

    /**
     * @var FormTypeInterface
     */
    protected $formType;

    public function setFormType(FormTypeInterface $formType) {
        $this->formType = $formType;
    }

    public function getName() {
        return 'createVehicle';
    }

    protected function loadStepsConfig() {
        return array(
            array(
                'label' => 'wheels',
                'type' => $this->formType,
            ),
            array(
                'label' => 'engine',
                'type' => $this->formType
                // 'skip' => function($estimatedCurrentStepNumber, FormFlowInterface $flow) {
                //     return $estimatedCurrentStepNumber > 1 && !$flow->getFormData()->canHaveEngine();
                // },
            ),
            array(
                'label' => 'confirmation',
            ),
        );
    }
}
