bash要点知识：
http://blog.csdn.net/wangbole/article/details/8163401


# bash语法
定义：
  空格：space or tab
  word：字符串
  控制操作： || & && ; ;; ( ) | |& <newline> 可用来分割命令
  保留字：
     ！ case coproc do done elif else esac fi for function if in select then until while { } time [[ ]]


语法：
1. simple commands简单命令
    命令名 选项（重定向） 以控制符结束 。 命令返回值是它读退出状态
2. 流水线
     命令1 | 命令2
3. 列表
     以; & && || 分割读的流水线
4. 括弧命令
   （list）
    { list; }
    ((expression))
    [[ expression ]]

5. 注释
    # 开头
    
6. 引用 即去除特殊含义
   6.1 \
   6.2 '' 去除每一个字面值
   6.3 “” 去除所有字面值
7. 表达式
8. 命令替换
    $() or `command`
    $(()) 算术表达式
9. 重新定向
    定向到文件中

10. 简单命令扩展步骤：
    10.1 








