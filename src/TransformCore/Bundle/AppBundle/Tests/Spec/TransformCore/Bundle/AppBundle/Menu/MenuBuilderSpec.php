<?php

namespace Spec\TransformCore\Bundle\AppBundle\Menu;

use Knp\Menu\FactoryInterface;
use Knp\Menu\ItemInterface;
use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use Symfony\Component\HttpFoundation\Request;

class MenuBuilderSpec extends ObjectBehavior
{

//    function let(FactoryInterface $factory, ItemInterface $menu)
//    {
//        $factory->createItem('root')->shouldBeCalled()->willReturn($menu);
//        $this->beConstructedWith($factory, true);
//    }

    function it_is_initializable(FactoryInterface $factory)
    {
        $this->beConstructedWith($factory, true);
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\Menu\MenuBuilder');
    }

    function it_builds_the_menu(FactoryInterface $factory, ItemInterface $menu, Request $request)
    {
        $menu->setChildrenAttributes(array('class' => 'navbar-nav nav'))
            ->shouldBeCalled()
            ->willReturn($menu);

        $menu->addChild('nav.home', array('route' => 'transform_core_app_homepage'))
            ->shouldBeCalled()
            ->willReturn($menu);

        $menu->addChild('nav.login', array('route' => 'transform_core_app_homepage'))
            ->shouldBeCalled()
            ->willReturn($menu);

        $factory->createItem('root')
            ->shouldBeCalled()
            ->willReturn($menu);

        $this->beConstructedWith($factory, true);

        $this->createMainMenu($request)->shouldHaveType('\Knp\Menu\ItemInterface');
    }
}
