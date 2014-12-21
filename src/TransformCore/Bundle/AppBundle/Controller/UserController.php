<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use TransformCore\Bundle\AppBundle\Entity\User;

/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class UserController extends Controller
{

    public function indexAction() {
        $formData = new User();

        /** @var  \Craue\FormFlowBundle\Form\FormFlow $flow */
        $flow = $this->get('transform_core_app.form.flow.user');

        var_dump($flow->getSteps(), $flow->getFormStepKey()); exit;

        $flow->bind($formData);



        // form of the current step
        $form = $flow->createForm();
        if ($flow->isValid($form)) {
            $flow->saveCurrentStepData($form);

            if ($flow->nextStep()) {
                // form for the next step
                $form = $flow->createForm();
            } else {
//                // flow finished
//                $em = $this->getDoctrine()->getManager();
//                $em->persist($formData);
//                $em->flush();

                $flow->reset(); // remove step data from the session

                return $this->redirect($this->generateUrl('home')); // redirect when done
            }
        }

        return $this->render('TransformCoreAppBundle:User:user.html.twig', array(
            'form' => $form->createView(),
            'flow' => $flow,
        ));
    }
}
