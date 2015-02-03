<?php

namespace Spec\TransformCore\Bundle\AppBundle\Service;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use GuzzleHttp\Client;
use JMS\Serializer\Serializer;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Eligibility;

class EligibilitySpec extends ObjectBehavior
{

    function let(Client $client, Serializer $serializer)
    {
        $this->beConstructedWith($client, $serializer);
    }

    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\Service\Eligibility');
    }

    function it_gets_applicant_by_id_eligibilty(
        Client $client,
        Serializer $serializer,
        \GuzzleHttp\Message\Response $response,
        \GuzzleHttp\Stream\Stream $stream
    ) {
        $id = 123;
        $jsonData = '{"eligibility":{"id":1}}';

        $stream
            ->getContents()
            ->shouldBeCalled()
            ->willReturn($jsonData);

        $response
            ->getBody()
            ->shouldBeCalled()
            ->willReturn($stream);

        $client
            ->get('/applicants/' . $id . '/eligibility')
            ->shouldBeCalled()
            ->willReturn($response);

        $serializer
            ->deserialize(
                json_encode(json_decode($jsonData)->eligibility),
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Eligibility',
                'json'
            )
            ->shouldBeCalled()
            ->willReturn($response);

        $this->beConstructedWith($client, $serializer);

        $this->getById($id);
    }

    function it_updates_eligibilty(
        Client $client,
        Serializer $serializer,
        \GuzzleHttp\Message\Response $response
    ) {
        $applicantId = 123;
        $eligibility = new Eligibility();
        $eligibility->setId(123);

        $jsonData = '{"id":123}';

        $client
            ->put(
                '/applicants/' . $applicantId . '/eligibility',
                array(
                    'body' => $jsonData
                )
            )
            ->shouldBeCalled()
            ->willReturn($response);

        $serializer
            ->serialize(
                array('csr_dm_user_eligibility' => $eligibility),
                'json'
            )
            ->shouldBeCalled()
            ->willReturn($jsonData);

        $this->beConstructedWith($client, $serializer);

        $this->update($applicantId, $eligibility);
    }
}
