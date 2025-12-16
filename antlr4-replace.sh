#!/bin/bash

ROOT_DIR=`dirname ${BASH_SOURCE[0]}`
ROOT_DIR=`(cd $ROOT_DIR/.; pwd)`

if [ -f "$ROOT_DIR/.env" ]; then
    # 如果存在，就执行 source
    source $ROOT_DIR/.env
    echo ".env 文件已加载"
fi


# 默认值
SRC_DIR="./"
DST_DIR=${DST_DIR:-"path/to/target"}
HEADER=${HEADER:-"com.example.pkg"}

echo "WorkDir:"
pwd

# 解析 -p 形式参数
while [[ $# -gt 0 ]]; do
    if [[ $1 == -p ]]; then
        shift
        key="${1%%=*}"
        val="${1#*=}"
        case "$key" in
            SRC_DIR) SRC_DIR="$val" ;;
            DST_DIR) DST_DIR="$val" ;;
            HEADER)  HEADER="$val" ;;
            *) echo "未知参数: $key" >&2 ;;
        esac
    fi
    shift
done

# 检查必要参数
if [[ -z "$SRC_DIR" || -z "$DST_DIR" || -z "$HEADER" ]]; then
    echo "用法: $0 -p SRC_DIR=/path/to/source -p DST_DIR=/path/to/target -p HEADER=\"package a.b.c.d;\""
    exit 1
fi

echo "\$SRC_DIR=$SRC_DIR"
echo "\$DST_DIR=$DST_DIR"

# 遍历所有 .java 文件
find "$SRC_DIR" -type f -name "*.java" | while read -r src_file; do
    # 获取相对路径

    #echo "\$src_file=$src_file"
    file_name="${src_file#$SRC_DIR/}"
    #echo "\$file_name=$file_name"

    # 构造目标文件路径
    dst_file="$DST_DIR/$file_name"
    #echo "\$dst_file=$dst_file"

    # 确保目标目录存在
    mkdir -p "$(dirname "$dst_file")"
    #dirname "$dst_file"

    # 写入 header + 源文件内容 到目标文件
    {
        echo "$HEADER"
        cat "$src_file"
        #echo "$src_file"
    } > "$dst_file"
    #echo $dst_file

    echo "Processed: $file_name"
done

echo "cp $SRC_DIR/*.tokens $DST_DIR/"
cp $SRC_DIR/*.tokens $DST_DIR/
echo "cp $SRC_DIR/*.interp $DST_DIR/"
cp $SRC_DIR/*.interp $DST_DIR/
