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
            array(

            )
        );
    }

    /**
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function profileAction(Request $request)
    {
        $applicant = new Applicant();

        $form = $this->createForm(new ProfileFormType(), $applicant);

        $form->handleRequest($request);

        if ($form->isValid()) {
            $applicant = $form->getData();

            var_dump('valid', $applicant); exit;
        }

        return $this->render('TransformCoreAppBundle:Account:profile.html.twig',
            array(
                'form' => $form->createView(),
            )
        );
    }
}
