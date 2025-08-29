import Foundation
import XCTest

// Given an integer x, return true if x is a , and false otherwise.
// Example 1:
//
// Input: x = 121
// Output: true
// Explanation: 121 reads as 121 from left to right and from right to left.
//
// Example 2:
//
// Input: x = -121
// Output: false
// Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
//
// Example 3:
//
// Input: x = 10
// Output: false
// Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
//
// Constraints:
//
//    -2^31 <= x <= 2^31 - 1
//
// 
//Follow up: Could you solve it without converting the integer to a string?


extension Int {

    func pow(_ exp: Int) -> Double {
        if exp < 0 {
            return negPow(exp)
        } else {
            return Double(posPow(exp))
        }
    }

    private func posPow(_ exp: Int) -> Int {
        var base = self
        var exp = exp
        var result = 1

        while exp > 0 {
            if exp & 1 == 1 { result *= base }
            base *= base
            exp /= 2
        }

        return result
    }

    private func negPow(_ exp: Int) -> Double {
        var result = posPow(exp)

        let inverse = 1/Double(result)
        return inverse
    }

    var digits: [Int] {
        var n = self
        var result: [Int] = []
        if n == 0 { return [0] }
        
        while n > 0 {
            result.append(n % 10)  // last digit
            n /= 10                // remove last digit
        }
        
        return result.reversed()   // reverse so it's most-significant first
    }

}
class Solution {
    func isPalindrome(_ x: Int) -> Bool {
        let max = 2.pow(31)-1
        let min = 0

        if x < min { return false }
        let intArray = x.digits

        if intArray.count == 2 && intArray[0] != intArray[1] {
            return false
        }

        var i = 0
        while i < intArray.count/2 && intArray[i] == intArray.reversed()[i] {
            i += 1
        }


        if i >= intArray.count/2 {
            return true
        }
        return false
    }
}

/// Test Cases
class ReverseIntegerTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let x = 121
        let expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isPalindrome(x)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let x = -121
        let expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isPalindrome(x)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let x = 10
        let expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isPalindrome(x)
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

TestRunner().runTests(testClass: ReverseIntegerTestCases.self)

