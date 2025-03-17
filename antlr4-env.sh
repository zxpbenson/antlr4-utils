#!/bin/bash

#计算根路径
ROOT_DIR=`dirname ${BASH_SOURCE[0]}`
ROOT_DIR=`(cd $ROOT_DIR/.; pwd)`
#echo "ROOT_DIR=$ROOT_DIR"
#export ROOT_DIR=$ROOT_DIR

#cd $ROOT_DIR
#echo $@
#echo $*

#export ANTLR4_JAR=antlr-4.13.2-complete.jar
#export ANTLR4_JAR=antlr-4.13.1-complete.jar
export ANTLR4_JAR=antlr-4.7.1-complete.jar
