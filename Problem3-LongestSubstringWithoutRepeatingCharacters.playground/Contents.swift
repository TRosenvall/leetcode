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
        // Get all the substrings, regardless of duplicate characters
        let substrings = getAllSubstring(s: s)
        // Remove any substrings with duplicate characters
        let cleanedSubstrings = discardStringsWithDuplicateChars(substrings: substrings)
        // Find the longest substring
        return getLongestSubstring(substrings: cleanedSubstrings)
    }

    func getAllSubstring(s: String) -> [String] {
        var substrings: [String] = []
        let stringArray = Array(s) // Convert the string to an array
        var lastKnownIndex: [Character: Int] = [:]

        // Iterate through the length of the string array plus one to account for the end of the string
        for i in 0...stringArray.count {
            // If we're less than the total count, then we're still parsing the string and not at the end 
            // yet. Otherwise, we're out of the string and need to get potential substrings that might
            // end with the end of the string.
            if i < stringArray.count {
                // If we have a last index oc the current character recorded, then we can get a
                // substring from the last known index to the current index. Otherwise we need to pull out
                // a substring from the beginning of the array to the current index to account for
                // potential substrings that might occur from the beginning of the array.
                if let lastIndex = lastKnownIndex[stringArray[i]] {
                    substrings.append(String(stringArray[lastIndex..<i]))
                } else {
                    substrings.append(String(stringArray[0..<i]))
                }

                // We need to then update the lastKnownIndex with the current index.
                lastKnownIndex[stringArray[i]] = i
            } else {
                // Record any substring that might end with the end of the string.
                lastKnownIndex.forEach { (_, lastIndex) in
                    substrings.append(String(stringArray[lastIndex..<stringArray.count]))
                }
            }
        }

        return substrings
    }

    func discardStringsWithDuplicateChars(substrings: [String]) -> [String] {
        var cleanedSubstrings: [String] = []

        // Sets don't have duplicates, arrays can. If the count of a set is the same as the count of an
        // array, then there are no duplicates because no extra letters have been removed from the string.
        for substring in substrings where Set(substring).count == Array(substring).count {
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

