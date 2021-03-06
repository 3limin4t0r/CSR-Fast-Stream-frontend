<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Diversity;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Education;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Parents\Parents;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\PostgradDegree;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\UndergradDegree;
use TransformCore\Bundle\CsrFastStreamBundle\Form\DiversityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EducationFormType;
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
        $applicant = $this->getApplicant();
        $eligibility = $this->getEligibility();

        $hasApplicantCompletedProfile = !empty(
            $eligibility->hasPermissionToCheckBackground()
        );

        $hasApplicantStartedProfile = !empty(
            $applicant->getAddress()->getLine1()
        );

        return $this->render(
            'TransformCoreAppBundle:Account:index.html.twig',
            [ 'applicant' => $applicant,
              'hasApplicantStartedProfile' => $hasApplicantStartedProfile, 
              'hasApplicantCompletedProfile' => $hasApplicantCompletedProfile ]
        );
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

            // TODO: This needs to be reinstated to work with backend
            // $this->get('transform_core_app_main.service.eligibility')
            //     ->update($applicantId, $eligibility);

            $request->getSession()
                    ->getFlashBag()
                    ->add(
                        'success',
                        'Your changes were saved!'
                    );

            return $this->redirect(
                $this->generateUrl('transform_core_app_education')
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
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function educationAction(Request $request)
    {
        $applicantId = $this->get('security.token_storage')
            ->getToken()
            ->getUser()
            ->getId();

        $education = new Education();

        // TODO: This needs to be reinstated to work with backend
        // $education = $this->get('transform_core_app_main.service.education')
        //     ->getById($applicantId);

        $undergradDegrees = $education->getUndergradDegrees();

        if (is_null($undergradDegrees) || $undergradDegrees->count() == 0) {
            $education->addUndergradDegree(new UndergradDegree());
        }

        $postgradDegrees = $education->getPostgradDegrees();

        if (is_null($postgradDegrees) || $postgradDegrees->count() == 0) {
            $education->addPostgradDegree(new PostgradDegree());
        }

        $form = $this->createForm(new EducationFormType(), $education);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $education = $form->getData();

            // TODO: This needs to be reinstated to work with backend
            // $this->get('transform_core_app_main.service.education')
            //     ->update($applicantId, $education);

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

        return $this->render(
            'TransformCoreAppBundle:Account:education.html.twig',
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
