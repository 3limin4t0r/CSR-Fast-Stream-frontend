<?php
namespace TransformCore\Bundle\AppBundle\Service;

use GuzzleHttp\Client;
use JMS\Serializer\Serializer;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Eligibility as EligibilityEntity;

/**
 * Class Eligibility
 * @package TransformCore\Bundle\AppBundle\Service
 */
class Eligibility
{

    /**
     * @var Client
     */
    private $client;

    /**
     * @var Serializer
     */
    private $serializer;

    /**
     * @param Client $client
     */
    public function __construct(Client $client, Serializer $serializer)
    {
        $this->client = $client;
        $this->serializer = $serializer;
    }

    /**
     * @param int $id
     *
     * @return Eligibility
     */
    public function getById($id)
    {
        $response = $this->client
            ->get('/applicants/' . $id . '/eligibility')
            ->getBody()
            ->getContents();

        return $this->serializer
            ->deserialize(
                json_encode(json_decode($response)->eligibility),
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Eligibility',
                'json'
            );
    }

    /**
     * @param int $applicantId
     * @param EligibilityEntity $eligibility
     */
    public function update($applicantId, EligibilityEntity $eligibility)
    {
        $endpoint = '/applicants/' . $applicantId . '/eligibility?XDEBUG_SESSION_START=6C2B4944';
        $payload = array(
                    'body' => $this->serializer
                        ->serialize(
                            array('csr_dm_user_eligibility' => $eligibility),
                            'json'
                        )

                );

        $this->client
            ->put(
                $endpoint,
                $payload
            );
    }
}
