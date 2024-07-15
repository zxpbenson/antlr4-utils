#!/bin/bash

#计算根路径
ROOT_DIR=`dirname ${BASH_SOURCE[0]}`
ROOT_DIR=`(cd $ROOT_DIR/.; pwd)`
#echo "ROOT_DIR=$ROOT_DIR"
#export ROOT_DIR=$ROOT_DIR

#cd $ROOT_DIR
#echo $@
#echo $*
java -jar $ROOT_DIR/antlr-4.7.1-complete.jar $*
javac -cp $ROOT_DIR/antlr-4.7.1-complete.jar ./*.java

