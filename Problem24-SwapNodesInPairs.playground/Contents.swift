import Foundation
import XCTest

//Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)
//
// 
//
//Example 1:
//
//Input: head = [1,2,3,4]
//
//Output: [2,1,4,3]
//
//Explanation:
//
//Example 2:
//
//Input: head = []
//
//Output: []
//
//Example 3:
//
//Input: head = [1]
//
//Output: [1]
//
//Example 4:
//
//Input: head = [1,2,3]
//
//Output: [2,1,3]
//
// 
//
//Constraints:
//
//    The number of nodes in the list is in the range [0, 100].
//    0 <= Node.val <= 100
//

/// Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode {
    convenience init?(_ vals: [Int]) {
        let reversed = vals.reversed()
        var last: ListNode?
        for i in reversed {
            let node = ListNode(i)
            node.next = last
            last = node
        }
        if let val = last?.val {
            self.init(val, last!.next)
        } else {
            return nil
        }
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
    func swapPairs(_ head: ListNode?) -> ListNode? {
        var head = head
        if head == nil {
            return nil
        }
        if head?.next == nil {
            return head
        }
        let result = head?.next

        var tail = head?.next
        var lastPair = head
        while tail != nil {
            let temp = tail?.next
            lastPair?.next = tail
            tail?.next = head
            head?.next = temp
            lastPair = head
            head = temp
            tail = head?.next
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

    // MARK: - Test Cases

    /// Case 1:
    func testCase1() {
        let head = [1,2,3,4]
        var expected = [2,1,4,3]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.swapPairs(.init(head))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 2:
    func testCase2() {
        let head: [Int] = []
        var expected: [Int] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.swapPairs(.init(head))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 3:
    func testCase3() {
        let head: [Int] = [1]
        var expected: [Int] = [1]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.swapPairs(.init(head))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 4:
    func testCase4() {
        let head: [Int] = [1,2,3]
        var expected: [Int] = [2,1,3]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.swapPairs(.init(head))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

//    /// Case 5:
//    func testCase5() {
//        let s = "([)]"
//        var expected = false
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.isValid(s)
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
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

