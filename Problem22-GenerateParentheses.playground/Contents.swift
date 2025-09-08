import Foundation
import XCTest

//Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
//
// 
//
//Example 1:
//
//Input: n = 3
//Output: ["((()))","(()())","(())()","()(())","()()()"]
//
//Example 2:
//
//Input: n = 1
//Output: ["()"]
//
// 
//
//Constraints:
//
//    1 <= n <= 8

//extension String {
//    /// Checks if the parentheses are valid
//    func isValid() -> Bool {
//        var count = 0
//        for i in self {
//            if i == "(" {
//                count += 1
//            } else if i == ")" {
//                count -= 1
//            }
//
//            if count < 0 {
//                return false
//            }
//        }
//        if count == 0 {
//            return true
//        }
//        return false
//    }
//}

class Solution {
//    func catalan(n: Int) -> Int {
//        var result = 1
//        for i in 0..<n {
//            result = result * (2 * n - i) / (i + 1)
//        }
//        return result / (n + 1)
//    }
//
//    // Had some fun with this solution, it's silly though -> I know that the number of results will be the catalan number of the nth integer, so I looped until the results had that number of solution. Then I just randomly selected indexes replacing "(" with ")" until I had a valid unique solution. Given this is random, this may be the fastest solution or much more likely the absolute slowest. But it made me giggle.
//    func generateParenthesis(_ n: Int) -> [String] {
//        if n == 0 { return [] }
////        ()
////        ()() (())
////        ((())) (())() ()()() ()(()) (()())
////        There are 2n positions in which a ( can be placed. It can't ever be placed in the last slot though so that
////        reduces it to 2n-1 positions.
////        ((())) (()()) (())() (()))( ()()
////        aaabbb aababb aabbab aabbba abaabb ababab ababba abbaab abbaba abbbaa Must start with a and end with b
////        aaabbb aababb aabbab abaabb ababab abbaab Must have more a's than b's. Total length is 2n - 2, 2n because
////        for a valid parentheses, must have both left and right. And minus 2 because must start with left and
////        end with right.
//        var result: [String] = []
//
//        let leftEnd = "("
//        let rightEnd = ")"
//        // Must have length 2n - 2
//        var middle: [Character] = Array<Character>.init(repeating: "(", count: (2 * n) - 2)
//        // For n = 2 -> "()" and ")(" are both valid
//        // For n = 3 -> "(())", "()()", "())(", ")(()", ")()(", "))((", with the last being invalid.
//
//        var base = middle
//
//        while result.count < catalan(n: n) {
////            n = 1 - ""
////            n = 2 - "()", ")("
////            n = 3 - "(())", "()()", "())(", ")(()", ")()(", "))(("
////            n = 4 -
////            n = 5 -
////            n = 6 -
////            n = 7 -
////            n = 8 -
////            I need to add in n-1 ")"
//            for _ in 0..<n-1 {
//                let index = getIndex(middle)
//                middle[index] = ")"
//            }
//
//            var combination = leftEnd + String(middle) + rightEnd
//            if combination.isValid() && !result.contains(combination) {
//                result.append(combination)
//            }
//
//            middle = base
//        }
//
//        return result
//    }
//
//    func getIndex(_ middle: [Character]) -> Int {
//        let index = Int.random(in: 0..<middle.count)
//        if middle[index] != ")" {
//            return index
//        } else {
//            return getIndex(middle)
//        }
//    }

    func generateParenthesis(_ n: Int) -> [String] {
        var result: [String] = []
        
        // Start backtracking with empty string and zero counts
        backtrack("", 0, 0, n, &result)
        
        return result
    }
    
    private func backtrack(_ current: String, _ openCount: Int, _ closeCount: Int, _ n: Int, _ result: inout [String]) {
        // Base case: we've used all n pairs of parentheses
        if current.count == 2 * n {
            result.append(current)
            return
        }
        
        // Add opening parenthesis if we haven't used all n opening ones
        if openCount < n {
            backtrack(current + "(", openCount + 1, closeCount, n, &result)
        }
        
        // Add closing parenthesis if it doesn't exceed opening ones
        if closeCount < openCount {
            backtrack(current + ")", openCount, closeCount + 1, n, &result)
        }
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
        let n = 3
        var expected = ["((()))","(()())","(())()","()(())","()()()"]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.generateParenthesis(n)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        result = result.sorted()
        expected = expected.sorted()

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let n = 1
        var expected = ["()"]

        let startTime = CFAbsoluteTimeGetCurrent()
        var result = solution.generateParenthesis(n)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        result = result.sorted()
        expected = expected.sorted()

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

//    /// Case 3:
//    func testCase3() {
//        let list1: [Int] = []
//        let list2 = [0]
//        var expected = [0]
//
//        let startTime = CFAbsoluteTimeGetCurrent()
//        var result = solution.mergeTwoLists(ListNode(list1), ListNode(list2))
//        let endTime = CFAbsoluteTimeGetCurrent()
//        let elapsedTime = endTime - startTime
//
//        print(elapsedTime)
//        XCTAssertEqual(result.toArray(), expected)
//    }

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

