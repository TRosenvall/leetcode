import Foundation
import XCTest

//Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
//
//Notice that the solution set must not contain duplicate triplets.
//
// 
//
//Example 1:
//
//Input: nums = [-1,0,1,2,-1,-4]
//Output: [[-1,-1,2],[-1,0,1]]
//Explanation:
//nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
//nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
//nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
//The distinct triplets are [-1,0,1] and [-1,-1,2].
//Notice that the order of the output and the order of the triplets does not matter.
//
//Example 2:
//
//Input: nums = [0,1,1]
//Output: []
//Explanation: The only possible triplet does not sum up to 0.
//
//Example 3:
//
//Input: nums = [0,0,0]
//Output: [[0,0,0]]
//Explanation: The only possible triplet sums up to 0.
//
// 
//
//Constraints:
//
//    3 <= nums.length <= 3000
//    -105 <= nums[i] <= 105

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        if nums.count < 3 {
            return []
        }
        var nums = nums.sorted()
        var result: [[Int]] = []

        for i in 0..<nums.count-2 {
            if i > 0 && nums[i - 1] == nums[i] { continue }

            var left = i + 1
            var right = nums.count - 1

            while left < right {
                let sum = nums[i] + nums[left] + nums[right]

                if sum == 0 {
                    result.append([nums[i], nums[left], nums[right]])

                    while left < right && nums[left] == nums[left + 1] { left += 1 }
                    while left < right && nums[right] == nums[right - 1] { right -= 1 }

                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
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
        let nums = [-1,0,1,2,-1,-4]
        var expected: [[Int]] = [[-1,-1,2],[-1,0,1]]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSum(nums)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let nums = [0,1,1]
        var expected: [[Int]] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSum(nums)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let nums = [0,0,0]
        var expected: [[Int]] = [[0,0,0]]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSum(nums)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 4:
    func testCase4() {
        let nums = [1,-1,-1,0]
        var expected: [[Int]] = [[-1,0,1]]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSum(nums)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        expected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
        result = result.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }

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

