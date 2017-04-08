* 参考资料
 - [Dock技术介绍](http://www.csdn.net/article/2014-07-02/2820497-what%27s-docker)
 - [Docker技术深入分析](http://www.open-open.com/lib/view/open1423703640748.html)
 

* 什么是Docker？

    DockerDocker is the world’s leading software container platform. Developers use Docker to eliminate “works on my machine” problems when collaborating on code with co-workers. Operators use Docker to run and manage apps side-by-side in isolated containers to get better compute density. Enterprises use Docker to build agile software delivery pipelines to ship new features faster, more securely and with confidence for both Linux and Windows Server apps.
* 什么是容器？

* 什么是Docker？
Docker 几乎就没有什么虚拟化的东西，并且直接复用了 Host 主机的 OS，在 Docker Engine 层面实现了调度和隔离重量一下子就降低了好几个档次。 Docker 的容器利用了  LXC，管理利用了  namespaces 来做权限的控制和隔离，  cgroups 来进行资源的配置，并且还通过  aufs 来进一步提高文件系统的资源利用率。

Docker 是 用 Go 语言编写的，源代码托管在 github 而且居然只有 1W 行就完成了这些功能。

  Docker直译为码头工人。当它成为一种技术时，做的也是码头工人的事。官网是这样描述它的：“Docker是一个开发的平台，用来为开发者和系统管理员构建、发布和运行分布式应用。”也就是说，如果把你的应用比喻为货物，那么码头工人（Docker）就会迅速的用集装箱将它们装上船。快速、简单而有效率。
        它是用Go语言写的，是程序运行的“容器”（Linux containers），实现了应用级别的隔离（沙箱）。多个容器运行时互不影响，安全而稳定。
        我喜欢它的原因就是快速部署，安全运行，不污染我的系统


* 重要概念
1.image 镜像
镜像就是一个只读的模板。比如，一个镜像可以包含一个完整的Ubuntu系统，并且安装了apache。
镜像可以用来创建Docker容器。
其他人制作好镜像，我们可以拿过来轻松的使用。这就是吸引我的特性。
2.Docker Container 容器
Docker用容器来运行应用。容器是从镜像创建出来的实例（好有面向对象的感觉，类和对象），它可以被启动、开始、停止和删除。
3.仓库
这个好理解了，就是放镜像的文件的场所。比如最大的公开仓库是Docker Hub。
* docker教程
[docker教程](http://www.docker.org.cn/book/docker/prepare-docker-5.html)
* docker组件
 - 客户 端和服务器
 - 镜像
 - Register
 - 容器
 - 
 
