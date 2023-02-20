#!/bin/bash

echo "请选择要执行的命令："
echo "1. 查看所有docker容器"
echo "2. 查看所有未启动的docker容器"
echo "3. 启动所有未启动的docker容器"

read -p "请输入数字 [1-9]: " choice

case $choice in
    1)
        docker ps -a
        ;;
    2)
        docker ps -a --filter "status=exited"
        ;;
    3)
        docker start $(docker ps -a --filter "status=exited")
        ;;
    *)
        echo "输入无效"
        ;;
esac