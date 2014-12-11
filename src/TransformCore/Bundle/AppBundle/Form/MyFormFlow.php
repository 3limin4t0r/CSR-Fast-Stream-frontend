<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;

class MyFormFlow extends FormFlow {

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
