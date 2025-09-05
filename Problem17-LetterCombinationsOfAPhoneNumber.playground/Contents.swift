import Foundation
import XCTest

//Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.
//
//A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.
//
// 1 --- 2 abc 3 def
// 4 hij 5 klm 6 nop
// 7 qrs 8 tuv 9 wxyz
// *  +  0  _  ^  #
//
//Example 1:
//
//Input: digits = "23"
//Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]
//
//Example 2:
//
//Input: digits = ""
//Output: []
//
//Example 3:
//
//Input: digits = "2"
//Output: ["a","b","c"]
//
// 
//
//Constraints:
//
//    0 <= digits.length <= 4
//    digits[i] is a digit in the range ['2', '9'].
//

class Solution {
    var numMap: [Character: [String]] {
        return [
            "2": ["a", "b", "c"],
            "3": ["d", "e", "f"],
            "4": ["g", "h", "i"],
            "5": ["j", "k", "l"],
            "6": ["m", "n", "o"],
            "7": ["p", "q", "r", "s"],
            "8": ["t", "u", "v"],
            "9": ["w", "x", "y", "z"]
        ]
    }

    func letterCombinations(_ digits: String) -> [String] {
        let digits = Array(digits)
        var letters: [[String]] = {
            var letters: [[String]] = []
            for digit in digits {
                letters.append(numMap[digit]!)
            }
            return letters
        }()
        var combined: [String] = letters.flatMap { $0 }
        var result: [String] = []

        if letters.count == 0 {
            return []
        } else {
            shouldLoop(for: letters, iterators: [], combined: combined, result: &result)
        }

        return result
    }

    func shouldLoop(for letters: [[String]], iterators: [Int], combined: [String], result: inout [String]) {
        if iterators.count < letters.count {
            for i in 0..<letters[iterators.count].count {
                shouldLoop(
                    for: letters,
                    iterators: iterators + [i],
                    combined: combined,
                    result: &result
                )
            }
        } else {
            var indicies: [Int] = []
            var counts: [Int] = []
            for i in 0..<iterators.count-1 {
                counts.append(letters[i].count)
            }

            for i in 0..<iterators.count {
                let iterator = iterators[i]
                let countsNeeded = i
                var sum = iterator
                for i in 0..<countsNeeded {
                    sum += counts[i]
                }
                indicies.append(sum)
            }

            var string = ""
            for i in indicies {
                string += combined[i]
            }

            result.append(
              string
            )
        }
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
        let digits = "23"
        var expected = ["ad","ae","af","bd","be","bf","cd","ce","cf"]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.letterCombinations(digits)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let digits = ""
        var expected: [String] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.letterCombinations(digits)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let digits = "2"
        var expected = ["a", "b", "c"]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.letterCombinations(digits)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

//    /// Case 4:
//    func testCase4() {
//        let nums = [1,-1,-1,0]
//        var expected: [[Int]] = [[-1,0,1]]
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.threeSum(nums)
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
//        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
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

