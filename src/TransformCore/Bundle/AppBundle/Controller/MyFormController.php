<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use TransformCore\Bundle\AppBundle\Form\MyFormFlow;
use Craue\FormFlowBundle\Form\FormFlow as CraueFlow;
use TransformCore\Bundle\AppBundle\Entity\User;
use TransformCore\Bundle\AppBundle\Entity\Detail;


/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class MyFormController extends Controller
{


    private function findRoute($targetStep, $base, $locale)
    {
        $found = null;
        $router = $this->container->get('router');
        $collection = $router->getRouteCollection();
        $allRoutes = $collection->all();
        $prefix = $locale.'__RG__';
        foreach ($allRoutes as $index => $route) {

            $route_path = 'transform_core_app_'.$base;
            if ($targetStep > 1) {
                $route_path .='_step'.$targetStep;
            }
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


    private function getParams($flow)
    {        
        $request = $this->getRequest();
        return $this->get('craue_formflow_util')->addRouteParameters(
            array_merge(
                $request->query->all(),
                $request->attributes->get('_route_params')
            ),
        $flow);
    }


    private function conditionalRedirect($base, $locale, $flow, $transition=null)
    {        
        $totalSteps = $flow->getStepCount();
        $params = $this->getParams($flow);

        switch ($transition) {
            case CraueFlow::TRANSITION_BACK:
                // no need to decrement
            break;
            case CraueFlow::TRANSITION_RESET:
                $params['step'] = 1;
            break;
            default;
                $params['step']++;  // increment step manually (no need if going "back")
            break;
        }

        if ($params['step'] <= $totalSteps) {

            $new_target_route = $this->findRoute($params['step'], $base, $locale);
            // attempted to remove 'instance' param
            // to create cleaner URLs but this breaks 
            // position in multistep form and current stored data in session appears lost
            //unset($params['instance']); 

            return $this->generateUrl($new_target_route, $params);
            
        } else {
            return false;
        }
    }


    private function redirectsToggle($base, $locale)
    {
        $session = $this->get('session');
        $toggler = $session->get('toggler');
        if ($toggler == null) {
            $toggler = false;        
        }
        if (isset($_GET['toggler'])) {
            $toggler = !$toggler;
            $session->set('toggler', $toggler);
            return $this->generateUrl($this->findRoute(0, $base, $locale));
        }
        return $toggler;
    }

    private function stepByRedirects()
    {
        return $this->getRequest()->get('step');        
    }


    public function indexAction()
    {
        $base = 'myform';
        $locale = 'en';

        $toggler = $this->redirectsToggle($base, $locale);  
        if (!is_bool($toggler)) {
            return $this->redirect($toggler);
        }

        $flow = $this->get('myForm.form.flow.myForm');
        $transition = $flow->getRequestedTransition();

        switch ($this->stepByRedirects()) {

            case MyFormFlow::FLOW_USER_DETAIL:
                echo 'detail';
                $formData = new Detail();
                break;
            case MyFormFlow::FLOW_USER_ADDRESS:
                echo 'address';
                $formData = new User();
                break;
            default:
                // Implies first step: MyFormFlow::FLOW_USER_ACCOUNT
                echo 'user';
                $formData = new User();
                break;
        }

        //$formData = new User();
        $flow->bind($formData);

        // form of the current step
        $form = $flow->createForm();
       
        if ($transition != '' && $toggler) {
            return $this->redirect($this->conditionalRedirect($base, $locale, $flow, $transition));
        }

        if ($flow->isValid($form)) {
            $flow->saveCurrentStepData($form);
            if ($flow->redirectAfterSubmit($form)) {
                if ($toggler && ($loc = $this->conditionalRedirect($base, $locale, $flow)) !== false) {
                    return $this->redirect($loc);
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
            'redirects' => $toggler? 'off': 'on'
        ));
    }

}

