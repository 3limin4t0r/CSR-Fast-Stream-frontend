<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Scheme;
use TransformCore\Bundle\CsrFastStreamBundle\Form\SchemeSelectionFormType;

/**
 * Class SchemeController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class SchemeController extends Controller
{
    public function selectionAction(Request $request)
    {
        $scheme = new Scheme();

        $form = $this->createForm(new SchemeSelectionFormType(), $scheme);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $program = $form->getData();

            $request->getSession()
                ->getFlashBag()
                ->add(
                    'success',
                    'Your changes were saved!'
                );

            return $this->redirect(
                $this->generateUrl('transform_core_app_account')
            );
        }

        return
            $this->render(
                'TransformCoreAppBundle:Scheme:selection.html.twig',
                array(
                    'form' => $form->createView(),
                )
            );
    }
}
