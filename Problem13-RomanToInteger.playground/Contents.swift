import Foundation
import XCTest

/// I'm just going to invert the solution I used below for problem 12.

// Seven different symbols represent Roman numerals with the following values:
//
// Symbol    Value
// I    1
// V    5
// X    10
// L    50
// C    100
// D    500
// M    1000
//
// Roman numerals are formed by appending the conversions of decimal place values from highest to lowest.
// Converting a decimal place value into a Roman numeral has the following rules:
//
// - If the value does not start with 4 or 9, select the symbol of the maximal value that can be subtracted from the
// input, append that symbol to the result, subtract its value, and convert the remainder to a Roman numeral.
// - If the value starts with 4 or 9 use the subtractive form representing one symbol subtracted from the following
// symbol, for example, 4 is 1 (I) less than 5 (V): IV and 9 is 1 (I) less than 10 (X): IX. Only the following
// subtractive forms are used: 4 (IV), 9 (IX), 40 (XL), 90 (XC), 400 (CD) and 900 (CM).
// - Only powers of 10 (I, X, C, M) can be appended consecutively at most 3 times to represent multiples of 10. You
// cannot append 5 (V), 50 (L), or 500 (D) multiple times. If you need to append a symbol 4 times use the
// subtractive form.
//
// Given an integer, convert it to a Roman numeral.

// Example 1:
// Input: num = 3749
// Output: "MMMDCCXLIX"
// Explanation:
// 3000 = MMM as 1000 (M) + 1000 (M) + 1000 (M)
//  700 = DCC as 500 (D) + 100 (C) + 100 (C)
//   40 = XL as 10 (X) less of 50 (L)
//    9 = IX as 1 (I) less of 10 (X)
// Note: 49 is not 1 (I) less of 50 (L) because the conversion is based on decimal places

// Example 2:
// Input: num = 58
// Output: "LVIII"
// Explanation:
// 50 = L
//  8 = VIII

// Example 3:
// Input: num = 1994
// Output: "MCMXCIV"
// Explanation:
// 1000 = M
//  900 = CM
//   90 = XC
//    4 = IV

// Constraints:
//     1 <= num <= 3999

class Solution {
//    // Solution 1: Brute force, this is a touch inefficient if not a bit overzelous in following rudimentary
//       logic. Break the string into sections based placement. Then follow through a generalized pattern based on
//       powers of 10.
//    func romanToInt(_ s: String) -> Int {
//        var numResult = 0
//
//        var ones: String = ""
//        var tens: String = ""
//        var hundreds: String = ""
//        var thousands: String = ""
//        
//        var result = breakToSubStrings(s, for: .ones, using: numMap)
//        ones = result.0
//        result = breakToSubStrings(result.1, for: .tens, using: numMap)
//        tens = result.0
//        result = breakToSubStrings(result.1, for: .hundreds, using: numMap)
//        hundreds = result.0
//        thousands = result.1
//
//        numResult += toInt(forPlace: .ones, forRoman: ones)
//        numResult += toInt(forPlace: .tens, forRoman: tens)
//        numResult += toInt(forPlace: .hundreds, forRoman: hundreds)
//        numResult += toInt(forPlace: .thousands, forRoman: thousands)
//
//        return numResult
//    }

    // Solution 2: This is much more elegant, simply summing everything as needed.
    func romanToInt(_ s: String) -> Int {
        let mp: [Character: Int] = [
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000
        ]
        
        let chars = Array(s)
        var ans = 0
        
        for i in 0..<chars.count {
            if i + 1 < chars.count, mp[chars[i]]! < mp[chars[i + 1]]! {
                ans -= mp[chars[i]]!
            } else {
                ans += mp[chars[i]]!
            }
        }
        
        return ans
    }
}

