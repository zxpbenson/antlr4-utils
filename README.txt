1, 先下载antlr4的依赖包到当前目录

curl -O https://www.antlr.org/download/antlr-4.13.1-complete.jar
或
curl -O https://www.antlr.org/download/antlr-4.7.1-complete.jar

2，为了方便使用，把当前目录的几个shell指定别名
不同系统或不同版本设置环境变量的方法有所不同，我的是MacOS Sonoma 14.4
在 vim ~/.zshrc 写入如下内容(需要改成自己的真实路径)：

alias antlr4-compile="~/workspace/github.com/zxpbenson/antlr4-utils/antlr4-compile.sh"
alias antlr4-run="~/workspace/github.com/zxpbenson/antlr4-utils/antlr4-run.sh"
alias antlr4-generate="~/workspace/github.com/zxpbenson/antlr4-utils/antlr4-generate.sh"
alias antlr4-javac="~/workspace/github.com/zxpbenson/antlr4-utils/antlr4-javac.sh"
alias antlr4-clean="~/workspace/github.com/zxpbenson/antlr4-utils/antlr4-clean.sh"

保存后退出，重开一个端口，使刚才的别名生效

3, 走一个示例：

cd ~/Desktop
mkdir Hello
cd Hello
vim Hello.g4
写入如下内容

grammar Hello;
r : 'hello' ID;
ID : [a-z]+;
WS : [ \r\t\n]+ -> skip;

然后执行
antlr4-compile Hello.g4

最后执行
antlr4-run Hello r -gui

输入如下内容
hello benson

然后ctrl+D(windows ctrl+C)
可以看到语法树

最后清理生成的内容
antlr4-clean

