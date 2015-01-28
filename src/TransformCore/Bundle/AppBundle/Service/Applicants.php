<?php
namespace TransformCore\Bundle\AppBundle\Service;

use GuzzleHttp\Client;
use JMS\Serializer\Serializer;
use Monolog\Logger;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant;

/**
 * Class Applicants
 * @package TransformCore\Bundle\AppBundle\Service
 */
class Applicants
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
     * @return Applicant
     */
    public function getById($id)
    {
        $response = $this->client
            ->get('/applicants/' . $id)
            ->getBody()
            ->getContents();

        return $this->serializer
            ->deserialize(
                json_encode(json_decode($response)->applicant),
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Applicant',
                'json'
            );
    }

    /**
     * @param Applicant $applicant
     *
     * @return Applicant
     */
    public function update(Applicant $applicant)
    {
        $response = $this->client
            ->put(
                '/applicants/' . $applicant->getId(),
                array(
                    'body' => array(
                        'csr_dm_user_profile' => json_decode(
                            $this->serializer
                                ->serialize(
                                    $applicant,
                                    'json'
                                ), true
                        )
                    )
                )
            );

        return $applicant;
    }
}
