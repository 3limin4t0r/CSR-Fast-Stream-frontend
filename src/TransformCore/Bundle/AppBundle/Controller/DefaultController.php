<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class DefaultController extends Controller
{

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function indexAction()
    {
        return $this->render('TransformCoreAppBundle:Default:index.html.twig');
    }

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function changelogAction()
    {
        return $this->render(
            'TransformCoreAppBundle:Default:changelog.html.twig',
            array(
                'changelog' => file('../changelog')
            )
        );
    }

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function guaranteedInterviewSchemeAction()
    {
        return $this->render('TransformCoreAppBundle:Default:guaranteed_interview_scheme.html.twig');
    }

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function termsAndConditionsAction()
    {
        return $this->render('TransformCoreAppBundle:Default:terms_and_conditions.html.twig');
    }
}
