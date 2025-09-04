import Foundation
import XCTest

//Write a function to find the longest common prefix string amongst an array of strings.
//
//If there is no common prefix, return an empty string "".
//
// 
//
//Example 1:
//
//Input: strs = ["flower","flow","flight"]
//Output: "fl"
//
//Example 2:
//
//Input: strs = ["dog","racecar","car"]
//Output: ""
//Explanation: There is no common prefix among the input strings.
//
// 
//
//Constraints:
//
//    1 <= strs.length <= 200
//    0 <= strs[i].length <= 200
//    strs[i] consists of only lowercase English letters if it is non-empty.

class Solution {
//    func longestCommonPrefix(_ strs: [String]) -> String {
//        let strs = strs.sorted { string1, string2 in
//            return string1.count < string2.count
//        }
//        var result = ""
//        var i = 0 // Index for the character of the first word
//        if var firstWord = strs.first, firstWord.count > 0 {
//            while i < strs[0].count {
//                result += String(Array(firstWord)[i])
//                var shouldBreak = false
//                for str in strs where !(result.last == Array(str)[i]) {
//                    shouldBreak = true
//                    break
//                }
//                if shouldBreak {
//                    result.removeLast()
//                    break
//                }
//                i += 1
//            }
//        } else {
//            return ""
//        }
//        return result
//    }

    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 1 else {
            return strs.first ?? ""
        }
        
        var common: String = strs[0]
        for string in strs {
            while string.hasPrefix(common) == false {
                common = String(common.dropLast())
            }
        }
        
        return common
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
        let strs = ["flower","flow","flight"]
        let expected = "fl"

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.longestCommonPrefix(strs)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let strs = ["dog","racecar","car"]
        let expected = ""

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.longestCommonPrefix(strs)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

//    /// Case 3:
//    func testCase3() {
//        let s = "MCMXCIV"
//        let expected = 1994
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        let result = solution.romanToInt(s)
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        print(elapsedTime)
//        XCTAssertEqual(result, expected)
//    }
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

