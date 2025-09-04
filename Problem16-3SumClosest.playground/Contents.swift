import Foundation
import XCTest

//Given an integer array nums of length n and an integer target, find three integers in nums such that the sum is closest to target.
//
//Return the sum of the three integers.
//
//You may assume that each input would have exactly one solution.
//
// 
//
//Example 1:
//
//Input: nums = [-1,2,1,-4], target = 1
//Output: 2
//Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
//
//Example 2:
//
//Input: nums = [0,0,0], target = 1
//Output: 0
//Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).
//
// 
//
//Constraints:
//
//    3 <= nums.length <= 500
//    -1000 <= nums[i] <= 1000
//    -104 <= target <= 104
//


class Solution {
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        if nums.count < 3 {
            return 0
        }
        var nums = nums.sorted()
        var difference: Int = 10 * 10 * 10 * 10 * 10

        for i in 0..<nums.count-2 {
            if i > 0 && nums[i - 1] == nums[i] { continue }

            var left = i + 1
            var right = nums.count - 1

            while left < right {

                print("i: \(i), \(nums[i])")
                print("left: \(left), \(nums[left])")
                print("right: \(right), \(nums[right])")

                let sum = nums[i] + nums[left] + nums[right]

                if sum - target == 0 {
                    return sum
                }

                if abs(sum - target) < abs(difference) {
                    difference = sum - target
                }

                if sum - target < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }

        return target + difference
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
        let nums = [-1,2,1,-4]
        let target = 1
        var expected = 2

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSumClosest(nums, target)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let nums = [0,0,0]
        let target = 1
        var expected = 0

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSumClosest(nums, target)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let nums = [10,20,30,40,50,60,70,80,90]
        let target = 1
        var expected = 60

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.threeSumClosest(nums, target)
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

