#!/bin/bash

# 默认值
SRC_DIR="./"
DST_DIR="path/to/target"
HEADER=""

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

# 遍历所有 .java 文件
find "$SRC_DIR" -type f -name "*.java" | while read -r src_file; do
    # 获取相对路径
    rel_path="${src_file#$SRC_DIR/}"

    # 构造目标文件路径
    dst_file="$DST_DIR/$rel_path"

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

    echo "Processed: $rel_path"
done
