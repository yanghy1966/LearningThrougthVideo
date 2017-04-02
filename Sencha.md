# Sencha特效
* cover
* Fade
* Flip
* Pop
* Reveal
* Scroll
* Slide
# 什么是model？
- 模型是对数据的定义
- 具有fields属性
- 具有一些函数属性
- 具有validators
- model也具有代理，可加载或保存至远程服务器，但是只能处理一个实体。而store能处理多个实体。

A Model or Entity represents some object that your application manages. For example, one might define a Model for Users, Products, Cars, or other real-world object that we want to model in the system. Models are used by Ext.data.Store, which are in turn used by many of the data-bound components in Ext.

```javascript
Ext.define('User', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'name',  type: 'string'},
        {name: 'age',   type: 'int', convert: null},
        {name: 'phone', type: 'string'},
        {name: 'alive', type: 'boolean', defaultValue: true, convert: null}
    ],

    changeName: function() {
        var oldName = this.get('name'),
            newName = oldName + " The Barbarian";

        this.set('name', newName);
    }
});

```
```js
var user = Ext.create('User', {
    id   : 'ABCD12345',
    name : 'Conan',
    age  : 24,
    phone: '555-555-5555'
});

user.changeName();
user.get('name'); //returns "Conan The Barbarian"
```

```js
Ext.define('User', {
    extend: 'Ext.data.Model',
    fields: [
        { name: 'name',     type: 'string' },
        { name: 'age',      type: 'int' },
        { name: 'phone',    type: 'string' },
        { name: 'gender',   type: 'string' },
        { name: 'username', type: 'string' },
        { name: 'alive',    type: 'boolean', defaultValue: true }
    ],

    validators: {
        age: 'presence',
        name: { type: 'length', min: 2 },
        gender: { type: 'inclusion', list: ['Male', 'Female'] },
        username: [
            { type: 'exclusion', list: ['Admin', 'Operator'] },
            { type: 'format', matcher: /([a-z]+)[0-9]{2,3}/i }
        ]
    }
});
```

```js
Ext.define('User', {
    extend: 'Ext.data.Model',
    fields: ['id', 'name', 'email'],

    proxy: {
        type: 'rest',
        url : '/users'
    }
});
Here we've set up a Ext.data.proxy.Rest, which knows how to load and save data to and from a RESTful backend. Let's see how this works:

var user = Ext.create('User', {name: 'Ed Spencer', email: 'ed@sencha.com'});

user.save(); //POST /users
```

# 什么是store?
- store有data数组的属性
- store可以通过代理加载远程数据，具有proxy属性
- store具有model属性
- store也可以内嵌数据
- 进行过滤，排序
- store通过ID引用
 
The Store class encapsulates a client side cache of Ext.data.Model objects. Stores load data via a Ext.data.proxy.Proxy, and also provide functions for sorting, filtering and querying the Ext.data.Model instances contained within it.

```js
store:{
   data:[
      {},
      {}
   ]
}
```
```js
Ext.create('Ext.data.Store', {
     model: 'User',
     data : [
         {firstName: 'Peter',   lastName: 'Venkman'},
         {firstName: 'Egon',    lastName: 'Spengler'},
         {firstName: 'Ray',     lastName: 'Stantz'},
         {firstName: 'Winston', lastName: 'Zeddemore'}
     ]
 });

```
动态加载
```js
store.load({
    params: {
        group: 3,
        type: 'user'
    },
    callback: function(records, operation, success) {
        // do something after the load finishes
    },
    scope: this
});
```

StoreId

```js
//this store can be used several times
Ext.create('Ext.data.Store', {
    model: 'User',
    storeId: 'usersStore'
});

new Ext.List({
    store: 'usersStore',
    //other config goes here
});

new Ext.view.View({
    store: 'usersStore',
    //other config goes here
});
```
# 什么是ViewModel？
- 视图模型是为实现binding而设计的，而store是为grid，tree等控件而设计的！
- 具有bind()方法
 将感兴趣的数据传给回调函数。
 
 ```js
 var binding = vm.bind('{foo}', this.onFoo, this);

binding.destroy();  // when done with the binding
 
 ```
 
 
 
- 绑定描述符：
* 文本绑定描述符
```js
'Hello {user.name}!'
'You have selected "{selectedItem.text}".'
'{!isDisabled}'
'{a > b ? "Bigger" : "Smaller"}'
'{user.groups}'

```
** 双向绑定
```js
Ext.widget({
     items: [{
         xtype: 'textfield',
         bind: '{s}'  // a two-way / direct bind descriptor
     }]
 });

```
对于textfield已经自动实现了双向绑定功能
* 对象及数组/多绑定

