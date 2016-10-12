//: Playground - noun: a place where people can play

import UIKit

// 在Swift 标准库中, 有一些标准的 protocol.通过他们,可以让我们的自定义类型更好的和 Swift 标准库融合,同时也可以让我们自定义类型有更自然的语意表现
//: #### Equatable and comparable

struct Rational {
    var numerator: Int
    var denominator: Int
}

let onehalf = Rational(numerator: 1, denominator: 2)
let zeroPointTwo = Rational(numerator: 1, denominator: 2)

extension Rational: Equatable{
    static func == (lhs: Rational, rhs: Rational) -> Bool {
        return (lhs.numerator == rhs.numerator) && (lhs.denominator == rhs.denominator)
    }
}




if onehalf == zeroPointTwo {
    print("equal")
}

// 写了一个相等函数 swift 会自动推导一个!=不等函数
if onehalf != zeroPointTwo {
    print("nor equal")
}

// Comparable 继承自 Equatable
extension Rational: Comparable{}

func < (lhs: Rational, rhs: Rational) -> Bool{
    // “我们要把numerator和demonimator转换成Double之后再相除，否则商会是一个整数。”
    let lQuotient = Double(lhs.numerator) / Double(lhs.denominator)
    let rQuotient = Double(rhs.numerator) / Double(rhs.denominator)
    
    return lQuotient < rQuotient
}

//如果我们定义了"<"，Swift就会自动推导">"；

/*
 在实现了Comparable之后，除了可以对Rational进行比较之外，还有一些额外的"福利"。
 当我们把Rational对象放入支持Comparable的集合类型时，例如Array，集合的各种排序，
 比较，包含操作，就可以对Rational对象生效了。
 */

var rationals: Array<Rational> = []
for i in 1...10 {
    var r = Rational(numerator: i, denominator: i+1)
    rationals.append(r)
}

print("Max in rationals: \(rationals.max()!)")
print("Min in rationals: \(rationals.min()!)")
rationals.starts(with: [onehalf])
rationals.contains(onehalf)

extension Rational: CustomStringConvertible {

    var description: String {
        return "\(self.numerator) / \(self.denominator)"
    }
}


extension Rational: Hashable{
    
    var hashValue: Int{
        let v = Int(String(self.numerator)+String(self.denominator))
        
        return v!
    }
}

onehalf.hashValue


