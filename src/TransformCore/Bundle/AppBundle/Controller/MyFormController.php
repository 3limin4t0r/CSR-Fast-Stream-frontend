<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class DefaultController extends Controller
{

    public function createVehicleAction() {
        $formData = new Vehicle(); // Your form data class. Has to be an object, won't work properly with an array.

        $flow = $this->get('myCompany.form.flow.createVehicle'); // must match the flow's service id
        $flow->bind($formData);

        // form of the current step
        $form = $flow->createForm();
        if ($flow->isValid($form)) {
            $flow->saveCurrentStepData($form);

            if ($flow->nextStep()) {
                // form for the next step
                $form = $flow->createForm();
            } else {
                // flow finished
                $em = $this->getDoctrine()->getManager();
                $em->persist($formData);
                $em->flush();

                $flow->reset(); // remove step data from the session

                return $this->redirect($this->generateUrl('home')); // redirect when done
            }
        }

        return $this->render('MyCompanyMyBundle:Vehicle:createVehicle.html.twig', array(
            'form' => $form->createView(),
            'flow' => $flow,
        ));
    }