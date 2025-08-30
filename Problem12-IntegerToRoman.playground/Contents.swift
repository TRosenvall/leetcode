import Foundation
import XCTest

// Seven different symbols represent Roman numerals with the following values:
//
// Symbol    Value
// I    1
// V    5
// X    10
// L    50
// C    100
// D    500
// M    1000
//
// Roman numerals are formed by appending the conversions of decimal place values from highest to lowest.
// Converting a decimal place value into a Roman numeral has the following rules:
//
// - If the value does not start with 4 or 9, select the symbol of the maximal value that can be subtracted from the
// input, append that symbol to the result, subtract its value, and convert the remainder to a Roman numeral.
// - If the value starts with 4 or 9 use the subtractive form representing one symbol subtracted from the following
// symbol, for example, 4 is 1 (I) less than 5 (V): IV and 9 is 1 (I) less than 10 (X): IX. Only the following
// subtractive forms are used: 4 (IV), 9 (IX), 40 (XL), 90 (XC), 400 (CD) and 900 (CM).
// - Only powers of 10 (I, X, C, M) can be appended consecutively at most 3 times to represent multiples of 10. You
// cannot append 5 (V), 50 (L), or 500 (D) multiple times. If you need to append a symbol 4 times use the
// subtractive form.
//
// Given an integer, convert it to a Roman numeral.

// Example 1:
// Input: num = 3749
// Output: "MMMDCCXLIX"
// Explanation:
// 3000 = MMM as 1000 (M) + 1000 (M) + 1000 (M)
//  700 = DCC as 500 (D) + 100 (C) + 100 (C)
//   40 = XL as 10 (X) less of 50 (L)
//    9 = IX as 1 (I) less of 10 (X)
// Note: 49 is not 1 (I) less of 50 (L) because the conversion is based on decimal places

// Example 2:
// Input: num = 58
// Output: "LVIII"
// Explanation:
// 50 = L
//  8 = VIII

// Example 3:
// Input: num = 1994
// Output: "MCMXCIV"
// Explanation:
// 1000 = M
//  900 = CM
//   90 = XC
//    4 = IV

// Constraints:
//     1 <= num <= 3999

class Solution {
    func intToRoman(_ num: Int) -> String {
        var result = ""
        let ones = num%10
        let tens = num%100 - ones
        let hundreds = num%1000 - tens - ones
        let thousands = num - hundreds - tens - ones

        print(num)
        print(thousands)
        print(hundreds)
        print(tens)
        print(ones)

        for _ in 0..<(thousands/1000) {
            result = result + "M"
        }

        if hundreds == 900 {
            result = result + "CM"
        } else if hundreds >= 500 {
            result = result + "D"
            for _ in 0..<(hundreds-500)/100 {
                result = result + "C"
            }
        } else if hundreds == 400 {
            result = result + "CD"
        } else {
            for _ in 0..<(hundreds/100) {
                result = result + "C"
            }
        }

        if tens == 90 {
            result = result + "XC"
        } else if tens >= 50 {
            result = result + "L"
            for _ in 0..<(tens-50)/10 {
                result = result + "X"
            }
        } else if tens == 40 {
            result = result + "XL"
        } else {
            for _ in 0..<(tens/10) {
                result = result + "X"
            }
        }

        if ones == 9 {
            result = result + "IX"
        } else if ones >= 5 {
            result = result + "V"
            for _ in 0..<(ones-5) {
                result = result + "I"
            }
        } else if ones == 4 {
            result = result + "IV"
        } else {
            for _ in 0..<ones {
                result = result + "I"
            }
        }

        return result
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
        let num = 3749
        let expected = "MMMDCCXLIX"

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.intToRoman(num)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let num = 58
        let expected = "LVIII"

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.intToRoman(num)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let num = 1994
        let expected = "MCMXCIV"

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.intToRoman(num)
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

