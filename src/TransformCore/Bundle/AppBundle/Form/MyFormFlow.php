<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Craue\FormFlowBundle\Form\FormFlowEvents;
use Craue\FormFlowBundle\Event\PreBindEvent;
use Symfony\Component\Form\FormTypeInterface;
use TransformCore\Bundle\AppBundle\Entity\Detail;
use TransformCore\Bundle\AppBundle\Entity\Address;


class MyFormFlow extends FormFlow
{
    const FLOW_USER_ACCOUNT       = 1;
    const FLOW_USER_DETAIL        = 2;
    const FLOW_USER_ADDRESS       = 3;

    protected $allowRedirectAfterSubmit = true;
    
    public function getName()
    {
        return 'MyFormFlow';
    }

   
    protected function loadStepsConfig()
    {
        return array(
            array(
                'label' => 'account',
                'type' => new MyFormAccount(),
                'model' => 'TransformCore\Bundle\AppBundle\Entity\User' // default
            ),
            array(
                'label' => 'detail',
                'type' => new MyFormDetail(),
                'model' => 'TransformCore\Bundle\AppBundle\Entity\Detail'
            ),
            array(
                'label' => 'address',
                'type' => new MyFormAddress(),
                'model' => 'TransformCore\Bundle\AppBundle\Entity\Address'
            )
        );       
    }


    protected function findEntity($type)
    {
        $steps = $this->loadStepsConfig();
        foreach($steps as $step) {

            if (get_class($step['type']) == get_class($type) && isset($step['model'])) {
                $model = $step['model'];               
                $this->formData = new $model();
                break;
            }
        }
    }


    /**
     * Bundle hacking: allow multi-entities.  Won't work until
     * FormFlow (parent) class has formData property set to 'protected'
     * and also the addition of the 'model' step config option
     * on line 56 of the Step class
     * Unresolved: session data for individual steps dissappearing from view
     * Not a concern if data is always synced/validatec with API?
     * Perhaps formData is getting overriden too late!
     * OR there is no way of overriding it and maintaining the session state
     * releating to that step
     *
     * Creates the form for the given step number.
     * @param integer $stepNumber
     * @param array $options
     * @return FormInterface
     */
    protected function createFormForStep($stepNumber, array $options = array()) {
        $formType = $this->getStep($stepNumber)->getType();
        $options = $this->getFormOptions($stepNumber, $options);

        // following call is the only addition in this method
        $this->findEntity($formType);

        return $this->formFactory->create($formType !== null ? $formType : 'form', $this->formData, $options);
    }


}
