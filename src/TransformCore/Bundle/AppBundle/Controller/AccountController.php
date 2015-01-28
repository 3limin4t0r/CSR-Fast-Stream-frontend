<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;
use TransformCore\Bundle\CsrFastStreamBundle\Form\ProfileFormType;

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
            array()
        );
    }

    /**
     * @param Request $request
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function profileAction(Request $request)
    {
        $applicant = $this->get('transform_core_app_main.service.applicants')
                          ->getById(
                              $this->get('security.token_storage')
                                   ->getToken()
                                   ->getUser()
                                   ->getId()
                          );

        $form = $this->createForm(new ProfileFormType(), $applicant);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $applicant = $form->getData();

            $this->get('transform_core_app_main.service.applicants')
                 ->update($applicant);

            $request->getSession()
                    ->getFlashBag()
                    ->add(
                        'success',
                        'Your changes were saved!'
                    );

            return $this->redirect(
                $this->generateUrl('transform_core_app_profile_edit')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:profile.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }
}
