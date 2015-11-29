import UIKit

//https://forums.developer.apple.com/thread/26801


// 没有标签的元组
let theDate : (String, Int) = ("January", 30)


// 带有标签的元组
let theDateLabelled : (month:String, day:Int) = theDate
theDateLabelled.month
// theDate.month     //编译错误：theDate 没有指定标签


//: The warning below says `is` test is always true, yet the test fails. **This is surely contradictory?**
if (theDate is (month:String, day:Int)) {//编译警告：'is' test is always true
    print("SAME TYPE")
} else {
    print("DIFFERENT TYPE")
}
// 输出 DIFFERENT TYPE

if (theDate is (String, Int)) {//编译警告：'is' test is always true
    print("SAME TYPE")
} else {
    print("DIFFERENT TYPE")
}
// 输出 SAME TYPE


//https://forums.developer.apple.com/thread/26690#89833

// 首先定义2个类似的函数
func foo(a: Int, _ b: Int) { print("foo", a, b) }
func bar(a: (Int, Int)) { print("bar", a.0, a.1) }

// 定义函数的别名
typealias Foo = (Int, Int) -> Void
typealias Bar = ((Int, Int)) -> Void
typealias Baz = (((Int, Int))) -> Void

//判断类型，Foo，Bar，Baz的类型是一样的，都是(Int, Int) -> ()
print(Foo.self == Bar.self) // true
print(Foo.self == Baz.self) // true
print(foo.dynamicType) // (Int, Int) -> ()
print(bar.dynamicType) // (Int, Int) -> ()

print(foo.dynamicType == bar.dynamicType) // true

// 自定义操作符，使用 foo 和 bar 也正常
infix operator § {}
func §<ParamListType, ResultType>(fn: ParamListType -> ResultType, args: ParamListType) -> ResultType {
    return fn(args)
}

let x = (1, 2)

foo § (1, 2) // foo 1 2
bar § (1, 2) // bar 1 2

foo § x      // foo 1 2
bar § x      // bar 1 2

//接下来正常调用 foo 和 bar 函数：

foo(x)       // 正确：foo 1 2
bar(x)       // 正确：bar 1 2

foo(1, 2)    // 正确：foo 1 2
//bar(1, 2)    // 编译错误：Extra argument in call


//foo((1, 2))  // 编译错误: Missing argument for parameter #2 in call
bar((1, 2))  // bar 1 2


// 接下来，提问者又做了新的尝试
let fooInBarsClothing: Bar = foo
let barInFoosClothing: Foo = bar

//fooInBarsClothing(1, 2) // 编译错误：Extra argument in call
barInFoosClothing(1, 2) // 正确：bar 1 2
//
fooInBarsClothing((1, 2)) //正确： foo 1 2
//barInFoosClothing((1, 2)) // 编译错误: Missing argument for parameter #2 in call


//OOPer的回复：

typealias Hoge = (Int, b: Int)->Void
func hoge(a: Int, b: Int) { print("hoge", a, b) }
hoge(1, b: 2)
var fooFunc: Foo = hoge
fooFunc(1, 2)
var barFunc: Bar = hoge
barFunc((1, 2))
var hogeFunc: Hoge = hoge
hogeFunc(1, b: 2)
