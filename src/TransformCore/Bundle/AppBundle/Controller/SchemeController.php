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
            $scheme = $form->getData();

            return $this->redirect(
                $this->getRouteForEligibility(str_replace(' ', '', $scheme->getName()))
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

        return $this->render(
            'TransformCoreAppBundle:Scheme:diplomatic-service-eligibility.html.twig'
        );
    }

    /**
     * @param string $whichScheme
     * @return string
     */
    protected function getRouteForEligibility($whichScheme)
    {
        return $this->generateUrl('transform_core_app_scheme_selection_eligibility_diplomatic_service');
    }
}
