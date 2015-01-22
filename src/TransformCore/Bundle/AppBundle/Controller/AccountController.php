<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EligibilityFormType;

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

    public function eligibilityAction(Request $request)
    {
        $form = $this->createForm(new EligibilityFormType());
        $form->handleRequest($request);

        if ($form->isValid()) {
            $eligibility = $form->getData();

            // TODO: Save eligibility entity...

            $request->getSession()
                ->getFlashBag()
                    ->add('success', 'Your changes were saved!');

            return $this->redirect(
                $this->generateUrl('transform_core_app_eligibility')
            );
        }

        return $this->render(
            'TransformCoreAppBundle:Account:eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }
}
