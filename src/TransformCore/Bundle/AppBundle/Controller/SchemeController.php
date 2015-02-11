<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class SchemeController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class SchemeController extends Controller
{
    public function selectionAction(Request $request)
    {
       return
            $this->render(
                'TransformCoreAppBundle:Scheme:selection.html.twig'
            );
    }
}
