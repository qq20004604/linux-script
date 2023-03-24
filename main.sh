#!/bin/bash

echo "请选择要执行的命令："
echo "1. 查看所有docker容器"
echo "2. 查看所有未启动的docker容器"
echo "3. 启动所有未启动的docker容器"
echo "4. 显示某次git提交代码更改的总行数"
echo "5. 显示最近n次git提交代码更改的总行数"

read -rp "请输入数字 [1-9]: " choice

case $choice in
    1)
        docker ps -a
        ;;
    2)
        docker ps -a --filter "status=exited"
        ;;
    3)
        docker start "$(docker ps -a --filter "status=exited")"
        ;;
    4)
        echo "请输入该次提交的哈希值（例如ac0b2889669acc865b6c80bb4c9d87710f896895）："
        read -rp "请输入: " COMMIT_HASH
        echo "输出结果："
        git diff "${COMMIT_HASH}^" "${COMMIT_HASH}" --shortstat
        ;;
    5)
        read -rp "请输入要查询的最近n次提交次数（n）：" NUM_COMMITS

        # 获取最近 n 次提交的哈希值
        COMMIT_HASHES=$(git log --pretty=format:"%H" -n "${NUM_COMMITS}")

        # 计数器
        COUNTER=1

        # 遍历哈希值列表并输出代码变更行数
        for COMMIT_HASH in ${COMMIT_HASHES}
        do
          echo "第 ${COUNTER} 次提交的哈希值：${COMMIT_HASH}"
          echo "代码变更行数："
          git diff "${COMMIT_HASH}^" "${COMMIT_HASH}" --shortstat
          echo
          COUNTER=$((COUNTER + 1))
        done
        ;;
    *)
        echo "输入无效"
        ;;
esac