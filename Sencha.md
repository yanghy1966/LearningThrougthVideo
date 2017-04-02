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


# 什么是store?
- store有data数组的属性
- store可以通过代理加载远程数据，具有proxy属性
- store具有model属性
The Store class encapsulates a client side cache of Ext.data.Model objects. Stores load data via a Ext.data.proxy.Proxy, and also provide functions for sorting, filtering and querying the Ext.data.Model instances contained within it.

```js
store:{
   data:[
      {},
      {}
   ]
}
```
