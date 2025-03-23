import Foundation
import XCTest

/// Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
/// You may assume that each input would have exactly one solution, and you may not use the same element twice.
/// You can return the answer in any order.

/// Example 1:

/// Input: nums = [2,7,11,15], target = 9
/// Output: [0,1]
/// Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

/// Example 2:
/// Input: nums = [3,2,4], target = 6
/// Output: [1,2]

/// Example 3:
/// Input: nums = [3,3], target = 6
/// Output: [0,1]

/// Constraints:
///    2 <= nums.length <= 104
///    -109 <= nums[i] <= 109
///    -109 <= target <= 109
///    Only one valid answer exists.

/// Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?

/// My Solution 1
class Solution {
//    /// My First Solution - Only works for adjacent indicies
//    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
//        var first: Int                              // Setup a holder for the first index
//        for i in 1..<nums.count {                   // Loop through the total count of the passed in array
//            first = i-1                             // Set the index of the first number to use
//            if nums[first] + nums[i] == target {    // Run comparison
//                return [first, i]                   // Return working pair of indicies
//            }
//        }
//        return []                                   // If no pair of indicies works as a solution, return empty array.
//    }

//    /// My Second Solution - O(n^2) Time
//    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
//        for i in 0..<nums.count-1 {                     // Loop through the total count of the passed in array less 1
//            for j in i+1..<nums.count {                 // Second loop adjusted forward by 1 index
//                if nums[i] + nums[j] == target {        // Run comparison
//                    return [i, j]                       // Return working pair of indicies
//                }
//            }
//        }
//        return []                                       // If no pair of indicies works as a solution, return empty array.
//    }

    /// My third solution - O(n) Time
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var seen: [Int: Int] = [:]                  // Dictionary to store number and its index

        for (i, num) in nums.enumerated() {         // Iterate through the indicies and numbers together
            let complement = target - num           // The complement is the missing number needed to reach the target
            if let index = seen[complement] {       // Lookup the number in the dictionary - lookup time ~ O(1)
                return [index, i]                   // Found a pair if the complement has been seen
            }
            seen[num] = i                           // Otherwise store index of the current number
        }

        return []                                   // Return if no paris found
    }
}

/// Test Cases
class TwoSumTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let nums = [2,7,11,15]
        let target = 9
        let expected = [0, 1]
        XCTAssertEqual(solution.twoSum(nums, target), expected)
    }

    /// Case 2:
    func testCase2() {
        let nums = [3,2,4]
        let target = 6
        let expected = [1, 2]
        XCTAssertEqual(solution.twoSum(nums, target), expected)
    }

    /// Case 3:
    func testCase3() {
        let nums = [3,3]
        let target = 6
        let expected = [0, 1]
        XCTAssertEqual(solution.twoSum(nums, target), expected)
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

TestRunner().runTests(testClass: TwoSumTestCases.self)
