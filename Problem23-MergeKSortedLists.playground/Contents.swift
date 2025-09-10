import Foundation
import XCTest

//You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.
//
//Merge all the linked-lists into one sorted linked-list and return it.
//
// 
//
//Example 1:
//
//Input: lists = [[1,4,5],[1,3,4],[2,6]]
//Output: [1,1,2,3,4,4,5,6]
//Explanation: The linked-lists are:
//[
//  1->4->5,
//  1->3->4,
//  2->6
//]
//merging them into one sorted linked list:
//1->1->2->3->4->4->5->6
//
//Example 2:
//
//Input: lists = []
//Output: []
//
//Example 3:
//
//Input: lists = [[]]
//Output: []
//
// 
//
//Constraints:
//
//    k == lists.length
//    0 <= k <= 104
//    0 <= lists[i].length <= 500
//    -104 <= lists[i][j] <= 104
//    lists[i] is sorted in ascending order.
//    The sum of lists[i].length will not exceed 104.
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

struct Heap<Element> {
    var elements: [Element]
    let areSorted: (Element, Element) -> Bool

    init(sort: @escaping (Element, Element) -> Bool) {
        self.elements = []
        self.areSorted = sort
    }

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }

    func peek() -> Element? {
        elements.first
    }

    mutating func insert(_ value: Element) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }

    mutating func remove() -> Element? {
        guard !elements.isEmpty else { return nil }
        if elements.count == 1 { return elements.removeFirst() }
        let value = elements[0]
        elements[0] = elements.removeLast()
        siftDown(from: 0)
        return value
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && areSorted(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var candidate = parent

            if left < elements.count && areSorted(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < elements.count && areSorted(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

class Solution {
//    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
//        var lists = lists
//        var dummy: ListNode? = ListNode.init(0)
//        var head = dummy
//
//        var lowestIndex: Int = 0
//        while !lists.isEmpty {
//            var lowestVal = 99999999999
//            for (index, list) in lists.enumerated() {
//                if let val = list?.val, val < lowestVal {
//                    lowestVal = val
//                    lowestIndex = index
//                }
//            }
//
//            var temp = head?.next
//            head?.next = lists[lowestIndex]
//            lists[lowestIndex] = lists[lowestIndex]?.next
//            head = head?.next
//            head?.next = temp
//
//            lists = lists.compactMap{ $0 }.compactMap{ $0 }
//        }
//
//        return dummy?.next
//    }

    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var pq = Heap<ListNode>(sort: { $0.val < $1.val }) // custom min-heap
        for list in lists {
            if let node = list { pq.insert(node) }
        }

        let dummy = ListNode(0)
        var tail: ListNode? = dummy

        while let node = pq.remove() {
            tail?.next = node
            tail = node
            if let next = node.next {
                pq.insert(next)
            }
        }

        return dummy.next
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
        let lists = [[1,4,5],[1,3,4],[2,6]]
        let nodeList = {
            var nodeList: [ListNode?] = []
            for list in lists {
                nodeList.append(ListNode.init(list))
            }
            return nodeList
        }()
        var expected = [1,1,2,3,4,4,5,6]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeKLists(nodeList)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 2:
    func testCase2() {
        let lists: [[Int]] = []
        let nodeList = {
            var nodeList: [ListNode?] = []
            for list in lists {
                nodeList.append(ListNode.init(list))
            }
            return nodeList
        }()
        var expected: [Int] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeKLists(nodeList)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result.toArray(), expected)
    }

    /// Case 3:
    func testCase3() {
        let lists: [[Int]] = [[]]
        let nodeList = {
            var nodeList: [ListNode?] = []
            for list in lists {
                nodeList.append(ListNode.init(list))
            }
            return nodeList
        }()
        var expected: [Int] = []

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.mergeKLists(nodeList)
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

