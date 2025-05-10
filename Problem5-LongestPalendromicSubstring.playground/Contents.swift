import Foundation
import XCTest

/// The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to
/// display this pattern in a fixed font for better legibility)
///
/// P   A   H   N
/// A P L S I I G
/// Y   I   R
///
/// And then read line by line: "PAHNAPLSIIGYIR"
///
/// Write the code that will take a string and make this conversion given a number of rows:
///
/// string convert(string s, int numRows);
///
/// Example 1:
///
/// Input: s = "PAYPALISHIRING", numRows = 3
/// Output: "PAHNAPLSIIGYIR"
///
/// Example 2:
///
/// Input: s = "PAYPALISHIRING", numRows = 4
/// Output: "PINALSIGYAHRPI"
/// Explanation:
/// P           I            N
///  A      L  S       I    G
///   Y  A     H  R
///    P          I
///
///
/// Example 3:
///
/// Input: s = "A", numRows = 1
/// Output: "A"
///
/// Constraints:
///
///    1 <= s.length <= 1000
///    s consists of English letters (lower-case and upper-case), ',' and '.'.
///    1 <= numRows <= 1000

class Solution {
    /// Solution 1: - Brute force
    func convert(_ s: String, _ numRows: Int) -> String {
        // If the string has 0 or 1 characters, return itself.
        if s.count <= numRows || numRows <= 1 {
            return s
        }

        // Create a type for handling 2d points using integer positions
        typealias Point = (x: Int, y: Int)
        var twoDimMappingArray: [Point] = []

        // Iterate through the string
        for i in 0..<s.count {
            // This is the period over which we'll be zigzagging our string
            let period = 2 * (numRows - 1)
            let mod = i % period

            // Here we can use i as the x position, moving right as we zigzag, the y
            // value will be moving up and down as we go along.
            twoDimMappingArray.append(
                (
                    x: i,
                    y: mod < numRows ?
                       mod :
                       period - mod
                )
            )
        }

        var returnString: [Character] = []
        // Here we sort by the y values to collect all the terms on the top row by
        // themselves, then each row moving down in order.
        for point in twoDimMappingArray.enumerated().sorted(by: { (point1, point2) in
            return point1.element.y < point2.element.y
        }){
            // We then gather the characters of the string by the x position based on
            // the newly sorted array
            returnString.append(Array(s)[point.element.x])
        }

        return String(returnString)
    }
}

/// Test Cases
class ZigZagConversionTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let s = "PAYPALISHIRING"
        let numRows = 3
        let expected = "PAHNAPLSIIGYIR"
        XCTAssertEqual(solution.convert(s, numRows), expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "PAYPALISHIRING"
        let numRows = 4
        let expected = "PINALSIGYAHRPI"
        XCTAssertEqual(solution.convert(s, numRows), expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "A"
        let numRows = 1
        let expected = "A"
        XCTAssertEqual(solution.convert(s, numRows), expected)
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

TestRunner().runTests(testClass: ZigZagConversionTestCases.self)

