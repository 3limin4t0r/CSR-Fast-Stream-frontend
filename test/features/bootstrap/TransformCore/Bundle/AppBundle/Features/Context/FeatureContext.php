<?php

namespace TransformCore\Bundle\AppBundle\Features\Context;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Hook\Scope\AfterStepScope;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Colors\Color;

/**
 * Class FeatureContext
 * @package TransformCore\Bundle\AppBundle\Features\Context
 */
class FeatureContext extends MinkContext implements Context, SnippetAcceptingContext

{
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

            if (empty($field)) {
                throw new \Exception('Field not found: ' . $fieldSelector);
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
                if ($type == 'checkbox') {
                    if (strtolower($value) == 'yes') {
                        $page->checkField($fieldSelector);
                    } else {
                        $page->uncheckField($fieldSelector);
                    }
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
                throw new \Exception($this->getSession(), 'form field', 'id|name|label|value', $field);
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
                throw new \Exception($message);
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

            throw new \Exception($message);
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
        $this->getSession()->getPage()->fillField($radioLabel, '1');
    }

    /**
     * @Then /^count of "([^"]*)" instances of "(?P<text>[^"]*)" exists on page$/
     */
    public function thePersonsAreUnlinked($count, $area)
    {
        sleep(1);
        $str = $this->getSession()->getPage()->getContent();
        $count2 = substr_count($str, $area);
        if ($count == $count2) {
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

    /**
     * @Given I am logged in as :arg1 with password :arg2
     */
    public function iAmLoggedInAsWithPassword($email, $password)
    {
        $this->visitPath('/');
        $this->getSession()->getPage()->clickLink('Login');
        $this->getSession()->getPage()->fillField('username', $email);
        $this->getSession()->getPage()->fillField('password', $password);
        $this->getSession()->getPage()->pressButton('Login');
        $this->assertResponseContains($email);
    }

    /**
     * @Given following users for each persona exist on system:
     */
    public function followingUsersForEachPersonaExistOnSystem(TableNode $table)
    {
        return true;
    }

    /**
     * @Given :arg1 has completed sections :arg2
     */
    public function hasCompletedTheSection($arg1, $arg2)
    {
        return true;
    }

    /**
     * @Given :arg1 has completed the :arg2 sections
     */
    public function hasCompletedTheSections($applicant, $sections)
    {
        return true;
    }

    /** @AfterStep */
    public function after(AfterStepScope $scope) {
        
        if ($scope->getTestResult()->isPassed()) {
            return;    
        }

        $session = $this->getSession();
        $page = $session->getPage();

        $currentUrl = $session->getCurrentUrl();
        $statusCode = $session->getStatusCode();
        $responseHeaders = $session->getResponseHeaders();
        $content = ''; // $page->getContent();

        $c = new Color();

        echo("$currentUrl ($statusCode)\n");
        echo("\n");
        foreach ($responseHeaders as $name => $values) {
            $name = implode('-', array_map('ucfirst', explode('-', $name)));
            echo("$name=$values[0]\n");
        }
        echo("\n");

        $highlightedSource = $content;

        $highlightedSource = preg_replace_callback("/(&#[0-9]+;)/", function($match) { return mb_convert_encoding($match[1], "UTF-8", "HTML-ENTITIES"); }, $highlightedSource);

        $highlightedSource = str_replace('&nbsp;', ' ', $highlightedSource);
        $highlightedSource = str_replace('&quot;', '"', $highlightedSource);

        $highlightedSource = preg_replace_callback(
            '|(<)([a-z0-9]+)([^<>]*?)(/?)(>)|s',
            function ($matches) use ($c)
            {
                $attributes = preg_replace_callback(
                    '|(\s+)([a-z0-9-_]+)(=)(["\'])(.*?)(["\'])|s',
                    function ($matches) use ($c)
                    {
                        $output = (
                            $matches[1]
                           .(string) $c($matches[2])->light_cyan
                           .(string) $c($matches[3])->light_blue
                           .(string) $c($matches[4])->light_cyan
                           .(string) $c($matches[5])->light_yellow
                           .(string) $c($matches[6])->light_cyan
                        );

                        return $output;
                    },
                    $matches[3]
                );

                $output = (
                    (string) $c($matches[1])->light_magenta
                   .(string) $c($matches[2])->light_red
                   .$attributes
                   .(string) $c($matches[4])->light_red
                   .(string) $c($matches[5])->light_magenta
                );

                return $output;
            },
            $highlightedSource
        );

        $highlightedSource = preg_replace_callback(
            '|(<)([/])([^<>]*?)(>)|',
            function ($matches) use ($c)
            {
                $output = (
                    (string) $c($matches[1])->light_magenta
                   .(string) $c($matches[2])->light_magenta
                   .(string) $c($matches[3])->light_red
                   .(string) $c($matches[4])->light_magenta
                );

                return $output;
            },
            $highlightedSource
        );

        $highlightedSource = preg_replace_callback(
            '|(<!)(.*?)(>)|s',
            function ($matches) use ($c)
            {
                $output = (
                    (string) $c($matches[1])->green
                   .(string) $c($matches[2])->light_green
                   .(string) $c($matches[3])->green
                );

                return $output;
            },
            $highlightedSource
        );
        
        $highlightedSource = str_replace(
            '-->',
            (string) $c('--')->light_green
           .(string) $c('>')->green,
            $highlightedSource
        );

        echo($highlightedSource);
    }
}
