# CPFChain
Swift链式调用基础库

## 使用方法

```Swift
// 支持Pods
pod 'CPFChain', '~>1.0.0'
```

```Swift
// 引入对应模块
import CPFChain
```

> 目前仅支持Swift，主要使用了泛型、协议;
> 仅支持引用类型的链式调用

## 示例

```Swift
// NSObject支持.cpf，默认已支持
extension NSObject: CpfCompatible { }

// 扩展方法
extension Cpf where Base: UIView {
    @discardableResult
    func background(color: UIColor?) -> Cpf {
        base.backgroundColor = color
        return self
    }

    @discardableResult
    func frame(_ rect: CGRect) -> Cpf {
        base.frame = rect
        return self
    }
}

// 调用
let aView = UILabel()
aView.cpf
    .background(color: .purple)
    .frame(.zero)

```

```Swift
// 自定义类
class CustomClass {
    var name: String?
    var age: Int = 0
}

// 支持.cpf
extension CustomClass: CpfCompatible {}

// 扩展方法
extension Cpf where Base: CustomClass {
    @discardableResult
    func name(_ value: String?) -> Cpf {
        base.name = value
        return self
    }

    @discardableResult
    func age(_ value: Int) -> Cpf {
        base.age = age
        return self
    }
}

// 调用
let customer = CustomClass()
customer.cpf
    .name("cpf")
    .age(18)

```

```Swift
// 协议
protocol PersonProtocol {
    var id: Int { get set }
    var name: String? { get set }
}

// 类
class Person: PersonProtocol {
    var id: Int = 0
    var name: String? = nil
}

class Animal: PersonProtocol {
    var id: Int = 0
    var name: String? = nil
}

// 支持.cpf
extension Person: CpfCompatible {}
extension Animal: CpfCompatible {}

// 扩展方法
extension Cpf where Base: PersonProtocol {
    @discardableResult
    func name(_ value: String?) -> Cpf {
        base.name = value
        return self
    }

    @discardableResult
    func age(_ value: Int) -> Cpf {
        base.age = age
        return self
    }
}

// 调用
let aPerson = Person()
aPerson.cpf
    .name("Aaron")
    .age(18)

let anAnimal = Animal()
anAnimal.cpf
    .name("HuanHuan")
    .age(6)
```
