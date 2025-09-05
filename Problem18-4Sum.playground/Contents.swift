import Foundation
import XCTest

//Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:
//
//    0 <= a, b, c, d < n
//    a, b, c, and d are distinct.
//    nums[a] + nums[b] + nums[c] + nums[d] == target
//
//You may return the answer in any order.
//
// 
//
//Example 1:
//
//Input: nums = [1,0,-1,0,-2,2], target = 0
//Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
//
//Example 2:
//
//Input: nums = [2,2,2,2,2], target = 8
//Output: [[2,2,2,2]]
//
// 
//
//Constraints:
//
//    1 <= nums.length <= 200
//    -109 <= nums[i] <= 109
//    -109 <= target <= 109
//


class Solution {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var nums = nums.sorted()
        var result: [[Int]] = []

        for i in 0..<nums.count {
            if i > 0 && nums[i-1] == nums[i] { continue }

            var left = i+1
            var right = left+2

            while right < nums.count {
                var sum = 0
                for j in left+1..<right {
                    sum = nums[i] + nums[left] + nums[j] + nums[right]

                    if sum == target && !result.contains([nums[i], nums[left], nums[j], nums[right]]) {
                        result.append([nums[i], nums[left], nums[j], nums[right]])
                    }
                }

                if right < nums.count - 1 {
                    right += 1
                } else {
                    left += 1
                    right = left + 2
                }
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
        let nums = [1,0,-1,0,-2,2]
        let target = 0
        var expected = [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.fourSum(nums, target)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let nums = [2,2,2,2,2]
        let target = 8
        var expected = [[2,2,2,2]]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.fourSum(nums, target)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

//    /// Case 3:
//    func testCase3() {
//        let digits = "2"
//        var expected = ["a", "b", "c"]
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.letterCombinations(digits)
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        print(elapsedTime)
//        XCTAssertEqual(result, expected)
//    }

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

