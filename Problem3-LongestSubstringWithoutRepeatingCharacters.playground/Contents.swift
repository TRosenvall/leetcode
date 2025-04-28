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
//    /// Solution 1: - Brute Force Approach - This attempt works, but is very slow with a time complexity of O(n^3)
//    func lengthOfLongestSubstring(_ s: String) -> Int {
//        // Get all the substrings, regardless of duplicate characters
//        let substrings = getAllSubstring(s: s)
//        // Remove any substrings with duplicate characters
//        let cleanedSubstrings = discardStringsWithDuplicateChars(substrings: substrings)
//        // Find the longest substring
//        return getLongestSubstring(substrings: cleanedSubstrings)
//    }
//
//    func getAllSubstring(s: String) -> [String] {
//        var substrings: [String] = []
//        let stringArray = Array(s) // Convert the string to an array
//
//        // Add in every possible substring
//        for i in 0..<stringArray.count {
//            var knownChars: [Character] = []
//            for j in i..<stringArray.count
//            where !knownChars.contains(stringArray[j]) &&
//                  !substrings.contains(String(stringArray[i...j])) {
//                knownChars.append(stringArray[j])
//                substrings.append(String(stringArray[i...j]))
//            }
//        }
//
//        return substrings
//    }
//
//    func discardStringsWithDuplicateChars(substrings: [String]) -> [String] {
//        var cleanedSubstrings: [String] = []
//
//        // Sets don't have duplicates, arrays can. If the count of a set is the same as the count of an
//        // array, then there are no duplicates because no extra letters have been removed from the string.
//        for substring in substrings where Set(substring).count == Array(substring).count {
//            cleanedSubstrings.append(substring)
//        }
//
//        return cleanedSubstrings
//    }
//
//    func getLongestSubstring(substrings: [String]) -> Int {
//        var longestCount: Int = 0
//
//        for substring in substrings where substring.count > longestCount {
//            longestCount = substring.count
//        }
//
//        return longestCount
//    }

    /// Solution 2: - Sliding Window
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let stringArray = Array(s)
        var left: Int = 0
        var right: Int = 0
        var longestLength: Int = 0
        var characterProps: [Character: (count: Int, lastIndex: Int)] = [:]

        while right < stringArray.count {
            // Increase window size to the right
            let currentChar = stringArray[right]

            characterProps[currentChar] = (
                (characterProps[currentChar]?.count ?? 0) + 1,
                characterProps[currentChar]?.lastIndex ?? 0
            )
            
            // Decease window size from the left if needed
            if let lastIndex = characterProps[stringArray[right]]?.lastIndex,
               let charCount = characterProps[currentChar]?.count,
               charCount > 1 {
                let oldLeft = left
                left = lastIndex + 1 > left ? lastIndex + 1 : left + 1
                for i in oldLeft..<left {
                    let tempChar = stringArray[i]
                    characterProps[tempChar] = (
                        (characterProps[tempChar]?.count ?? 2) - 1,
                        characterProps[tempChar]?.lastIndex ?? 0
                    )
                }
            }

            // Set lastKnownIndex and longestLength and the right value
            characterProps[currentChar] = ((characterProps[currentChar]?.count ?? 0), right)
            longestLength = max(longestLength, right - left + 1)
            right += 1
        }

        return longestLength
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

    /// Case 8
    func testCase8() {
        let s = "cdd"
        let expected = 2
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 9
    func testCase9() {
        let s = "tmmzuxt"
        let expected = 5
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 10
    func testCase10() {
        let s = "ohomm"
        let expected = 3
        XCTAssertEqual(solution.lengthOfLongestSubstring(s), expected)
    }

    /// Case 11
    func testCase11() {
        let s = "abba"
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

