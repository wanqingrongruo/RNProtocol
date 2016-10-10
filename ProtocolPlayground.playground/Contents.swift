//: Playground - noun: a place where people can play

import UIKit

//: #### protocol
// protocol 是一种约定，而不是一种具体的类型，class/enum/struct can conform one or more protocol. -> 通常用来表示一些类型的共性

protocol Engine {
    
    var cylinder: Int {get set}
    func start()
    func stop()
    func getName(prefix: String)
    func getName()
}

//ley p = Engine() protocol不是类型，不可以实例化
//class Truck: Engin}
