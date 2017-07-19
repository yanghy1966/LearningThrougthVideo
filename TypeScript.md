# 对象模型的扩展
## 声明语义学
- TypeScript默认会加载名为lib.d.ts的声明文件，其中默认已包含了所有的DOM对象的声明。
- 环境声明
## 数据语义学
- var n:number; //需要声明
## 函数语义学
- function createVM(){}
- lamda函数：
   var volume = (x:number, y:number) => x * y;
## class和继承语义学
- 
## 模块

## 基本语法

[教程](https://www.w3cschool.cn/typescript/typescript-basic-types.html)


### 数据类型
#### 布尔值
let isDone: bollean = false;

#### 数字
let decLiteral: nmber = 6;

#### 字符串 
let name: string = "bob";
let user: string = 'admin';
let name: string = `Gene`;

#### 数组
let list: number = [1,2,3];

#### 元组
let x: [string, number];

#### 枚举
enum Color {Red, Green, Blue};
let c: Color = Color.Green;

#### 任意值
let notSure: any = 4;

#### 空值
void 没有任何类型

#### 类型断言
let strLength: number = (<string>someValue).length;
let strLength: number = (someValue as string).length;


### 变量声明
### 接口

interface SquareConfig {
  color?: string; //可选属性
  width?: number;
}

### 类
```js
class Greeter{
   greeting: string;
   constructor(message: string){
         this.greeting = message;  //访问对象的属性 
         greet(){
       return "Hello, " + this.greeting;
   }
}
}

let greeter = new Greeter("world");

```

#### 继承

```js
class Snake extends Animal {
    constructor(name: string) { super(name); }
    move(distanceInMeters = 5) {
        console.log("Slithering...");
        super.move(distanceInMeters);
    }
}


```
#### 保护
默认为public
private
protected

#### 变量修饰符
readonly





### 函数
### 泛型
### 枚举

enum Direction {
    Up = 1,
    Down,
    Left,
    Right
}



### 高级类型
### Symboles
### 迭代器和生成器
### 模块
#### 导出
class ZipCodeValidator implements StringValidator {
    isAcceptable(s: string) {
        return s.length === 5 && numberRegexp.test(s);
    }
}
export { ZipCodeValidator };
export { ZipCodeValidator as mainValidator };

#### 导入

import { ZipCodeValidator } from "./ZipCodeValidator";

let myValidator = new ZipCodeValidator();


### 命名空间

namespace Validation {
    export interface StringValidator {
        isAcceptable(s: string): boolean;
    }

    const lettersRegexp = /^[A-Za-z]+$/;
    const numberRegexp = /^[0-9]+$/;

    export class LettersOnlyValidator implements StringValidator {
        isAcceptable(s: string) {
            return lettersRegexp.test(s);
        }
    }

    export class ZipCodeValidator implements StringValidator {
        isAcceptable(s: string) {
            return s.length === 5 && numberRegexp.test(s);
        }
    }
}



### 命名空间和模块
### 模块解析
### 装饰器
### Minxins
### 三斜线指令
### 声明文件
### 声明文件介绍
### 声明文件结构
### 项目配置
### 编译选项

