# 说明
* 一些好读命令，用tips标记


# 3-basic shell cmd

touch file1 # 创建文件
cp f1 f2
cp -i f1 f2 # 进行提示
cp -R d1/ d2 # 把d1复制到d2下

ln -s data_file sl_data_file

mv fall fzll

rm -i fall

mkdir new_dir
mkdir -p newdir1/newdir2/dir

rmdir newdir # 只删除空目录
rm -r dir # 删除目录及文件

tree dir

file my_file # 查看文件类型

cat test1 # 查看文件内容
cat -b test1 # 加上行号
more file1
less file1
tail file1
head file1



# 4-more shell cmdj
ps
top
kill 
killall

mount # 显示当前挂载
mount -t type device directory
df
du -hs
sort fiel1 # 对文件内容进行排序
sort -n file2
cut -d ':' -f 5 # 以:进行分割，取第5列
grep [optinos] pattern [file]
wc
tree # 重新定向STDIN

gzip # 压缩数据
gzcat # 查看压缩文件
gunzip # 解压

tar -cvf a.tar test/ test2/
tar -zcvf a.tar test/ test2/
tar -tvf a.tar 
tar xvf a.tar



# 5-understand shell
ps -f
ps --forest
pwd; ls ; cd /etc ; pwd ;
(pwd; ls ; cd /etc ; pwd ;) # 进程列表
jobs -l
命令& # 后台执行

which ps # 只显示外部命令
type -a ps # 可以显示每个命令读两种实现
history
alias -p # 显示别名
alias li='ls -li'







# 6-环境变量
环境变量有两种：全局、局部
全局：
printenv
printenv HOME
env HOME
echo $HOME
局部：
set
my_var="hhh world"    # 设置局部环境变量

export my_var="asfasas" # 设置全局环境变j量
unset my_val # 删除全局环境变量

默认环境变量
CDPATH
MAIL
PATH


# 7-文件权限
/etc/shadow # 保存密码

useradd -m # 增加用户,创建主目录
useradd -D # 查看默认值
userdel -r test #删除用户
passwd # 修改密码

groupadd shared # 添加组


# 8-文件系统
fdisk
fsck options filesystem



# 软件安装


# editor


# 11-bash script
echo sfas sfaf
命令替换
`ls` # 比较陈旧
$() # 可以嵌套多个命令
${} # 替换

command > 输出文件  #输出定向
command < 输入文件 # 输入定向
command|command     # 管道
expr 1 + 5  # 数学运算
$[1+2] # 数学计算
$? # 上一个命令的退出码
exit 5 # 退出码为5



# if else

if command
then
   command
fi


if command
then
   command
else
   command
fi

if command
then
   command
elif command
then
   command
fi

test 命令


检查目录是否存在
if [ -d $jump_dir ]
then
    echo "aaa"
else
    echo "bbb"
fi

-d file # 检查目录是否存在
-e file # 检查是否存在
-f file # 检查文件是否存在



# for

for var in list
do
    command
done

# user input


# output


# 16-control 
nice
at # 定时启动任务
cron # 定期运行任务
quota # 指定配额



# create function


# gui

# sed and gawk


# re

# sed


# gawk

# examples

# tips
把bash设置成vim模式
set -o vi



