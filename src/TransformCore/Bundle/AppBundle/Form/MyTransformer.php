<?php

namespace TransformCore\Bundle\AppBundle\Form;

use Symfony\Component\Form\DataTransformerInterface;
use Symfony\Component\Form\Exception\TransformationFailedException;
use TransformCore\Bundle\AppBundle\Entity\Detail;

class MyTransformer implements DataTransformerInterface
{


	public function transform($value)
	{
		echo 12312312;
		echo get_class($value);
		return new Detail();
	}

	public function reverseTransform($value)
	{
		// do nothing
	}
}