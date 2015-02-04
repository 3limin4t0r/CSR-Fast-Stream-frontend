<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Parents\Parents;
use TransformCore\Bundle\CsrFastStreamBundle\Form\DiversityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EligibilityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\ParentsFormType;
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
                $this->generateUrl('transform_core_app_diversity')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:eligibility.html.twig',
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
    public function diversityAction(Request $request)
    {
        $applicant = new Applicant();

        $form = $this->createForm(new DiversityFormType(), $applicant);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $diversity = $form->getData();

            $request->getSession()
                    ->getFlashBag()
                    ->add(
                        'success',
                        'Your changes were saved!'
                    );

            return $this->redirect(
                $this->generateUrl('transform_core_app_socio_economic')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:diversity.html.twig',
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
    public function socioeconomicAction(Request $request)
    {
        $parents = new Parents();

        $form = $this->createForm(new ParentsFormType(), $parents);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $parents = $form->getData();

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

        return $this->render('TransformCoreAppBundle:Account:socioeconomic.html.twig',
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

        return $this->render(
            'TransformCoreAppBundle:Account:review.html.twig',
            [ 'applicant' => $applicant,
              'eligibility' => $eligibility ]
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
}
