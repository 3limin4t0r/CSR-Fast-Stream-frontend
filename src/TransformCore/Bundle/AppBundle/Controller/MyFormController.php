<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use TransformCore\Bundle\AppBundle\Entity\PassportHolder;

/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class MyFormController extends Controller
{

    public function indexAction() {

        $formData = new PassportHolder();

        $flow = $this->get('myForm.form.flow.myForm'); 


        $flow->bind($formData);

        //$flow->setGenericFormOptions(array('action' => 'www.google.com'));
        //print_r($flow->getGenericFormOptions());
        //exit();


        // form of the current step
        $form = $flow->createForm();
        if (1 || $flow->isValid($form)) {


            //$flow->saveCurrentStepData($form);

            if ($flow->nextStep()) {
                // form for the next step
                $form = $flow->createForm();
            } else {
                // flow finished

                // echo header("Content-type: application/json");
                // echo json_encode($formData);

                // $em = $this->getDoctrine()->getManager();
                // $em->persist($formData);
                // $em->flush();

                $flow->reset(); // remove step data from the session

                return $this->redirect($this->generateUrl('home')); // redirect when done
            }
        }

        return $this->render('TransformCoreAppBundle:MyForm:myForm.html.twig', array(
            'form' => $form->createView(),
            'flow' => $flow,
        ));
    }

}

