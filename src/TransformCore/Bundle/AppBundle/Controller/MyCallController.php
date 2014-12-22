<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

/**
 * Class DefaultController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class MyCallController extends Controller
{

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function indexAction()
    {

        $sdk = new \CSRSimpleSDK\SDK('foo', 'XML', 600);
        $output = $sdk->doCall('api/read', array('username' => 'foo', 'num' => 50), false);


        return $this->render('TransformCoreAppBundle:Default:mycall.html.twig');
    }


}
