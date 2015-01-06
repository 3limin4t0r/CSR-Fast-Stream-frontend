<?php

namespace TransformCore\Bundle\AppBundle\Features\Context;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\MinkContext;
use Guzzle\Http;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Symfony2Extension\Driver\KernelDriver;

/**
 * Class FeatureContext
 * @package TransformCore\Bundle\AppBundle\Features\Context
 */
class FeatureContext extends MinkContext implements Context, SnippetAcceptingContext

{
    /**
     * The response given from the resource.
     */
    protected $response;
    protected $json_response;
    private $_response;
    public $_client;
    private $_parameters = array();

    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     * @param   array $parameters Context parameters (set them up through behat.yml)
     */

    public function __construct()
    {

    }

    public function getParameter($name)
    {
        if (count($this->_parameters) === 0) {
            throw new \Exception('Parameters not loaded!');
        } else {
            $parameters = $this->_parameters;
            return (isset($parameters[$name])) ? $parameters[$name] : null;
        }
    }

    public function spin($lambda, $wait = 60)
    {
        for ($i = 0; $i < $wait; $i++) {
            try {
                if ($lambda($this)) {
                    return true;
                }
            } catch (\Exception $e) {
                // do nothing
            }
            sleep(1);
        }

        $backtrace = debug_backtrace();

        throw new \Exception(
            "Timeout thrown by " . $backtrace[1]['class'] . "::" . $backtrace[1]['function'] . "()\n" .
            $backtrace[1]['file'] . ", line " . $backtrace[1]['line']
        );
    }

    /**
     * @Given /^I fill form with:$/
     */
    public function fillForm(TableNode $table)
    {
        $page = $this->getSession()->getPage();

        foreach ($table->getRows() as $row) {
            list($fieldSelector, $value) = $row;

            $field = $page->findField($fieldSelector);
            if (empty($field)) {
                $field = $this->getSession()->getDriver()->find('//label[contains(normalize-space(string(.)), "' . $fieldSelector . '")]');
                if (!empty($field)) {
                    $field = current($field);
                }
            }

            $tag = strtolower($field->getTagName());

            if ($tag == 'textarea') {
                $page->fillField($fieldSelector, $value);
            } elseif ($tag == 'select') {
                if ($field->hasAttribute('multiple')) {
                    foreach (explode(',', $value) as $index => $option) {
                        $page->selectFieldOption($fieldSelector, trim($option), true);
                    }
                } else {
                    $page->selectFieldOption($fieldSelector, $value);
                }
            } elseif ($tag == 'input') {
                $type = strtolower($field->getAttribute('type'));
                if ($type == 'checkbox' || $type == 'radio') {
                    if (strtolower($value) == 'yes') {
                        $page->checkField($fieldSelector);
                    } else {
                        $page->uncheckField($fieldSelector);
                    }
//                } elseif ($type == 'radio') {
//                    // TODO: handle radio
                } else {
                    $page->fillField($fieldSelector, $value);
                }
            } elseif ($tag == 'label') {
                foreach (explode(',', $value) as $option) {
                    $option = $this->fixStepArgument(trim($option));
                    $field->getParent()->checkField($option);
                }
            }
        }
    }

    /**
     * @Given /^I should see form with:$/
     */
    public function assertFormContain(TableNode $table)
    {
        foreach ($table->getRows() as $row) {
            list($field, $value) = $row;

            $node = $this->getSession()->getPage()->findField($field);
            if (empty($node)) {
                $node = $this->getSession()->getDriver()->find('//label[contains(normalize-space(string(.)), "' . $field . '")]');
                if (!empty($node)) {
                    $node = current($node);
                }
            }

            if (null === $node) {
                throw new \Behat\Mink\Exception\ElementNotFoundException($this->getSession(), 'form field', 'id|name|label|value', $field);
            }

            if ($node->getTagName() == 'input' && in_array($node->getAttribute('type'), array('checkbox', 'radio'))) {
                $actual = $node->isChecked() ? 'YES' : 'NO';
            } elseif ($node->getTagName() == 'select') {
                $actual = $node->getValue();
                if (!is_array($actual)) {
                    $actual = array($actual);
                }

                $options = array();
                $optionNodes = $this->getSession()->getDriver()->find($node->getXpath() . "/option");
                foreach ($optionNodes as $optionNode) {
                    $options[$optionNode->getValue()] = $optionNode->getText();
                    $options[$optionNode->getText()] = $optionNode->getText();
                }
                foreach ($actual as $index => $optionValue) {
                    if (isset($options[$optionValue])) {
                        $actual[$index] = $options[$optionValue];
                    }
                }
            } elseif ($node->getTagName() == 'label') {
                foreach (explode(',', $value) as $option) {
                    $option = $this->fixStepArgument(trim($option));
                    $this->assertSession()->checkboxChecked($option);
                }
                return true;
            } else {
                $actual = $node->getValue();
            }

            if (is_array($actual)) {
                $actual = join(',', $actual);
            }
            $regex = '/^' . preg_quote($value, '$/') . '/ui';

            if (!preg_match($regex, $actual)) {
                $message = sprintf('The field "%s" value is "%s", but "%s" expected.', $field, $actual, $value);
                throw new \Behat\Mink\Exception\ExpectationException($message, $this->getSession());
            }
        }
    }

