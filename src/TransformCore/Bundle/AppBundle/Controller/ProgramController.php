<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Program;
use TransformCore\Bundle\CsrFastStreamBundle\Form\ProgramSelectionFormType;

/**
 * Class ProgramController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class ProgramController extends Controller
{

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function selectionAction(Request $request)
    {
        $program = new Program();

        $form = $this->createForm(new ProgramSelectionFormType(), $program);
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

        return $this->render(
            'TransformCoreAppBundle:Program:selection.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }
}
