import Foundation
import XCTest

//You are given the heads of two sorted linked lists list1 and list2.
//
//Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.
//
//Return the head of the merged linked list.
//
//Example 1:
//
//       1 -> 2 -> 4
//       1 -> 3 -> 4
//--------------------------
//1 -> 1 -> 2 -> 3 -> 4 -> 4
//
//Input: list1 = [1,2,4], list2 = [1,3,4]
//Output: [1,1,2,3,4,4]
//
//Example 2:
//
//Input: list1 = [], list2 = []
//Output: []
//
//Example 3:
//
//Input: list1 = [], list2 = [0]
//Output: [0]
//
// 
//
//Constraints:
//
//    The number of nodes in both lists is in the range [0, 50].
//    -100 <= Node.val <= 100
//    Both list1 and list2 are sorted in non-decreasing order.


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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if let list1, let list2 {
            var dummyHead: ListNode? = .init(0)
            var dummy: ListNode? = dummyHead
            var list1Curr: ListNode? = list1
            var list2Curr: ListNode? = list2
            
            while list1Curr != nil || list2Curr != nil {
                if let curr1 = list1Curr,
                   let curr2 = list2Curr,
                   curr1.val <= curr2.val {
                    dummy?.next = list1Curr
                    dummy = dummy?.next
                    list1Curr = list1Curr?.next
                } else if let curr1 = list1Curr,
                          let curr2 = list2Curr,
                          curr1.val > curr2.val {
                    dummy?.next = list2Curr
                    dummy = dummy?.next
                    list2Curr = list2Curr?.next
                } else if let curr1 = list1Curr {
                    dummy?.next = list1Curr
                    list1Curr = nil
                } else if let curr2 = list2Curr {
                    dummy?.next = list2Curr
                    list2Curr = nil
                }
            }
            return dummyHead!.next
        } else if let list1 {
            return list1
        } else if let list2 {
            return list2
        }
        return nil
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
        let list1 = [1,2,4]
        let list2 = [1,3,4]
        var expected = [1,1,2,3,4,4]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeTwoLists(ListNode(list1), ListNode(list2))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 2:
    func testCase2() {
        let list1: [Int] = []
        let list2: [Int] = []
        var expected: [Int] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeTwoLists(ListNode(list1), ListNode(list2))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 3:
    func testCase3() {
        let list1: [Int] = []
        let list2 = [0]
        var expected = [0]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeTwoLists(ListNode(list1), ListNode(list2))
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

//    /// Case 4:
//    func testCase4() {
//        let s = "([])"
//        var expected = true
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.isValid(s)
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        print(elapsedTime)
//        XCTAssertEqual(result, expected)
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

