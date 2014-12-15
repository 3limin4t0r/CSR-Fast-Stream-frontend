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


    private function allTheRoutes($targetStep, $base, $locale)
    {
        $found = null;
        $router = $this->container->get('router');
        $collection = $router->getRouteCollection();
        $allRoutes = $collection->all();
        $prefix = $locale.'__RG__';
        foreach ($allRoutes as $index => $route) {
            $route_path = 'transform_core_app_'.$base.'_step'.$targetStep;
            $pattern = $prefix.$route_path;
            
            if (strpos($index, $pattern) === 0) {
                $found = $route_path;
                break;
            }
        }
        if ($route === null) {
            die('No route found!');
        }
        return $found;
    }



    public function indexAction()
    {
        $base = 'myform';
        $locale = 'en';

        $formData = new PseudoUser();
        $flow = $this->get('myForm.form.flow.myForm'); 
        $flow->bind($formData);


        // form of the current step
        $form = $flow->createForm();
        $totalSteps = $flow->getStepCount();  // custom call


        if ($flow->isValid($form)) {

            $flow->saveCurrentStepData($form);

            // conditionally do redirect to GET 
            if ($flow->redirectAfterSubmit($form)) {
                $request = $this->getRequest();
                
                $params = $this->get('craue_formflow_util')->addRouteParameters(array_merge($request->query->all(),
                    $request->attributes->get('_route_params')), $flow);

               $params['step']++;  // increment step manually :/


               if ($params['step'] < $totalSteps) {
                    $new_target_route = $this->allTheRoutes($params['step'], $base, $locale);                    
                    //return $this->redirect($this->generateUrl($request->attributes->get('_route'), $params));

                    // attempted to remove 'instance' param
                    // to create cleaner URLs but this breaks 
                    // position in multistep form and current stored data in session appears lost
                    //unset($params['instance']); 

                    return $this->redirect($this->generateUrl($new_target_route, $params));
                }
            }


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

