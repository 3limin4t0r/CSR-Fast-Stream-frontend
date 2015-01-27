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
     * @var Logger
     */
    private $logger;

    /**
     * @param Client $client
     */
    public function __construct(Client $client, Serializer $serializer, Logger $logger)
    {
        $this->client = $client;
        $this->serializer = $serializer;
        $this->logger = $logger;
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

        $this->logger->debug($response);
        $this->logger->debug(json_encode(json_decode($response)->applicant));

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
