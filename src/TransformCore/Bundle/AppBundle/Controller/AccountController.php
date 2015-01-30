<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EducationFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\EligibilityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Degree;
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
     * @return \Symfony\Component\HttpFoundation\RedirectResponse|\Symfony\Component\HttpFoundation\Response
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
     * @return Symfony\Component\HttpFoundation\Response
     */
    public function educationAction(Request $request)
    {
        $applicantId = $this->get('security.token_storage')
            ->getToken()
            ->getUser()
            ->getId();

        $education = $this->get('transform_core_app_main.service.education')
            ->getById($applicantId);

        $undergradDegrees = $education->getUndergradDegrees();

        if (is_null($undergradDegrees) || $undergradDegrees->count() == 0) {
            $education->addUndergradDegree(new Degree());
        }

        $postgradDegrees = $education->getPostgradDegrees();

        if (is_null($postgradDegrees) || $postgradDegrees->count() == 0) {
            $education->addPostgradDegree(new Degree());
        }

        $form = $this->createForm(new EducationFormType(), $education);
        $form->handleRequest($request);

        if ($form->isValid()) {
            $education = $form->getData();

            $this->get('transform_core_app_main.service.education')
                 ->update($applicantId, $education);

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
    public function eligibilityAction(Request $request)
    {
        $applicantId = $this->get('security.token_storage')
                                   ->getToken()
                                   ->getUser()
                                   ->getId();
        
        $eligibility = $this->get('transform_core_app_main.service.eligibility')
                          ->getById($applicantId);

        $form = $this->createForm(new EligibilityFormType(), $eligibility);
        $form->handleRequest($request);

        if ($form->isValid()) {
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
                $this->generateUrl('transform_core_app_eligibility')
            );
        }

        return $this->render('TransformCoreAppBundle:Account:eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }
}
