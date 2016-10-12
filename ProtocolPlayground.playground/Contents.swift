//: Playground - noun: a place where people can play

import UIKit

//: #### protocol
// protocol 是一种约定，而不是一种具体的类型，class/enum/struct can conform one or more protocol. -> 通常用来表示一些类型的共性

protocol Engine {
    
    var cylinder: Int {get set}
    
    var capacity: Double { get } // 只读
    
    func start()
    func stop()
    func getName(prefix: String)  // 参数不能有默认值
    func getName()
}

//ley p = Engine() protocol不是类型，不可以实例化
//class Truck: Engin}

// protocol inherit
protocol TurboEngine: Engine {
    
    func startTurbo()
    func stopTurbo()
}

protocol Motor {
    var power: Double { get set }

}


class V8 : TurboEngine, Motor{
    
    var cylinder: Int = 8
    
    var power: Double = 300
    
    private var innerCapacity = 4.0
    var capacity: Double{
        // 尽管capacity是一个“只读”的约定，但是我们同样可以在实现中添加get和set方法。
        get {
            return innerCapacity
        }
        set {
            self.innerCapacity = newValue
        }
    }
    
    // Engine methods
    
    
    func start() { print("Engine start") }
    func stop() { print("Engine stop") }
    func getName(prefix: String) {
        print("\(prefix)-V8-ENgine")
    }
    func getName() {
        print("V8-Engine")
    }
    
    // TurboEngine methods
    func startTurbo() {
        print("Turbo started")
    }
    func stopTurbo() {
        print("Turbo stopped")
    }
    
}

let v8 = V8()
v8.cylinder
v8.cylinder = 10 // 这里cylinder可写
//(v8 as Engine).capacity = 10 // 报错,不可写
v8.start()

v8.capacity = 8
