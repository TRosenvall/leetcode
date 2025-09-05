import Foundation
import XCTest

//Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
//
//An input string is valid if:
//
//    Open brackets must be closed by the same type of brackets.
//    Open brackets must be closed in the correct order.
//    Every close bracket has a corresponding open bracket of the same type.
//
// 
//
//Example 1:
//
//Input: s = "()"
//
//Output: true
//
//Example 2:
//
//Input: s = "()[]{}"
//
//Output: true
//
//Example 3:
//
//Input: s = "(]"
//
//Output: false
//
//Example 4:
//
//Input: s = "([])"
//
//Output: true
//
//Example 5:
//
//Input: s = "([)]"
//
//Output: false
//
// 
//
//Constraints:
//
//    1 <= s.length <= 104
//    s consists of parentheses only '()[]{}'.
//

class Solution {
    func isValid(_ s: String) -> Bool {
        var parentheses: [Character] = []

        for char in s {
            if char == "[" || char == "{" || char == "(" {
                parentheses.append(char)
            }
            if char == "]" {
                if parentheses.last == "[" {
                    parentheses.removeLast()
                } else {
                    return false
                }
            }
            if char == "}" {
                if parentheses.last == "{" {
                    parentheses.removeLast()
                } else {
                    return false
                }
            }
            if char == ")" {
                if parentheses.last == "(" {
                    parentheses.removeLast()
                } else {
                    return false
                }
            }
        }

        return parentheses.isEmpty
    }
}

/// Test Cases
class TestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let s = "()"
        var expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.isValid(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "()[]{}"
        var expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.isValid(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "(]"
        var expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.isValid(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 4:
    func testCase4() {
        let s = "([])"
        var expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.isValid(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 5:
    func testCase5() {
        let s = "([)]"
        var expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.isValid(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }
}

/// Testing Code Taken From https://github.com/sshrpe/TDDSwiftPlayground

//:
//: This is the TestRunner, which runs the tests from an XCTestCase and reports on the
//: results. This is done using the same XCTestSuite mechanism which Xcode uses to run
//: unit tests. At the end of the run, a message is printed to the console, telling you
//: how many tests were run, how long it took, and how many of the tests failed.
//:

public struct TestRunner {
    public init() { }

    public func runTests(testClass:AnyClass) {
        let tests = testClass as! XCTestCase.Type
        let testSuite = tests.defaultTestSuite
        testSuite.run()
        _ = testSuite.testRun as! XCTestSuiteRun
    }
}

TestRunner().runTests(testClass: TestCases.self)