    /**
     * @Given /^I fill in "(?P<field>(?:[^"]|\\")*)" with:$/
     */
    public function iFillInWith($field, PyStringNode $string)
    {
        $field = $this->fixStepArgument($field);
        $value = $this->fixStepArgument($string->getRaw());
        $this->getSession()->getPage()->fillField($field, $value);
    }

    /**
     * @Given /^the "(?P<field>[^"]*)" field should contain:$/
     */
    public function assertFieldShouldContain($field, PyStringNode $string)
    {
        $this->assertSession()->fieldValueEquals($field, $string->getRaw());
    }

    /**
     * Checks, that form field with specified id|name|label|value has specified value.
     *
     * @Then /^the "(?P<field>(?:[^"]|\\")*)" multiple field should contain "(?P<value>(?:[^"]|\\")*)"$/
     */
    public function assertFieldContains($field, $value)
    {
        $node = $this->assertSession()->fieldExists($field);
        $actual = $node->getValue();
        if (is_array($actual)) {
            $actual = join(',', $actual);
        }
        $regex = '/^' . preg_quote($value, '$/') . '/ui';

        if (!preg_match($regex, $actual)) {
            $message = sprintf('The field "%s" value is "%s", but "%s" expected.', $field, $actual, $value);
            throw new \Behat\Mink\Exception\ExpectationException($message, $this->getSession());
        }
    }

    /**
     * Returns fixed step argument (with \\" replaced back to ").
     *
     * @param string $argument
     *
     * @return string
     */
    protected function fixStepArgument($argument)
    {
        return str_replace('\\"', '"', $argument);
    }


    /**
     * @When /^I check the "([^"]*)" radio button$/
     */
    public function iCheckTheRadioButton($radioLabel)
    {
        $radioButton = $this->getSession()->getPage()->findField($radioLabel);
        if (null === $radioButton) {
            throw new \Exception("Cannot find radio button " . $radioLabel);
        }
        $value = $radioButton->getAttribute('value');
        $this->getSession()->getDriver()->click($radioButton->getXPath());
        sleep(1);
    }

    /**
     * @Then /^count of "([^"]*)" instances of "(?P<text>[^"]*)" exists on page$/
     */
    public function thePersonsAreUnlinked($count, $area)
    {
        $str = $this->getSession()->getPage()->getContent();
        $count2 = substr_count($str, $area);
        if ($count === $count2) {
            echo 'The count of:' . $count2 . ' is correct';
        } else {
            throw new \Exception("Count " . $count . " expected but got " . $count2);
        }
    }

    /**
     * @Then /^the server code response should be (\d+)$/
     */
    public function theResponseStatusCodeShouldBe($httpStatus)
    {
        if ((string)$this->_response->getStatusCode() !== $httpStatus) {
            throw new \Exception('HTTP code does not match ' . $httpStatus .
                ' (actual: ' . $this->_response->getStatusCode() . ')');
        }
    }

    public function getSymfonyProfile()
    {
        $driver = $this->getSession()->getDriver();
        if (!$driver instanceof KernelDriver) {
            throw new UnsupportedDriverActionException(
                'You need to tag the scenario with '.
                '"@mink:symfony2". Using the profiler is not '.
                'supported by %s', $driver
            );
        }

        $profile = $driver->getClient()->getProfile();
        if (false === $profile) {
            throw new \RuntimeException(
                'The profiler is disabled. Activate it by setting '.
                'framework.profiler.only_exceptions to false in '.
                'your config'
            );
        }

        return $profile;
    }

    /**
     * @Given /^I should get an email on "(?P<email>[^"]+)" with:$/
     */
    public function iShouldGetAnEmail($email, PyStringNode $text)
    {
        $error     = sprintf('No message sent to "%s"', $email);
        $profile   = $this->getSymfonyProfile();
        $collector = $profile->getCollector('swiftmailer');

        foreach ($collector->getMessages() as $message) {
            // Checking the recipient email and the X-Swift-To
            // header to handle the RedirectingPlugin.
            // If the recipient is not the expected one, check
            // the next mail.
            $correctRecipient = array_key_exists(
                $email, $message->getTo()
            );
            $headers = $message->getHeaders();
            $correctXToHeader = false;
            if ($headers->has('X-Swift-To')) {
                $correctXToHeader = array_key_exists($email,
                    $headers->get('X-Swift-To')->getFieldBodyModel()
                );
            }

            if (!$correctRecipient && !$correctXToHeader) {
                continue;
            }

            try {
                // checking the content
                return assertContains(
                    $text->getRaw(), $message->getBody()
                );
            } catch (\Exception $e) {
                $error = sprintf(
                    'An email has been found for "%s" but without '.
                    'the text "%s".', $email, $text->getRaw()
                );
            }
        }

        throw new \Exception($error, $this->getSession());
    }
}

?>
