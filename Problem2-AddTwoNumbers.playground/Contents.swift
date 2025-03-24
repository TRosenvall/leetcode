import Foundation
import XCTest

/// You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each
/// of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
/// You may assume the two numbers do not contain any leading zero, except the number 0 itself.

/// Example 1:
/// Input: l1 = [2,4,3], l2 = [5,6,4]
/// Output: [7,0,8]
/// Explanation: 342 + 465 = 807.

/// Example 2:
/// Input: l1 = [0], l2 = [0]
/// Output: [0]

/// Example 3:
/// Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
/// Output: [8,9,9,9,0,0,0,1]

/// Constraints:
///    The number of nodes in each linked list is in the range [1, 100].
///    0 <= Node.val <= 9
///    It is guaranteed that the list represents a number that does not have leading zeros.

/// Definition for singly-linked list.
public class ListNode: Equatable {

    // MARK: - Properties

    public var val: Int
    public var next: ListNode?

    // MARK: - Lifecycle

    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

    // MARK: - Conformance: Equatable

    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.val == rhs.val && lhs.next == rhs.next
    }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        addTwoRecurse(l1, l2)
    }

    private func addTwoRecurse(_ l1: ListNode?, _ l2: ListNode?, carryOver: Int = 0) -> ListNode? {
        var nextValue = carryOver // Holder for the next node value
        if let l1 { // Depending on l1, l2, add to the value
            nextValue += l1.val
            if let l2 {
                nextValue += l2.val
            }
        } else if let l2 {
            nextValue += l2.val
        }

        let nextCarry = nextValue / 10 // The new value is module, the new carry is a division
        if l1?.next != nil || l2?.next != nil || nextCarry > 0 { // Params for recrusion
            return ListNode(
                nextValue % 10,
                addTwoRecurse(l1?.next, l2?.next, carryOver: nextCarry)
            )
        }
        return ListNode(
            nextValue % 10
        )
    }
}

/// Test Cases
class AddTwoNumbersTestCases: XCTestCase {

    // MARK: - Properties

    var solution: Solution!

    // MARK: - Setup

    override func setUp() async throws {
        solution = Solution()
    }

    // MARK: = Test Cases

    /// Case 1:
    func testCase1() {
        let l1 = ListNode(2, ListNode(4, ListNode(3)))
        let l2 = ListNode(5, ListNode(6, ListNode(4)))
        let expected = ListNode(7, ListNode(0, ListNode(8)))
        XCTAssertEqual(solution.addTwoNumbers(l1, l2), expected)
    }

    /// Case 2:
    func testCase2() {
        let l1 = ListNode(0)
        let l2 = ListNode(0)
        let expected = ListNode(0)
        XCTAssertEqual(solution.addTwoNumbers(l1, l2), expected)
    }

    /// Case 3:
    func testCase3() {
        let l1 = ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9, ListNode(9)))))))
        let l2 = ListNode(9, ListNode(9, ListNode(9, ListNode(9))))
        let expected = ListNode(8, ListNode(9, ListNode(9, ListNode(9, ListNode(0, ListNode(0, ListNode(0, ListNode(1))))))))
        XCTAssertEqual(solution.addTwoNumbers(l1, l2), expected)
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

TestRunner().runTests(testClass: AddTwoNumbersTestCases.self)
