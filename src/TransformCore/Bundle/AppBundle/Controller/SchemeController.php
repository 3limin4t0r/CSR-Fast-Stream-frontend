<?php

namespace TransformCore\Bundle\AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Scheme;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\SchemeEligibility\DiplomaticServiceEligibility;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\SchemeEligibility\HousesOfParliamentEligibility;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\SchemeEligibility\ScienceAndEngineeringEligibility;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\SchemeEligibility\CentralDepartmentsEligibility;
use TransformCore\Bundle\CsrFastStreamBundle\Form\SchemeEligibility\DiplomaticServiceEligibilityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\SchemeEligibility\HousesOfParliamentEligibilityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\SchemeEligibility\ScienceAndEngineeringEligibilityFormType;
use TransformCore\Bundle\CsrFastStreamBundle\Form\SchemeEligibility\CentralDepartmentsEligibilityFormType;
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
            $scheme = $form->getData();

            return $this->redirect(
                $this->getRouteForEligibility($scheme->getName())
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

    public function diplomaticServiceEligibilityAction(Request $request)
    {
        $eligibility = new DiplomaticServiceEligibility();

        $form = $this->createForm(new DiplomaticServiceEligibilityFormType(), $eligibility);

        if ('POST' === $request->getMethod()) {
            $eligibility = $form->getData();

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
            'TransformCoreAppBundle:Scheme:diplomatic-service-eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    public function housesOfParliamentEligibilityAction(Request $request)
    {
        $eligibility = new HousesOfParliamentEligibility();

        $form = $this->createForm(new HousesOfParliamentEligibilityFormType(), $eligibility);

        if ('POST' === $request->getMethod()) {
            $eligibility = $form->getData();

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
            'TransformCoreAppBundle:Scheme:houses-of-parliament-eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    public function scienceAndEngineeringEligibilityAction(Request $request)
    {
        $eligibility = new ScienceAndEngineeringEligibility();

        $form = $this->createForm(new ScienceAndEngineeringEligibilityFormType(), $eligibility);

        if ('POST' === $request->getMethod()) {
            $eligibility = $form->getData();

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
            'TransformCoreAppBundle:Scheme:science-and-engineering-eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    public function centralDepartmentsEligibilityAction(Request $request)
    {
        $eligibility = new CentralDepartmentsEligibility();

        $form = $this->createForm(new CentralDepartmentsEligibilityFormType(), $eligibility);

        if ('POST' === $request->getMethod()) {
            $eligibility = $form->getData();

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
            'TransformCoreAppBundle:Scheme:central-departments-eligibility.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }

    /**
     * @param string $whichScheme
     * @return string
     */
    protected function getRouteForEligibility($whichScheme)
    {
        $route = '';

        switch (str_replace(' ', '', $whichScheme)) {
            case 'DiplomaticService' :
                $route = 'transform_core_app_scheme_selection_eligibility_diplomatic_service';
                break;
            case 'HousesofParliament' :
                $route = 'transform_core_app_scheme_selection_eligibility_houses_of_parliament';
                break;
            case 'ScienceandEngineering' :
                $route = 'transform_core_app_scheme_selection_eligibility_science_and_engineering';
                break;
            case 'CentralDepartments' :
                $route = 'transform_core_app_scheme_selection_eligibility_central_departments';
                break;
            default:
                $route = 'transform_core_app_account';
                break;
        }

        return $this->generateUrl($route);
    }
}
