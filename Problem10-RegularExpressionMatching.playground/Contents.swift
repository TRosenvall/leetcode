import Foundation
import XCTest

//10. Regular Expression Matching
//
//Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:
//
//    '.' Matches any single character.
//    '*' Matches zero or more of the preceding element.
//
//The matching should cover the entire input string (not partial).
//
// 
//
//Example 1:
//
//Input: s = "aa", p = "a"
//Output: false
//Explanation: "a" does not match the entire string "aa".
//
//Example 2:
//
//Input: s = "aa", p = "a*"
//Output: true
//Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
//
//Example 3:
//
//Input: s = "ab", p = ".*"
//Output: true
//Explanation: ".*" means "zero or more (*) of any character (.)".
//
// 
//
//Constraints:
//
//    1 <= s.length <= 20
//    1 <= p.length <= 20
//    s contains only lowercase English letters.
//    p contains only lowercase English letters, '.', and '*'.
//    It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.

class Solution {
//    func isMatch(_ s: String, _ p: String) -> Bool {
//        switch (p.contains("*"), p.contains(".")) {
//        case (false, false): return s == p
//        case (false, true):
//            let sArray = Array(s)
//            let pArray = Array(p)
//
//            // If the two strings aren't the same length, then it won't be a match.
//            if sArray.count != pArray.count {
//                return false
//            }
//
//            var indicies: [Int] = []
//            for (index, char) in pArray.enumerated() where char == "." {
//                indicies.append(index)
//            }
//
//            // Check that the whole string matches for each character except where the . is.
//            for i in 0..<sArray.count where !indicies.contains(i) {
//                return sArray[i] == pArray[i]
//            }
//
//            return false
//        case (true, false):
//            let pArray = Array(p)
//
//            var indicies: [Int] = []
//            for (index, char) in pArray.enumerated() where char == "*" {
//                indicies.append(index)
//            }
//
//            // Check that the string doesn't start with *
//            if indicies.contains(0) { return false }
//
//            // Check if the string contains **
//            for i in 0..<indicies.count-1 where indicies[i + 1] == indicies[i] + 1 {
//                return false
//            }
//
//            var startIndex = 0
//            var subArrays: [ArraySlice<Character>] = []
//            for i in indicies {
//                subArrays.append(pArray[startIndex...i])
//                if i+1 < pArray.count {
//                    startIndex = i+1
//                } else {
//                    
//                }
//            }
//            if !subArrays.contains(pArray[startIndex..<pArray.count]) {
//                subArrays.append(pArray[startIndex..<pArray.count])
//            }
//
//            // Check that the string matches up to the current char.
//            var sArray = Array(s)
//
//            var currentsIndex = 0
//            for subArray in subArrays.reversed() {
//                // Then it's the end of the string
//                if !subArray.contains("*") {
//                    for i in 0..<subArray.count {
//                        let reversedChar = subArray.reversed()[i]
//                        let reversedsChar = sArray.reversed()[i]
//                        if reversedChar == reversedsChar {
//                            sArray.remove(at: sArray.count-1-i)
//                        } else {
//                            return false
//                        }
//                    }
//                }
//                // If it does contain a *
//                if subArray.contains("*") {
//                    let priorChar = subArray[subArray.index(subArray.endIndex, offsetBy: -2)]
//
//                    while sArray.last == priorChar {
//                        sArray.remove(at: sArray.count - 1)
//                    }
//
//                    if subArray.count > 2 {
//                        for i in 0..<subArray.count-2 {
//                            let reversedSubArray = Array(subArray.reversed())
//                            let reversedSArray = Array(sArray.reversed())
//
//                            let reversedChar = reversedSubArray[i+2]
//                            let reversedsChar = reversedSArray[0]
//
//                            if reversedChar == reversedsChar {
//                                sArray.remove(at: sArray.count-1)
//                            } else {
//                                return false
//                            }
//                        }
//                    }
//                }
//
//                /// I might have a string something like "He*o Wor*d" in which case, I need to check both the e and the r. A matching case might be something like "Heeeeeeeeeeeeo Worrrrrrrrrrrrrd". In this case, I want to create substrings split by each index. So in this case, I'd have three substrings. "Heeeeeeeeeeee", "o Worrrrrrrrrrrrr", and "d". So in this case, I need to take the priorChar variable set to the character that will be repeated, and I need to match the characters up to the index for the split, and then ensure that only that character repeats. And pull the index for when that character stops repeating. Then I need to create a split there and repeat for the next one.
//                
//            }
//            return true
//        case (true, true): // At this point, I wasn't sure that any further time investment would have provided much additional benefit as I was relatively certain that this wasn't an efficient solution.
//            if p.first == "*" || p.first == "." { return false }
//            // This means a repeated character followed by a single random characters
//            if p.contains("*.") {
//                
//            }
//            // This means a set of repeated unknown characters
//            if p.contains(".*") {
//                
//            }
//            return false
//        }
//    }

    func isMatch(_ s: String, _ p: String) -> Bool {
        let sArray = Array(s)
        let pArray = Array(p)

        // Build out array
        var dp = Array(
            repeating: Array(repeating: false, count: pArray.count + 1),
            count: sArray.count + 1
        )

        // Empty string always matches
        dp[0][0] = true

        // Handles occurances where the pattern string starts with something like a* or b*c* or some such.
        for i in 1..<dp[0].count where pArray[i-1] == "*" {
            dp[0][i] = dp[0][i-2]
        }

        // Index from 1 to the count of the string we're checking, that lets us skip the first row, which was 
        // handled above, and this gives the total count of the sArray.
        for i in 1..<dp.count {
            // Index from 1 to the count of the pattern we're checking, this lets us skip the first column which
            // should all be false given that we're no longer working with an empty string if we're this far. This
            // also gives the total count of the pArray.
            for j in 1..<dp[i].count {
                // We check if we have a wild card or if the pattern matches the given array at this point.
                if pArray[j-1] == "." || pArray[j-1] == sArray[i-1] {
                    // If they do, then we set the value of the given element to it's upper left diagonal. This
                    // ensures that even if the conditions above are true, if the pattern hasn't matched at so far,
                    // we're excluding this index.
                    dp[i][j] = dp[i-1][j-1]
                } else if pArray[j-1] == "*" {
                    // First we update the given index to be the truth value two to the left. This is because the
                    // * may have 0 of the previous characters. So if two to the left is true, then this position
                    // will also be true.
                    dp[i][j] = dp[i][j-2]
                    // Then we check if we're hitting a wild card or if we're still tracking the same character as
                    // the last row. If we were had a true value before, then this value is still true.
                    if pArray[j-2] == "." || pArray[j-2] == sArray[i-1] {
                        // If either of the prior conditions were true, then this cell should remain true, otherwise
                        // it should stay false.
                        dp[i][j] = dp[i][j] || dp[i-1][j]
                    }
                }
            }
        }

        // If the pattern matches all the way through the string, then the bottom right most element will be true.
        return dp[sArray.count][pArray.count]
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
        let s = "aa"
        let p = "a"
        let expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isMatch(s, p)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "aa"
        let p = "a*"
        let expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isMatch(s, p)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "ab"
        let p = ".a"
        let expected = false

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isMatch(s, p)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 4:
    func testCase4() {
        let s = "Heeeeeeeeeeeeo Worrrrrrrrrrrrrd"
        let p = "He*o Wor*d"
        let expected = true

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.isMatch(s, p)
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

