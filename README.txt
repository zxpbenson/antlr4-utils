1, 先下载antlr4的依赖包到当前目录

curl -O https://www.antlr.org/download/antlr-4.13.1-complete.jar
或
curl -O https://www.antlr.org/download/antlr-4.7.1-complete.jar

2，为了方便使用，把当前目录的几个shell指定别名
不同系统或不同版本设置环境变量的方法有所不同，我的是MacOS Sonoma 14.4
在 vim ~/.zshrc 写入如下内容：

alias antlr4="~/software/antlr4/antlr4.sh"
alias gantlr4="~/software/antlr4/gantlr4.sh"
alias cantlr4="~/software/antlr4/cantlr4.sh"

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

