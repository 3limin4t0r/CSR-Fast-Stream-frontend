<?php
namespace TransformCore\Bundle\AppBundle\Service;

use GuzzleHttp\Client;
use JMS\Serializer\Serializer;
use TransformCore\Bundle\CsrFastStreamBundle\Entity\Education as EducationEntity;

/**
 * Class Education
 *
 * @package TransformCore\Bundle\AppBundle\Service
 */
class Education
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
     * @return EducationEntity
     */
    public function getById($id)
    {
        $response = $this->client
            ->get('/applicants/' . $id . '/education')
            ->getBody()
            ->getContents();

        return $this->serializer
            ->deserialize(
                $response,
                'TransformCore\Bundle\CsrFastStreamBundle\Entity\Education',
                'json'
            );
    }

    /**
     * @param int $applicantId
     * @param EducationEntity $education
     */
    public function update($applicantId, EducationEntity $education)
    {
        $endpoint = '/applicants/' . $applicantId . '/education.json';

        $response = $this->client
            ->put(
                $endpoint,
                array(
                    'body'    => $this->serializer
                        ->serialize($education, 'json'),
                    'headers' => array('Content-Type' => 'application/json')
                )
            );
    }
}