func breakToSubStrings(_ s: String, for place: Place, using numMap: [Int: String]) -> (String, String) {
    var sArray = Array(s)
    var placeArray: [Character] = []
    var fivesChar = Character(numMap[5 * place.rawValue] ?? "V")
    var onesChar = Character(numMap[place.rawValue] ?? "I")

    let placeIndex = sArray.firstIndex(of: fivesChar) ?? sArray.firstIndex(of: onesChar)
    if let placeIndex {
        placeArray = Array(sArray[placeIndex...])
        sArray = Array(sArray[..<placeIndex])
    }
    if sArray.contains(onesChar) {
        placeArray.insert(sArray.remove(at: sArray.count - 1), at: 0)
    }
    return (String(placeArray), String(sArray))
}

enum Place: Int {
    case ones = 1
    case tens = 10
    case hundreds = 100
    case thousands = 1000
}

var numMap: [Int: String] = {
    var dict: [Int: String] = [:]
    dict[1] = "I"
    dict[4] = "IV"
    dict[5] = "V"
    dict[9] = "IX"

    dict[10] = "X"
    dict[40] = "XL"
    dict[50] = "L"
    dict[90] = "XC"

    dict[100] = "C"
    dict[400] = "CD"
    dict[500] = "D"
    dict[900] = "CM"

    dict[1000] = "M"

    return dict
}()

func getGeneralMap(for place: Place) -> [(roman: String, general: String)] {
    switch place {
    case .ones:
        return {
            var lookup: [(roman: String, general: String)] = []
            lookup.append((roman: "I", general: "a"))
            lookup.append((roman: "V", general: "b"))
            lookup.append((roman: "X", general: "c"))
            return lookup
        }()
    case .tens:
        return {
            var lookup: [(roman: String, general: String)] = []
            lookup.append((roman: "X", general: "a"))
            lookup.append((roman: "L", general: "b"))
            lookup.append((roman: "C", general: "c"))
            return lookup
        }()
    case .hundreds:
        return {
            var lookup: [(roman: String, general: String)] = []
            lookup.append((roman: "C", general: "a"))
            lookup.append((roman: "D", general: "b"))
            lookup.append((roman: "M", general: "c"))
            return lookup
        }()
    case .thousands:
        return {
            var lookup: [(roman: String, general: String)] = []
            lookup.append((roman: "M", general: "a"))
            lookup.append((roman: "", general: ""))
            lookup.append((roman: "", general: ""))
            return lookup
        }()
    }
}

func generalize(_ s: String, generalMap: [(roman: String, general: String)]) -> String {
    var result = s
    for map in generalMap {
        result = result.replacingOccurrences(of: map.roman, with: map.general)
    }
    return result
}

func toInt(forPlace place: Place, forRoman roman: String) -> Int {
    let generalized = generalize(roman, generalMap: getGeneralMap(for: place))

    var result = 0
    if generalized.count == 4 {
        result = 8
    } else if generalized.count == 3 {
        if generalized.contains("b") {
            result = 7
        } else {
            result = 3
        }
    } else if generalized.count == 2 {
        if generalized.contains("c") {
            result = 9
        } else if !generalized.contains("b") {
            result = 2
        } else if generalized.contains("ab") {
            result = 4
        } else {
            result = 6
        }
    } else {
        if generalized.contains("b") {
            result = 5
        } else if generalized.contains("a") {
            result = 1
        }
    }

    return result * place.rawValue
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
        let s = "III"
        let expected = 3

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.romanToInt(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 2:
    func testCase2() {
        let s = "LVIII"
        let expected = 58

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.romanToInt(s)
        let endTime = CFAbsoluteTimeGetCurrent()
        let elapsedTime = endTime - startTime

        print(elapsedTime)
        XCTAssertEqual(result, expected)
    }

    /// Case 3:
    func testCase3() {
        let s = "MCMXCIV"
        let expected = 1994

        let startTime = CFAbsoluteTimeGetCurrent()
        let result = solution.romanToInt(s)
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

