//: Playground - noun: a place where people can play

import UIKit

//: 通过 protocol extension 添加额外功能. 例如默认实现
protocol Flight {
    
    var delay: Int{ get } // 延误次数
    var normal: Int{ get } // 准点次数
    var flyHour: Int{ get } // 航班总飞行时间
    
   // func delayRate() -> Double // 晚点率
}



// MARK: - 通过 extension 为 protocol 提供默认实现
extension Flight {
    
    // 尽管此时我们还没定义任何 conform Flight 的类型,但是我们已经可以在 extension 中使用 Flight 的数据成员了.因为 Swift 编译器知道,任何 conform Flight 的自定义类型,一定会定义约定的各种属性
    var totalTrips: Int {
        return delay + normal
    }
    
    
    /// 协议方法的默认实现
    ///
    /// - returns: <#return value description#>
    func delayRate() -> Double {
        
        return Double(delay) / Double(totalTrips)
    }
    
}


/// 定义结构体
struct A380: Flight {
    
    var delay: Int
    var normal: Int
    var flyHour: Int
    
     // 注意: 通过 extension 添加到 protocol 中的内容不算做约定,是 Flight自己的方法,也就是说当 protocol 中没有这个约定, extension 中这个方法就是一个普通的方法,只有 Flight 才能调用
    
    // 例如 -- 在结构体中添加一个自定义实现
    func delayRate() -> Double {
        
        return 0.1
    }
    
}

let a380 = A380(delay: 30, normal: 100, flyHour: 5 * 365 * 24)
a380.totalTrips

// 因为在 A380 中重定义了方法,所以无论a380的类型是Flight还是A380，我们可以看到delayRate()的输出都将变成0.1
a380.delayRate()
(a380 as Flight).delayRate()

// 我们注释了协议中的delayRate()约定,再看,出现两个结果
// 显然 a380.delayRate() 调用的是 A380 中的 delayRate
// (a380 as Flight).delayRate() 调用的是协议 Flight 的 extension 为其提供的一个便利功能
// 既然delayRate()不再是约定，Swift编译器也不会"感知"到A380对delayRate()的重定义，而只是把delayRate()理解为是A380定义的一个普通的方法。
// 所以实际上，Flight和A380中的delayRate()没有任何关系。


// extension 中使用 type constraint
// 为默认实现提供限定可用条件

protocol OperationalLife {
    
    var maxFlyHours: Int { get }
}

// where 表示我们要进行一个 type constraint, Self 表示"最终遵从protocol的类型"（在我们的例子里，也就是A380）
// 所以整个表达式的含义就是当某个类型同时遵从OperationalLife和Flight时，扩展Flight，并提供isInService方法。
extension Flight where Self: OperationalLife{
    
    func isInService() -> Bool {
        
        return self.flyHour < maxFlyHours
    }
}


extension A380: OperationalLife {
    
    var maxFlyHours: Int {
        
        return 18 * 365 * 24
        
    }
}


let a381 = A380(delay: 300, normal: 700, flyHour: 5 * 365 * 24)
a381.isInService()

protocol ShowInfo {
 
    var desc: String { get }
}

extension Flight where Self: OperationalLife & ShowInfo {
    
    func shwoDesc() {
        
        if isInService() {
            print("给个好评啊\(desc)")
        }
    }
    
}

extension A380: ShowInfo {
    
    var desc: String {
        
        return "我是马云爸爸"
        
    }
}

//let a382 = A380(delay: 400, normal: 1000, flyHour:  5 * 365 * 34)
//a382.shwoDesc()


let setBool: (Bool, String) -> Void = UserDefaults.standard.set
let getBool: (String) -> Bool = UserDefaults.standard.bool






