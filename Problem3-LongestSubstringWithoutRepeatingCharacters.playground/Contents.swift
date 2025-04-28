import Foundation
import XCTest

/// Given a string s, find the length of the longest substring
/// without duplicate characters.

/// Example 1:
/// Input: s = "abcabcbb"
/// Output: 3
/// Explanation: The answer is "abc", with the length of 3.

/// Example 2:
/// Input: s = "bbbbb"
/// Output: 1
/// Explanation: The answer is "b", with the length of 1.

/// Example 3:
/// Input: s = "pwwkew"
/// Output: 3
/// Explanation: The answer is "wke", with the length of 3.
/// Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

/// Constraints:
///    0 <= s.length <= 5 * 104
///    s consists of English letters, digits, symbols and spaces.

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let substrings = getAllSubstring(s: s)
        let cleanedSubstrings = discardStringsWithDuplicateChars(substrings: substrings)
        return getLongestSubstring(substrings: cleanedSubstrings)
    }

    func getAllSubstring(s: String) -> [String] {
        var substrings: [String] = []
        let stringArray = Array(s)
        var lastKnownIndex: [Character: Int] = [:]

        for i in 0...stringArray.count {
            if i < stringArray.count {
                if let lastIndex = lastKnownIndex[stringArray[i]] {
                    substrings.append(String(stringArray[lastIndex..<i]))
                }
                
                lastKnownIndex[stringArray[i]] = i
            } else {
                lastKnownIndex.forEach { (char, lastIndex) in
                    substrings.append(String(stringArray[lastIndex..<stringArray.count]))
                }
            }
        }

        return substrings
    }

    func discardStringsWithDuplicateChars(substrings: [String]) -> [String] {
        var cleanedSubstrings: [String] = []

        for substring in substrings where Set(Array(substring)).count == Array(substring).count {
            cleanedSubstrings.append(substring)
        }

        return cleanedSubstrings
    }

    func getLongestSubstring(substrings: [String]) -> Int {
        var longestCount: Int = 0

        for substring in substrings where substring.count > longestCount {
            longestCount = substring.count
        }

        return longestCount
    }
}

/// Test Cases
class LongestSubstringWithoutRepeatingCharactersTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let s = "abcabcbb"
        let expected = 3
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "bbbbb"
        let expected = 1
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "pwwkew"
        let expected = 3
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 4
    func testCase4() {
        let s = " "
        let expected = 1
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 5
    func testCase5() {
        let s = ""
        let expected = 0
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 6
    func testCase6() {
        let s = "au"
        let expected = 2
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 7
    func testCase7() {
        let s = "aab"
        let expected = 2
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
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

TestRunner().runTests(testClass: LongestSubstringWithoutRepeatingCharactersTestCases.self)

