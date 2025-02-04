import UIKit

/**
 1. გვაქვს 1,5,10,20 და 50 თეთრიანი მონეტები. დაწერეთ ფუნქცია, რომელსაც გადაეცემა თანხა (თეთრებში)
 და აბრუნებს მონეტების მინიმალურ რაოდენობას, რომლითაც შეგვიძლია ეს თანხა დავახურდაოთ.
 */
func minSplit(amount: Int) -> Int {
    var result = 0
    let coins = [50, 20, 10, 5, 1]
    var currAmount = amount
    
    for coin in coins {
        if currAmount == 0 {
            break
        }
        result += currAmount / coin
        currAmount %= coin
    }
    
    return result
}

assert(minSplit(amount: 9) == 5)
assert(minSplit(amount: 26) == 3)
assert(minSplit(amount: 172) == 6)

print("minSplit(9) ->", minSplit(amount: 9))
print("minSplit(26) ->", minSplit(amount: 26))
print("minSplit(172) ->", minSplit(amount: 172), "\n")


/**
 2. დაწერეთ ფუნქცია რომელიც დააჯამებს ციფრებს ორ რიცსხვს შორის.
 მაგალითად გადმოგვეცემა 19 და 22. მათ შორის ციფრების ჯამი იქნება :
 // 19, 20, 21, 22
 // (1 + 9) + (2 + 0) + (2 + 1) + (2 + 2) = 19
 */

private func sumOfDigits(number: Int) -> Int {
    var result = 0
    var num = number
    
    while num > 0 {
        result += num % 10
        num /= 10
    }
    
    return result
}

func sumOfDigits(start: Int, end: Int) -> Int {
    var sum = 0
    
    for number in start...end {
        sum += sumOfDigits(number: number)
    }
    
    return sum
}

assert(sumOfDigits(start: 7, end: 8) == 15)
assert(sumOfDigits(start: 17, end: 20) == 29)
assert(sumOfDigits(start: 10, end: 12) == 6)

print("sumOfDigits(start: 7, end: 8) ->",sumOfDigits(start: 7, end: 8))
print("sumOfDigits(start: 17, end: 20) ->", sumOfDigits(start: 17, end: 20))
print("sumOfDigits(start: 10, end: 12) ->", sumOfDigits(start: 10, end: 12), "\n")

/**
 3. მოცემულია String რომელიც შედგება „(" და „)" ელემენტებისგან. დაწერეთ ფუნქცია რომელიც აბრუნებს
 ფრჩხილები არის თუ არა მათემატიკურად სწორად დასმული.
 */
func isProperly(sequence: String) -> Bool {
    var stack: [Character] = []
    
    for ch in sequence {
        if ch == "(" {
            stack.append(ch)
        }else if ch == ")" {
            if stack.isEmpty {
                return false
            }
            stack.removeLast()
        }
    }
    
    return stack.isEmpty
}

assert(isProperly(sequence: "(()())"))
assert(!isProperly(sequence: ")(()"))
assert(!isProperly(sequence: "(()())("))

print("\"(()())\" ->",isProperly(sequence: "(()())"))
print("\")(()\" ->", isProperly(sequence: ")(()"))
print("\"(()())(\" ->",isProperly(sequence: "(()())("), "\n")

/**
 4. გვაქვს N ფიცრისგან შემდგარი ხიდი. სიძველის გამო ზოგიერთი ფიცარი ჩატეხილია. ზურიკოს შეუძლია
 გადავიდეს შემდეგ ფიცარზე ან გადაახტეს ერთ ფიცარს. (რათქმაუნდა ჩატეხილ ფიცარზე ვერ გადავა)
 ჩვენი ამოცანაა დავითვალოთ რამდენი განსხვავებული კომბინაციით შეუძლია ზურიკოს ხიდის გადალახვა.
 გადმოგვეცემა ხიდის სიგრძე და ინფორმაცია ჩატეხილ ფიცრებზე. 0 აღნიშნავს ჩატეხილ ფიცარს 1_ანი კი მთელს.
 დასაწყისისთვის ზურიკო დგას ხიდის ერთ მხარეს (არა პირველ ფიცარზე) და გადალახვად ჩათვლება ხიდის
 მეორე მხარე (ბოლო ფიცრის შემდეგი ნაბიჯი)
 */

func countWays(n: Int, steps: [Int]) -> Int {
    guard n > 0 else { return 0 }
    
    // 0 is start, n+1 is end
    // step[i] -> dp[i + 1]
    var dp = Array(repeating: 0, count: n + 2)
    
    dp[0] = 1
    
    for i in 0...n {
        guard i == 0 || i > n || steps[i-1] == 1 else { continue }
        
        // stepping to end OR next plank is 1, so ways to reach next += ways to reach currect
        if i + 1 == n + 1 || (i < n && steps[i] == 1) {
            dp[i + 1] += dp[i]
        }
        if i + 2 == n + 1 || (i + 1 < n && steps[i + 1] == 1) {
            dp[i + 2] += dp[i]
        }
    }
    
    return dp[n + 1]
}

assert(countWays(n: 3, steps: [0, 1, 0]) == 1)
assert(countWays(n: 4, steps: [0, 1, 1, 0]) == 1)
assert(countWays(n: 5, steps: [1, 1, 0, 1, 1]) == 4)

print("countWays(n: 3, steps: [0, 1, 0]) ->", countWays(n: 3, steps: [0, 1, 0]))
print("countWays(n: 4, steps: [0, 1, 1, 0]) ->", countWays(n: 4, steps: [0, 1, 1, 0]))
print("countWays(n: 5, steps: [1, 1, 0, 1, 1]) ->", countWays(n: 5, steps: [1, 1, 0, 1, 1]), "\n")

/**
 5. გადმოგეცემათ მთელი რიცხვი N. დაწერეთ ფუნქცია რომელიც დაითვლის რამდენი 0ით ბოლოვდება N!
 (ფაქტორიალი)
 შენიშვნა 1000! შედგება 2568 სიმბოლოსაგან.
 */
func zeros(N: Int) -> Int {
    var answer = 0
    var divisor = 5
    
    while N >= divisor {
        answer += N / divisor
        divisor *= 5
    }
    
    return answer
}

assert(zeros(N: 7) == 1)
assert(zeros(N: 12) == 2)
assert(zeros(N: 490) == 120)
assert(zeros(N: 4) == 0)

print("zeros(N: 7) ->", zeros(N: 7))
print("zeros(N: 12) ->", zeros(N: 12))
print("zeros(N: 490) ->", zeros(N: 490))
print("zeros(N: 4) ->", zeros(N: 4))
