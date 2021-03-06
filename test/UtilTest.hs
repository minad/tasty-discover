-- Unit tests for Test.Tasty.Util module.

module UtilTest where

import Test.Tasty.HUnit (Assertion, (@?=))
import Test.Tasty.Discover (defaultConfig, getListOfTests,
                            findTests, fileToTest, getFilesRecursive,
                            isValidModuleChar, isValidModuleName,
                            Config(..), Test(..))

case_getListOfTests :: Assertion
case_getListOfTests = do
  result <- getListOfTests "test/tmpdir/" defaultConfig
  result @?= ["case_foo"]

case_getListOfTestsWithSuffix :: Assertion
case_getListOfTestsWithSuffix = do
  let config = Config (Just "DoesntExist") False []
  result <- getListOfTests "test/tmpdir/" config
  result @?= []

case_findTests :: Assertion
case_findTests = do
  result <- findTests "test/tmpdir/" defaultConfig
  result @?= [Test {testFile="test/tmpdir/FooTest.hs", testModule="Foo"}]

case_fileToTest :: Assertion
case_fileToTest = do
  let result = fileToTest "test/tmpdir/" defaultConfig "FooTest.hs"
  result @?= Just Test {testFile="test/tmpdir/FooTest.hs", testModule="Foo"}

case_getFilesRecursive :: Assertion
case_getFilesRecursive = do
  result <- getFilesRecursive "test/tmpdir/"
  result @?= ["FooTest.hs", "README.md"]

case_isValidModuleChar :: Assertion
case_isValidModuleChar = isValidModuleChar 'C' @?= True

case_isValidModuleName :: Assertion
case_isValidModuleName = isValidModuleName "Jim" @?= True
