import Foundation
import XCTest

/// Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the
/// two sorted arrays.
///
/// The overall run time complexity should be O(log (m+n)).
///
/// Example 1:
///
/// Input: nums1 = [1,3], nums2 = [2]
/// Output: 2.00000
/// Explanation: merged array = [1,2,3] and median is 2.
///
/// Example 2:
///
/// Input: nums1 = [1,2], nums2 = [3,4]
/// Output: 2.50000
/// Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
///
/// Constraints:
///    nums1.length == m
///    nums2.length == n
///    0 <= m <= 1000
///    0 <= n <= 1000
///    1 <= m + n <= 2000
///    -106 <= nums1[i], nums2[i] <= 106

class Solution {
    /// Solution 1: - Brute force
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // We combine and sort the arrays
        let combineArray = nums1 + nums2
        let sorted = combineArray.sorted()
        // Then in order to get the median, we need to either find the average of the two middle values
        // if the array has an even number of elements, or we need to just take the middle value if the
        // array has an odd number of elements.
        //
        // Odd Count Examples
        // If array.count = 1, then we have elements: 0, and we need to pull element 0, which is 
        // (1 - 1)/2 = 0/2 = 0. The divided by two will help us in a moment
        // If array.count = 3, then we have elements: 0, 1, 2, and we need to pull element 1, which is
        // (3 - 1)/2 = 2/2 = 1.
        // If array.count = 5, then we have elements 0, 1, 2, 3, 4, and we need to pull element 2, which is
        // (5 - 1)/2 = 4/2 = 2
        // So the pattern for odd elements wold appear to be (n - 1)/2 to get the middle element.
        //
        // Even Count Examples
        // If array.count = 2, then we have elements: 0, 1, and we need to pull elements 0, 1 which is
        // (2/2 - 1) = (1 - 1) = 0, and (2/2) = 1 so that gives us our elements.
        // If array.count = 4, then we have elements: 0, 1, 2, 3, and we need to pull elements 1, 2, which
        // is (4/2 - 1) = (2 - 1) = 1, and (4/4) = 2.
        // If array.count = 6, then we have elements: 0, 1, 2, 3, 4, 5, and we need to pull elements 2, 3,
        // which is (6/2 - 1) = (3 - 1) = 2, and (6/2) = 3.
        // So the pattern for even elements would appear to be (n - 1)/2 and (n/2) for our two elements.
        let middleElements = sorted.count % 2 == 0 ? [
            sorted[sorted.count/2 - 1],
            sorted[sorted.count/2]
        ] : [
            sorted[(sorted.count - 1)/2]
        ]
        // Then we take the sum of the elements, if it's a single element, this simply returns the value, 
        // otherwsie we get the sum of the two elements.
        let sum = middleElements.reduce(0, +)
        // And we return the average, I hate to typecast it as it's an expensive operation, but there isn't
        // a much better way of doing this.
        return Double(sum) / Double(middleElements.count)
    }
}

/// Test Cases
class MedianOfTwoSortedArraysTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let nums1 = [1, 3]
        let nums2 = [2]
        let expected = 2.0
        XCTAssertEqual(solution.findMedianSortedArrays(nums1, nums2), expected)
    }

    /// Case 2:
    func testCase2() {
        let nums1 = [1, 3]
        let nums2 = [2, 4]
        let expected = 2.5
        XCTAssertEqual(solution.findMedianSortedArrays(nums1, nums2), expected)
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

TestRunner().runTests(testClass: MedianOfTwoSortedArraysTestCases.self)

