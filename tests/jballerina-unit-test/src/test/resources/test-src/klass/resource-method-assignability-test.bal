// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

service class Foo {
    resource function get greeting() returns string => "hello";

    remote function hello() {

    }

    function foo() returns int => 42;
}

service class Bar {
    resource function dot hello() returns string => "hello";

    remote function hello() {

    }

    function foo() returns int => 32;
}

function testServiceObjectValue() {
    // Below assignments is allowed as resource methods are not part of the type.
    Foo f = new Bar();
    assertEquality(f.foo(), 32);

    Bar bar = service object {
        remote function hello() {

        }

        function foo() returns int => 52;
    };
    assertEquality(bar.foo(), 52);
}

function assertEquality(any|error actual, any|error expected) {
    if expected is anydata && actual is anydata && expected == actual {
        return;
    }

    if expected === actual {
        return;
    }

    string expectedValAsString = expected is error ? expected.toString() : expected.toString();
    string actualValAsString = actual is error ? actual.toString() : actual.toString();
    panic error("AssertionError",
            message = "expected '" + expectedValAsString + "', found '" + actualValAsString + "'");
}
