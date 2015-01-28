<?php

namespace TransformCore\Bundle\AppBundle\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

class AccountControllerTest extends WebTestCase
{
    public function testIndex()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', 'account');
    }

    public function testProfile()
    {
        $client = static::createClient();

        $crawler = $client->request('GET', '/profile/edit');

        $this->assertTrue($crawler->filter('html:contains("Profile")')->count() > 0);
    }
}
