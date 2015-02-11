<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Programme;
use TransformCore\Bundle\CsrFastStreamBundle\Form\ProgrammeSelectionFormType;

/**
 * Class ProgrammeController
 * @package TransformCore\Bundle\AppBundle\Controller
 */
class ProgrammeController extends Controller
{

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function selectionAction(Request $request)
    {
        $program = new Programme();

        $form = $this->createForm(new ProgrammeSelectionFormType(), $program);
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
                $this->generateUrl('transform_core_app_programme_selected')
            );
        }

        return $this->render(
            'TransformCoreAppBundle:Programme:selection.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function selectedAction()
    {
        return $this->render('TransformCoreAppBundle:Programme:selected.html.twig');
    }
}
