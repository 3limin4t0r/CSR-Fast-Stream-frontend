<?php
namespace TransformCore\Bundle\AppBundle\Menu;

use Knp\Menu\FactoryInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\SecurityContext;

/**
 * Class MenuBuilder
 * @package TransformCore\Bundle\AppBundle\Menu
 */
class MenuBuilder
{
    /**
     * @var FactoryInterface
     */
    private $factory;

    /**
     * @var SecurityContext
     */
    private $securityContext;

    /**
     * @param FactoryInterface $factory
     */
    public function __construct(FactoryInterface $factory, SecurityContext $securityContext)
    {
        $this->factory = $factory;
        $this->securityContext = $securityContext;
    }

    /**
     * @param Request $request
     *
     * @return \Knp\Menu\ItemInterface
     */
    public function createMainMenu(Request $request)
    {
        $menu = $this->factory->createItem('root');
        $menu->setChildrenAttributes(array('class' => 'navbar-nav nav'));

        $menu->addChild('nav.home', array('route' => 'transform_core_app_homepage'));

        if ($this->securityContext->isGranted('IS_AUTHENTICATED_FULLY')) {
            $menu->addChild(
                $this->securityContext->getToken()->getUser()->getEmail(),
                array('route' => 'transform_core_app_account')
            );
            $menu->addChild('nav.logout', array('route' => 'fos_user_security_logout'));
        } else {
            $menu->addChild('nav.register', array('route' => 'fos_user_registration_register'));
            $menu->addChild('nav.login', array('route' => 'fos_user_security_login'));
        }

        return $menu;
    }
}
