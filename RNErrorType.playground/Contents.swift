//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//在Swift里，任何一个遵从Error protocol的类型，都可以用于描述错误.Error是一个空的protocol，它唯一的功能，就是告诉Swift编译器，某个类型用来表示一个错误。
enum RobotError: Error{
    
    case LowPower(Double) // 电量低 ...他的 associated value 表示电量的百分比
    case Overload(Double) // 超过负载...他的 associated value 表示最大负载值
}

enum Command {
    
    case PowerUp // 启动
    case Lifting(Double) //举重
    case Shutdown // 关机
}

class Robot {
    
    var power = 1.0
    let maxLifting = 100.0 // kg
    
    
    
    /// 一个会抛异常的函数
    ///
    /// - parameter command: 命令
    ///
    /// - throws: 异常
    func action(command: Command) throws {
        
        switch command {
        case .PowerUp:
            guard self.power > 0.2 else { // 电量低于0.2抛错
                throw RobotError.LowPower(0.2)
            }
            
            print("Robot started")
        case let .Lifting(weight):
            guard weight < maxLifting  else {
                throw RobotError.Overload(maxLifting)
            }
            
            print("Lifting weight: \(weight)kg")
        case .Shutdown:
            print("Robot shuting down")
            
        }
        
    }
}


func working(robot: Robot) throws -> Int{
    
    // defer 指定一段代码 -- 在程序离开当前函数的作用域时调用
    // 一般放一些清理代码
    // 不可以放 break return 以及一些可能抛出异常的代码
    defer { //
        try! robot.action(command: Command.Shutdown) // try! 告诉编译器调用这个方法一定不会抛出异常. 如果使用try! 抛出了异常系统将杀死 app
    }
    
    do {
        try robot.action(command: Command.PowerUp)
        try robot.action(command: Command.Lifting(152))
        //try robot.action(command: Command.Shutdown)
    }
    catch let RobotError.LowPower(percentage){
        print("Low power: \(percentage)")
    }
    //        catch let RobotError.Overload(weight){ //
    //            print("OverLifting...\(weight) KG is allowed")
    //        }
    
    
    return 0
}

let iRobot = Robot()
//我们使用了"try?"的形式调用了一个会抛出异常的方法，它把表达式的评估结果转换为一个Optional。例如，我们让working返回一个Int?
let a = try? working(robot: iRobot)
print("value: \(a)\n type: \(type(of: a))")

//如果我们把RobotError.Overload注释掉，然后让Robot举起超过100KG的物体：
//这样异常就会被抛到working外围，此时Swift运行时会捕捉到这个异常，并且，把a的值设置成nil：
//        catch let RobotError.Overload(weight){ //
//            print("OverLifting...\(weight) KG is allowed")
//        }

// the way which deals with error in swift

enum Result<T>{
    
    case Success(T)
    case Failure(String)
    
    func map<P>(f: (T) -> P) -> Result<P>{
        
        switch self {
        case .Success(let value):
            return .Success(f(value))
        case .Failure(let error):
            return .Failure(error)
        }
    }
    
    func flatMap<P>(f: (T) -> Result<P>) -> Result<P>{
        
        switch self {
        case .Success(let value):
            return f(value)
        case .Failure(let error):
            return .Failure(error)
            
        }
    }
}

// 除法
func newDivide(dividend: Double, by: Double) -> Result<Double>{
    
    if by == 0 {
        return Result.Failure("cannot divided by zero")
    }
    else{
        return Result.Success(dividend / by)
    }
}


let user = newDivide(dividend: 8, by: 2)
switch user {
case let .Success(value):
    print(value)
case let .Failure(error):
    print(error)
}

// 平方根

func numberSqrt(num: Result<Double>) -> Result<Double>{
    
    switch num {
    case .Success(let num):
        let res = sqrt(num)
        return Result.Success(res)
    case .Failure(let error):
        return Result.Failure(error)
    }
}

let res02 = numberSqrt(num: user)

// 转字符串

func numberToString(num: Result<Double>) -> Result<String>{
    switch num {
    case .Success(let num):
        let s = String(format: "%.2lf", num)
        return Result.Success(s)
    case .Failure(let error):
        return Result.Failure(error)
        
    }
}


let res03 = numberToString(num: res02)


func numSqrt(num: Double) -> Double {
    let s = sqrt(num)
    return s
}

func num2String(num: Double) -> String {
    let s = String(format: "%.10f", num)
    return s
}

let res04 = user.map(f: numSqrt).map(f: num2String)



// 平方根

func numberSqrt02(num: Double) -> Result<Double>{
    
    if num < 0 {
        return Result.Failure("Number can not be nagative")
    }
    else{
        return Result.Success(sqrt(num))
    }
}

let res05 = user.flatMap(f:numberSqrt02).map(f: num2String)

