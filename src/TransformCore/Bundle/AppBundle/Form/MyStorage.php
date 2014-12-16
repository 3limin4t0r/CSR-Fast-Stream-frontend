<?php

namespace TransformCore\Bundle\AppBundle\Form;
use Craue\FormFlowBundle\Storage\SessionStorage;

class MyStorage extends SessionStorage
{
	
	private $logger;
	private $logPrefix = '=====CRAUEFORM INFO=====|||MYSTORAGE|||';

	public function setLogger($logger)
	{
		$this->logger = $logger;
	}


	/**
	 * {@inheritDoc}
	 */
	public function set($key, $value) {
		
		$this->session->set($key, $value);
		
	    $this->logger->info($this->logPrefix.'Setting Data'. json_encode(
	    	array(
	    		$key,
	    		$value
	    	)
	    ));
	}

	/**
	 * {@inheritDoc}
	 */
	public function get($key, $default = null) {


		$this->logger->info($this->logPrefix.'Getting Data'. json_encode(
	    	array(
	    		$key,
	    		$default
	    	)
	    ));

		return $this->session->get($key, $default);
	}

	/**
	 * {@inheritDoc}
	 */
	public function has($key) {


		$this->logger->info($this->logPrefix.'Has-ing Data'. json_encode(
	    	array(
	    		$key	    		
	    	)
	    ));

		return $this->session->has($key);
	}

	/**
	 * {@inheritDoc}
	 */
	public function remove($key) {

		$this->logger->info($this->logPrefix.'Removing Data'. json_encode(
	    	array(
	    		$key
	    	)
	    ));

		return $this->session->remove($key);
	}


}



