<?php
namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;

class UserFlow extends FormFlow
{

    protected $allowDynamicStepNavigation = true;

    public function getName()
    {
        return 'user';
    }

    protected function loadStepsConfig()
    {
        return array(
            array(
                'label' => 'User',
                'type' => new User(),
            ),
            array(
                'label' => 'Detail',
                'type' => new Detail(),
            ),
            array(
                'label' => 'confirmation',
            ),
        );
    }
}
