<?php

namespace Spec\TransformCore\Bundle\AppBundle\Service;

use PhpSpec\ObjectBehavior;
use Prophecy\Argument;
use GuzzleHttp\Client;
use JMS\Serializer\Serializer;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;

class ApplicantsSpec extends ObjectBehavior
{

    function let(Client $client, Serializer $serializer)
    {
        $this->beConstructedWith($client, $serializer);
    }

    function it_is_initializable()
    {
        $this->shouldHaveType('TransformCore\Bundle\AppBundle\Service\Applicants');
    }

    function it_gets_applicant_by_id(
        Client $client,
        Serializer $serializer,
        \GuzzleHttp\Message\Response $response,
        \GuzzleHttp\Stream\Stream $stream
    )
    {
        $id = 123;
        $jsonData = '{"applicant":{"id":1}}';

        $stream
            ->getContents()
            ->shouldBeCalled()
            ->willReturn($jsonData);

        $response
            ->getBody()
            ->shouldBeCalled()
            ->willReturn($stream);

        $client
            ->get('/applicants/' . $id)
            ->shouldBeCalled()
            ->willReturn($response);

        $serializer
            ->deserialize(
                json_encode(json_decode($jsonData)->applicant),
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant',
                'json'
            )
            ->shouldBeCalled()
            ->willReturn($response);

        $this->beConstructedWith($client, $serializer);

        $this->getById($id);
    }

    function it_updates_applicant(
        Client $client,
        Serializer $serializer,
        \GuzzleHttp\Message\Response $response,
        \GuzzleHttp\Stream\Stream $stream
    )
    {
        $applicant = new Applicant();
        $applicant->setId(123);

        $jsonData = '{"applicant":{"id":123}}';

        $stream
            ->getContents()
            ->shouldBeCalled()
            ->willReturn($jsonData);

        $response
            ->getBody()
            ->shouldBeCalled()
            ->willReturn($stream);

        $client
            ->put(
                '/applicants/' . $applicant->getId(),
                array(
                    'body' => array(
                        $jsonData
                    )
                )
            )
            ->shouldBeCalled()
            ->willReturn($response);

        $serializer
            ->serialize(
                $applicant,
                'json'
            )
            ->shouldBeCalled()
            ->willReturn($jsonData);

        $serializer
            ->deserialize(
                json_encode(json_decode($jsonData)->applicant),
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant',
                'json'
            )
            ->shouldBeCalled()
            ->willReturn($response);

        $this->beConstructedWith($client, $serializer);

        $this->update($applicant);
    }
}
