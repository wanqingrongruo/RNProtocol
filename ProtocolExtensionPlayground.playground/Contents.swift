//: Playground - noun: a place where people can play

import UIKit

//: 通过 protocol extension 添加额外功能. 例如默认实现
protocol Flight {
    
    var delay: Int{ get } // 延误次数
    var normal: Int{ get } // 准点次数
    var flyHour: Int { get } // 航班总飞行时间
}


// MARK: - 通过 extension 为 protocol 提供默认实现
extension Flight {
    
    // 尽管此时我们还没定义任何 conform Flight 的类型,但是我们已经可以在 extension 中使用 Flight 的数据成员了.因为 Swift 编译器知道,任何 conform Flight 的自定义类型,一定会定义约定的各种属性
    var totalTrips: Int {
        return delay + normal
    }
    
}


/// 定义结构体
struct A380: Flight {
    
    var delay: Int
    var normal: Int
    var flyHour: Int
}

