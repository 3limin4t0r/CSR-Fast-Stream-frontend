<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;


class MyFormFlow extends FormFlow {

    const FLOW_USER_ACCOUNT       = 1;
    const FLOW_USER_DETAIL        = 2;
    const FLOW_USER_ADDRESS        = 3;

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
            ),
            array(
                'label' => 'detail',
                'type' => new MyFormDetail()
            ),
            array(
                'label' => 'address',
                'type' => new MyFormAddress(),
            )
        );       
    }
}
