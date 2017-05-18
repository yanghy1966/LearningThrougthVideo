* 搜索时不区分大小写
  set ic (ignore case)
* 搜索时区分大小写
  set noic (no ignore case)
* 在目录中搜索
  :vim foo **/*.js | copen
  :vim foo /path/**/*.js | copen

* 系统复制粘贴
先安装：
sudo apt-get install vim-gnome
就可以用：
“+y:复制
"+p:粘贴
