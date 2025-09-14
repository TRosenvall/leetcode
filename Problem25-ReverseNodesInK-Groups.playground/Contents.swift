import Foundation
import XCTest

//Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.
//
//k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.
//
//You may not alter the values in the list's nodes, only nodes themselves may be changed.
//
// 
//
//Example 1:
//
//Input: head = [1,2,3,4,5], k = 2
//Output: [2,1,4,3,5]
//
//Example 2:
//
//Input: head = [1,2,3,4,5], k = 3
//Output: [3,2,1,4,5]
//
// 
//
//Constraints:
//
//    The number of nodes in the list is n.
//    1 <= k <= n <= 5000
//    0 <= Node.val <= 1000
//
// 
//
//Follow-up: Can you solve the problem in O(1) extra memory space?

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
    func loops() -> Bool {
        var slow = self
        var fast = self
        
        while let f = fast, let nextFast = f.next {
            slow = slow?.next
            fast = nextFast.next
            
            if slow === fast {
                return true
            }
        }
        
        return false
    }

    func toArray() -> [Int] {
        var result: [Int] = []
        if let self {
            var curr: ListNode? = self
            while curr != nil && !curr.loops() {
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
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var node = head
        for _ in 0..<k {
            if node == nil { return head }
            node = node?.next
        }

        var prev: ListNode? = nil
        var curr = head
        var count = 0

        while count < k, let current = curr {
            let next = current.next
            current.next = prev
            prev = current
            curr = next
            count += 1
        }

        head?.next = reverseKGroup(curr, k)

        return prev
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
        let head = [1,2,3,4,5]
        let k = 2
        var expected = [2,1,4,3,5]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.reverseKGroup(ListNode(head), k)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 2:
    func testCase2() {
        let head = [1,2,3,4,5]
        let k = 3
        var expected = [3,2,1,4,5]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.reverseKGroup(ListNode(head), k)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 3:
    func testCase3() {
        let head = [1,2,3,4,5,6,7,8,9,10,11,12,13]
        let k = 5
        var expected = [5,4,3,2,1,10,9,8,7,6,11,12,13]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.reverseKGroup(ListNode(head), k)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

//    /// Case 4:
//    func testCase4() {
//        let head: [Int] = [1,2,3]
//        var expected: [Int] = [2,1,3]
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.swapPairs(.init(head))
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        print(elapsedTime)
//        XCTAssertEqual(result.toArray(), expected)
//    }

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

