https://zhuanlan.zhihu.com/p/25604225

API DOC
http://brm.io/matter-js/docs/

demo:
http://brm.io/matter-js/



常用模块:
# Engin
Matter.Engine负责产生和处理引擎.引擎是一个控制器,负责对世界的更新.

Matter.Engin.create();
Matter.Engin.Merge(enginA, enginB);
Matter.Engin.run(engin);
Matter.Engin.update(engin,[delta=16.66],[correction=1]);

engin.render
engin.world

# World
Matter.World用于处理世界复合体.
Matter.World是一个Matter.Composite body.

Matter.Composite.add(composite, object) → Composite
Matter.World.addBody(world, body) → World
Matter.World.addComposite(world, composite) → World
Matter.World.addConstraint(world, constraint) → World



# Bodies
# Composite
# Composites
# Constraint
# MouseConstraint
# Events
# Plugin


+-----------------------------------------+
|                                         |
|                                         |
|      世界                               | 
|                                         | 
|      ( 添加 物体  )                      |
|                                         |   
+-----------------------------------------+

// Matter.Render 用法
var engine = Engine.create();
// ... 将物体加入到世界中
var render = Render.create({
    element: document.body,
    engine: engine,
    options: options
});
Engine.run(engine);
Render.run(render);


