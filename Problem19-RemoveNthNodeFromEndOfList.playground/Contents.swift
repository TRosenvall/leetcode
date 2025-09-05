import Foundation
import XCTest

//Given the head of a linked list, remove the nth node from the end of the list and return its head.
//
// 1 -> 2 -> 3 -> 4 -> 5
//           |
// 1 -> 2 -> 3 -> -> -> 5
//
//Example 1:
//
//Input: head = [1,2,3,4,5], n = 2
//Output: [1,2,3,5]
//
//Example 2:
//
//Input: head = [1], n = 1
//Output: []
//
//Example 3:
//
//Input: head = [1,2], n = 1
//Output: [1]
//
// 
//
//Constraints:
//
//    The number of nodes in the list is sz.
//    1 <= sz <= 30
//    0 <= Node.val <= 100
//    1 <= n <= sz
//
// 
//
//Follow up: Could you do this in one pass?


/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    convenience init(_ vals: [Int]) {
        let reversed = vals.reversed()
        var last: ListNode?
        for i in reversed {
            let node = ListNode(i)
            node.next = last
            last = node
        }
        self.init(last!.val, last!.next)
    }
}

extension Optional<ListNode> {
    func toArray() -> [Int] {
        var result: [Int] = []
        if let self {
            var curr: ListNode? = self
            while curr != nil {
                result.append(curr!.val)
                curr = curr?.next
            }
            return result
        } else {
            return []
        }
    }
}

class Solution {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let count = head.toArray().count
        if count == 0 || count == 1 { return nil }

        var index = count - n - 1
        var curr: ListNode? = head

        if index >= 0 {
            for _ in 0..<index {
                curr = curr?.next
            }
        } else {
            return head?.next
        }

        curr?.next = curr?.next?.next

        return head
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
        let head = [1,2,3,4,5]
        let n = 2
        var expected = [1,2,3,5]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.removeNthFromEnd(ListNode(head), n)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 2:
    func testCase2() {
        let head = [1]
        let n = 1
        var expected: [Int] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.removeNthFromEnd(ListNode(head), n)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 3:
    func testCase3() {
        let head = [1,2]
        let n = 1
        var expected: [Int] = [1]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.removeNthFromEnd(ListNode(head), n)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
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

