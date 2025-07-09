import Foundation
import XCTest

/// Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to
/// go outside the signed 32-bit integer range [-2^31, 2^31 - 1], then return 0.
///
/// Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
///
/// Example 1:
///
/// Input: x = 123
/// Output: 321
///
/// Example 2:
///
/// Input: x = -123
/// Output: -321
///
/// Example 3:
///
/// Input: x = 120
/// Output: 21
///
/// Constraints:
///
///    -2^31 <= x <= 2^31 - 1

struct SafeInt32 {
    private(set) var value: Int32

    init(_ rawValue: Int) {
        if rawValue >= Int(Int32.min) && rawValue <= Int(Int32.max) {
            self.value = Int32(rawValue)
        } else {
            self.value = 0
        }
    }

    init(_ rawValue: Int64) {
        if rawValue >= Int64(Int32.min) && rawValue <= Int64(Int32.max) {
            self.value = Int32(rawValue)
        } else {
            self.value = 0
        }
    }

    func reversed() -> Int {
        let isNegative = self.value < 0
        let absValue = Int64(abs(self.value)) // Use Int64 to avoid overflow during reversal

        // Reverse the digits
        let reversedString = String(String(absValue).reversed())
        guard let reversedNumber = Int64(reversedString) else {
            return 0
        }

        // Reapply sign
        let signedReversed = isNegative ? -reversedNumber : reversedNumber

        // Check if it fits in Int32
        if signedReversed < Int64(Int32.min) || signedReversed > Int64(Int32.max) {
            return 0 // Drop to 0 if out of bounds
        }

        return Int(signedReversed)
    }
}

extension SafeInt32: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension SafeInt32: Comparable {
    static func < (lhs: SafeInt32, rhs: SafeInt32) -> Bool {
        lhs.value < rhs.value
    }
}

class Solution {
    func reverse(_ x: Int) -> Int {
        return SafeInt32(x).reversed()
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
        let x = 123
        let expected = 321
        XCTAssertEqual(solution.reverse(x), expected)
    }

    /// Case 2:
    func testCase2() {
        let x = -123
        let expected = -321
        XCTAssertEqual(solution.reverse(x), expected)
    }

    /// Case 3:
    func testCase3() {
        let x = 120
        let expected = 21
        XCTAssertEqual(solution.reverse(x), expected)
    }

    /// Case 4:
    func testCase4() {
        let x = -1563847412
        let expected = 0
        XCTAssertEqual(solution.reverse(x), expected)
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

