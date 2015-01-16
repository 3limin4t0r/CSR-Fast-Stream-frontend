<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class AccountController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class AccountController extends Controller
{

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function indexAction()
    {
        return $this->render('TransformCoreAppBundle:Account:index.html.twig',
            array(

            )
        );
    }

}
