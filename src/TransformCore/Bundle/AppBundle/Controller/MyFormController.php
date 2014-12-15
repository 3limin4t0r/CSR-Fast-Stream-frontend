<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use TransformCore\Bundle\AppBundle\Entity\PseudoUser;


/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class MyFormController extends Controller
{

    public function indexAction()
    {
        $formData = new PseudoUser();
        $flow = $this->get('myForm.form.flow.myForm'); 
        $flow->bind($formData);


        // form of the current step
        $form = $flow->createForm();
        if ($flow->isValid($form)) {

            $flow->saveCurrentStepData($form); 

            if ($flow->nextStep()) {
                // form for the next step
                $form = $flow->createForm();
            } else {

                print_r($formData);            
                $flow->reset(); // remove step data from the session

                echo 'Form finished.. w00t!';
                exit();

                return $this->redirect($this->generateUrl('home')); // redirect when done
            }
        }

        return $this->render('TransformCoreAppBundle:MyForm:myForm.html.twig', array(
            'form' => $form->createView(),
            'flow' => $flow,
        ));
    }

}

