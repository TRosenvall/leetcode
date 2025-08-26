import Foundation
import XCTest

// Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer.
//
// The algorithm for myAtoi(string s) is as follows:
//
// 1. Whitespace: Ignore any leading whitespace (" ").
// 2. Signedness: Determine the sign by checking if the next character is '-' or '+', assuming positivity if neither present.
// 3. Conversion: Read the integer by skipping leading zeros until a non-digit character is encountered or the end of the string is reached. If no digits were read, then the result is 0.
// 4. Rounding: If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then round the integer to remain in the range. Specifically, integers less than -231 should be rounded to -231, and integers greater than 231 - 1 should be rounded to 231 - 1.
//
// Return the integer as the final result.
//
//
// Example 1:
//
// Input: s = "42"
//
// Output: 42
//
// Explanation:
//
// The underlined characters are what is read in and the caret is the current reader position.
// Step 1: "42" (no characters read because there is no leading whitespace)
//         ^
// Step 2: "42" (no characters read because there is neither a '-' nor '+')
//         ^
// Step 3: "42" ("42" is read in)
//
//
// Example 2:
//
// Input: s = " -042"
//
// Output: -42
//
// Explanation:
//
// Step 1: "   -042" (leading whitespace is read and ignored)
//             ^
// Step 2: "   -042" ('-' is read, so the result should be negative)
//              ^
// Step 3: "   -042" ("042" is read in, leading zeros ignored in the result)
//
//
// Example 3:
//
// Input: s = "1337c0d3"
//
// Output: 1337
//
// Explanation:
//
// Step 1: "1337c0d3" (no characters read because there is no leading whitespace)
//          ^
// Step 2: "1337c0d3" (no characters read because there is neither a '-' nor '+')
//          ^
// Step 3: "1337c0d3" ("1337" is read in; reading stops because the next character is a non-digit)
//              ^
//
// Example 4:
//
// Input: s = "0-1"
//
// Output: 0
//
// Explanation:
//
// Step 1: "0-1" (no characters read because there is no leading whitespace)
//          ^
// Step 2: "0-1" (no characters read because there is neither a '-' nor '+')
//          ^
// Step 3: "0-1" ("0" is read in; reading stops because the next character is a non-digit)
//           ^
//
// Example 5:
//
// Input: s = "words and 987"
//
// Output: 0
//
// Explanation:
//
// Reading stops at the first non-digit character 'w'.
//
//
// Constraints:
//
//    0 <= s.length <= 200
//    s consists of English letters (lower-case and upper-case), digits (0-9), ' ', '+', '-', and '.'.



extension Int {
    /// DOES NOT WORK FOR NEGATIVE EXPONENTS
    func pow(_ exp: Int) -> Int {
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
}
class Solution {
//    // Solution 1: Brute force ~22ms
//    func myAtoi(_ s: String) -> Int {
//        print("=======")
//        if s.count == 0 { return 0 }
//
//        var trimmed = Array(s)
//        var indicies: [Int] = []
//        for i in 0..<trimmed.count {
//            if trimmed[i] == " " {
//                indicies.append(i)
//            } else {
//                break
//            }
//        }
//        for i in indicies.reversed() {
//            trimmed.remove(at: i)
//        }
//
//        var isNegative: Bool = false
//        if trimmed.first == "-" {
//            isNegative = true
//            trimmed.remove(at: 0)
//        } else if trimmed.first == "+" {
//            trimmed.remove(at: 0)
//        } else if let first = trimmed.first, !first.isNumber {
//            return 0
//        }
//
//        var nums: [Character] = []
//        for char in trimmed {
//            if char.isNumber {
//                nums.append(char)
//            } else {
//                break
//            }
//        }
//
//        indicies = []
//        for i in 0..<nums.count {
//            if nums[i] == "0" {
//                indicies.append(i)
//            } else {
//                break
//            }
//        }
//        for i in indicies.reversed() {
//            nums.remove(at: i)
//        }
//
//        if nums.count > 10 {
//            nums = Array(nums[0...10])
//        }
//        nums = nums.reversed()
//
//        var number = 0
//        print(nums)
//        for i in 0..<nums.count {
//            let check = nums[i]
//            print(i)
//            let place = 10.pow(i)
//
//            if check.isNumber {
//                number += (Int(String(check)) ?? 0) * place
//            }
//        }
//
//        if isNegative {
//            number = -number
//        }
//
//        let top = 2.pow(31) - 1
//        let bottom = -2.pow(31)
//        if number > top {
//            number = top
//        }
//        if number < bottom {
//            number = bottom
//        }
//
//        return number
//    }

    // Solution 2
    func myAtoi(_ s: String) -> Int {
        if s.isEmpty { return 0 }

        let max = 2.pow(31)-1
        let min = -2.pow(31)

        let sArray = Array(s)
        var i = 0
        while i < sArray.count && sArray[i] == " " {
            i += 1
        }

        if i == sArray.count {
            return 0
        }

        let sign = sArray[i] == "-" ? -1 : 1

        if sArray[i] == "+" || sArray[i] == "-" {
            i += 1
        }

        var num = 0
        while i < sArray.count && sArray[i].isNumber {
            guard let digit = Int(String(sArray[i]))
            else { return 0 }

            num = num * 10 + digit

            if sign * num >= max {
                return max
            } else if sign * num <= min {
                return min
            }

            i += 1
        }

        return sign * num
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
        let s = "42"
        let expected = 42

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "   -042"
        let expected = -42

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "1337c0d3"
        let expected = 1337

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 4:
    func testCase4() {
        let s = "0-1"
        let expected = 0

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 5:
    func testCase5() {
        let s = "words and 987"
        let expected = 0

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 6:
    func testCase6() {
        let s = "  0000000000012345678"
        let expected = 12345678

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 7:
    func testCase7() {
        let s = "   +0 123"
        let expected = 0

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.myAtoi(s)
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

