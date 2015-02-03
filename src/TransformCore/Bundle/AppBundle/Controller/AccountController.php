<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Authentication\Token\AnonymousToken;

use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EligibilityFormType;
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
        return $this->render('TransformCoreAppBundle:Account:index.html.twig');
    }

    /**
     * @param Request $request
     *
     * @return \Symfony\Component\HttpFoundation\RedirectResponse|\Symfony\Component\HttpFoundation\Response
     */
    public function profileAction(Request $request)
    {
        if (!$this->isUserAuthenticated()) {
            return $this->redirect(
                $this->generateUrl('fos_user_security_login')
            );
        }

        $applicant = $this->getApplicant();

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
                $this->generateUrl('transform_core_app_eligibility')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:profile.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    /**
     * @param Request $request
     *
     * @return \Symfony\Component\HttpFoundation\RedirectResponse|\Symfony\Component\HttpFoundation\Response
     */
    public function eligibilityAction(Request $request)
    {
        if (!$this->isUserAuthenticated()) {
            return $this->redirect(
                $this->generateUrl('fos_user_security_login')
            );
        }

        $eligibility = $this->getEligibility();

        $form = $this->createForm(new EligibilityFormType(), $eligibility);
        $form->handleRequest($request);

        if ($form->isValid()) {

            $applicantId = $this->getApplicantId();
            $eligibility = $form->getData();

            $this->get('transform_core_app_main.service.eligibility')
                 ->update($applicantId, $eligibility);

            $request->getSession()
                    ->getFlashBag()
                    ->add(
                        'success',
                        'Your changes were saved!'
                    );

            return $this->redirect(
                $this->generateUrl('transform_core_app_review')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    /**
     * @return \Symfony\Component\HttpFoundation\RedirectResponse|\Symfony\Component\HttpFoundation\Response
     */
    public function reviewAction()
    {
        if (!$this->isUserAuthenticated()) {
            return $this->redirect(
                $this->generateUrl('fos_user_security_login')
            );
        }

        $validator = $this->get('validator');

        $applicant = $this->getApplicant();
        $applicantErrors = $validator->validate($applicant);
        if (count($applicantErrors) > 0) {
            return $this->redirect(
                $this->generateUrl('transform_core_app_profile_edit')
            );
        }

        $eligibility = $this->getEligibility();
        $eligibilityErrors = $validator->validate($eligibility);
        if (count($eligibilityErrors) > 0) {
            return $this->redirect(
                $this->generateUrl('transform_core_app_eligibility')
            );
        }

        $profileForm = $this->createForm(new ProfileFormType(), $applicant);
        $eligibilityForm = $this->createForm(new EligibilityFormType(), $eligibility);

        return $this->render(
            'TransformCoreAppBundle:Account:review.html.twig',
            [ 'profileForm' => $profileForm->createView(),
              'eligibilityForm' => $eligibilityForm->createView() ]
        );
    }

    /**
     * @return \TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant
     */
    private function getApplicant()
    {
        $applicantId = $this->getApplicantId();
        return $this->get('transform_core_app_main.service.applicants')
                    ->getById($applicantId);
    }

    /**
     * @return \TransformCore\Bundle\CsrFastStreamBundle\Entity\Eligibility
     */
    private function getEligibility()
    {
        $applicantId = $this->getApplicantId();
        return $this->get('transform_core_app_main.service.eligibility')
                    ->getById($applicantId);
    }

    /**
     * @return int
     */
    private function getApplicantId()
    {
        return $this->get('security.token_storage')
                    ->getToken()
                    ->getUser()
                    ->getId();
    }

    /**
     * @return bool
     */
    private function isUserAuthenticated()
    {
        $token = $this->get('security.token_storage')
                      ->getToken();

        return !($token instanceof AnonymousToken);
    }
}
