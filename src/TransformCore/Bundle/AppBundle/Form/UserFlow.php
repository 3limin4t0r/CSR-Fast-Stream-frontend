<?php
namespace TransformCore\Bundle\AppBundle\Form;

use Craue\FormFlowBundle\Form\FormFlow;
use Craue\FormFlowBundle\Form\FormFlowInterface;
use Symfony\Component\Form\FormTypeInterface;

class UserFlow extends FormFlow
{

    public function getName()
    {
        return 'user';
    }

    protected function loadStepsConfig()
    {
        return array(
            array(
                'label' => 'Register',
                'type' => new User(),
            ),
            array(
                'label' => 'Details',
                'type' => new Detail(),
            ),
            array(
                'label' => 'confirmation',
            ),
        );
    }
}
