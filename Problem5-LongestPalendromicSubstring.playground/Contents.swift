import Foundation
import XCTest

/// Given a string s, return the longest in s.
///
/// Example 1:
///
/// Input: s = "babad"
/// Output: "bab"
/// Explanation: "aba" is also a valid answer.
///
/// Example 2:
///
/// Input: s = "cbbd"
/// Output: "bb"
///
/// Constraints:
///    1 <= s.length <= 1000
///    s consist of only digits and English letters.

class Solution {
//    /// Solution 1: - Brute force by center expansion
//    func longestPalindrome(_ s: String) -> String {
//        // If the string is empty or has only one character, simply return the
//        // string.
//        if s.count == 0 || s.count == 1 {
//            return s
//        }
//
//        let stringArray = Array(s)
//        var longestPalindrome: String = ""
//
//        // Handle Odd Palindromes
//        for i in 0..<stringArray.count {
//            var left = i
//            var right = i
//
//            // This isn't particularly elegant, but this is a brute force solution
//            if stringArray[left] == stringArray[right] {
//                while left >= 0,
//                      right < stringArray.count {
//                    left -= 1
//                    right += 1
//
//                    // Decrement if we're no longer a palindrom
//                    if left < 0 ||
//                       right >= stringArray.count ||
//                       stringArray[left] != stringArray[right] {
//                        left += 1
//                        right -= 1
//                        break
//                    }
//                }
//            }
//
//            if right-left > longestPalindrome.count,
//               stringArray[left] == stringArray[right] {
//                longestPalindrome = String(stringArray[left...right])
//            }
//        }
//
//        // Handle Even Palindromes
//        for i in 0..<stringArray.count - 1 {
//            var left = i
//            var right = i + 1
//
//            // This isn't particularly elegant, but this is a brute force solution
//            if stringArray[left] == stringArray[right] {
//                while left >= 0,
//                      right < stringArray.count {
//                    left -= 1
//                    right += 1
//
//                    // Decrement if we're no longer a palindrom
//                    if left < 0 ||
//                       right >= stringArray.count ||
//                       stringArray[left] != stringArray[right] {
//                        left += 1
//                        right -= 1
//                        break
//                    }
//                }
//            }
//
//            if right-left > longestPalindrome.count - 1,
//               stringArray[left] == stringArray[right] {
//                longestPalindrome = String(stringArray[left...right])
//            }
//        }
//
//        // If no palindrome was found, then the first character should be used
//        if longestPalindrome.count == 0 {
//            return String(stringArray[0])
//        }
//
//        return longestPalindrome
//    }

    /// Solution 2: - Manacher’s Algorithm - Found this after I built my solution.
    func longestPalindrome(_ s: String) -> String {
        // Preprocess the string to make them all odd palindromes
        let preprocessedString = "^#" + s.map { String($0) }.joined(separator: "#") + "#$"
        let stringArray = Array(preprocessedString)
        let n = stringArray.count
        var palindromeRadii = Array(repeating: 0, count: n)
        var center = 0
        var right = 0

        // Expand around the palindrome centers
        for i in 1..<n-1 {
            let mirror = 2 * center - i // Mirror the index around i

            if i < right {
                palindromeRadii[i] = min(right - i, palindromeRadii[mirror])
            }

            // Try to expand the palindrome centered at i
            while stringArray[i + palindromeRadii[i] + 1] ==
                  stringArray[i - palindromeRadii[i] - 1] {
                palindromeRadii[i] += 1
            }

            // If the palindrome expands past the right boundary, update the center
            // and the right values
            if i + palindromeRadii[i] > right {
                center = i
                right = i + palindromeRadii[i]
            }
        }

        // Pull the longest palindrom out of p
        var maxLen = 0
        var centerIndex = 0
        for i in 1..<n-1 where palindromeRadii[i] > maxLen {
            maxLen = palindromeRadii[i]
            centerIndex = i
        }

        // Extract the longest palindrome from the original string
        let startIndex = s.index(
            s.startIndex,
            offsetBy: (centerIndex - maxLen)/2
        )
        let endIndex = s.index(startIndex, offsetBy: maxLen)
        return String(s[startIndex..<endIndex])
    }
}

/// Test Cases
class LongestPalendromicSubstringTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let s = "babad"
        let expected = "bab" // "aba" could work also, but I'll stick with this for now.
        XCTAssertEqual(solution.longestPalindrome(s), expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "cbbd"
        let expected = "bb"
        XCTAssertEqual(solution.longestPalindrome(s), expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "a"
        let expected = "a"
        XCTAssertEqual(solution.longestPalindrome(s), expected)
    }

    /// Case 4:
    func testCase4() {
        let s = "ac"
        let expected = "a"
        XCTAssertEqual(solution.longestPalindrome(s), expected)
    }

    /// Case 5:
    func testCase5() {
        let s = "abb"
        let expected = "bb"
        XCTAssertEqual(solution.longestPalindrome(s), expected)
    }

    /// Case 6:
    func testCase6() {
        let s = "aaaa"
        let expected = "aaaa"
        XCTAssertEqual(solution.longestPalindrome(s), expected)
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

TestRunner().runTests(testClass: LongestPalendromicSubstringTestCases.self)

