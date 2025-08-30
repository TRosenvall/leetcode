import Foundation
import XCTest

// You are given an integer array height of length n. There are n vertical lines drawn such
// that the two endpoints of the ith line are (i, 0) and (i, height[i]).
//
// Find two lines that together with the x-axis form a container, such that the container
// contains the most water.
//
// Return the maximum amount of water a container can store.
//
// Notice that you may not slant the container.
//
// Example 1:
// Input: height = [1,8,6,2,5,4,8,3,7]
// Output: 49
// Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this
// case, the max area of water (blue section) the container can contain is 49.
//
// Example 2:
// Input: height = [1,1]
// Output: 1
//
// Constraints:
//    n == height.length
//    2 <= n <= 10^5
//    0 <= height[i] <= 10^4

class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var maxArea = 0

        var left = 0
        var right = height.count - 1

        // The two indices will approach each other, this ensures that the base length will be steadily getting
        // smaller which means the heights must only ever get bigger.
        while left < right {
            // Take the biggest max area between the current best and the new area whose height must be the smaller
            // of the left or right sides, lest water pour out.
            maxArea = max(maxArea, (right - left) * min(height[left], height[right]))

            // Depending on which side is smaller, we either move left or right
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }

        return maxArea
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
        let height = [1,8,6,2,5,4,8,3,7]
        let expected = 49

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.maxArea(height)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let height = [1,1]
        let expected = 1

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.maxArea(height)
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

