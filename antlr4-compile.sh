#!/bin/bash

#计算根路径
ROOT_DIR=`dirname ${BASH_SOURCE[0]}`
ROOT_DIR=`(cd $ROOT_DIR/.; pwd)`
#echo "ROOT_DIR=$ROOT_DIR"
#export ROOT_DIR=$ROOT_DIR

#cd $ROOT_DIR
#echo $@
#echo $*

rm -f ./*.java
rm -f ./*.class
rm -f ./*.interp
rm -f ./*.tokens

source $ROOT_DIR/antlr4-env.sh

# 默认不生成 Visitor
# .g4 内加 options { visitor = true; }
# 命令行加 -visitor 参数
# 两种方式都可以实现生成 Visitor

# .interp 和 .tokens 文件主要用于 ANTLR4 内部的调试和开发，在实际项目中 通常不需要，可以忽略或删除。

# 1. .interp 文件
# 这个文件是 ANTLR 内部使用的解析规则缓存，用于 ANTLR 的 IDE 插件（如 IntelliJ IDEA 的 ANTLR 插件）在编辑 .g4 文件时提供语法高亮和错误检查。
# 通常不需要，也不会影响最终的编译和运行。
# 可以安全删除，不会影响 ANTLR 生成的 Java 代码。

# 2. .tokens 文件
# 这个文件存储了 词法分析器（Lexer）生成的 Token 序号，每个 Token 都有一个唯一的编号。
# 在 .g4 语法文件中，如果多个规则 需要引用相同的 Token，ANTLR 可能会使用 .tokens 文件来存储它们的编号。
# 如果你的语法文件不涉及手动引用 Token ID（比如 #define 语法），那么 .tokens 文件对你来说是多余的。
# 不建议删除，因为：

# 如果 .g4 语法文件有多个 .g4 文件相互引用，它们可能需要 .tokens 文件来共享 Token ID。
# ANTLR 可能在编译时自动读取 .tokens 文件，删除后可能导致解析错误。
# .interp	仅供 ANTLR IDE 插件使用	可以安全删除
# .tokens	存储 Token ID，多个 .g4 可能会用到 最好保留，除非确定没用
# 在一般情况下，你可以忽略 .interp 和 .tokens，它们不会影响最终的 Java 代码运行。


java -jar $ROOT_DIR/$ANTLR4_JAR -visitor $*
javac -cp $ROOT_DIR/$ANTLR4_JAR ./*.java

