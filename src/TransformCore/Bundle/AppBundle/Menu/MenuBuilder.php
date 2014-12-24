<?php
namespace TransformCore\Bundle\AppBundle\Menu;

use Knp\Menu\FactoryInterface;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class MenuBuilder
 * @package TransformCore\Bundle\AppBundle\Menu
 */
class MenuBuilder
{
    private $factory;

    /**
     * @param FactoryInterface $factory
     */
    public function __construct(FactoryInterface $factory)
    {
        $this->factory = $factory;
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
        $menu->addChild('nav.login', array('route' => 'transform_core_app_homepage'));
        // ... add more children

        return $menu;
    }
}
