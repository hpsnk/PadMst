#!/usr/bin/env bash

# 出错时立即退出
set -e

# 定义颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # 重置颜色

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}       开始配置开发环境...               ${NC}"
echo -e "${BLUE}========================================${NC}"

# 定义仓库配置（兼容两种格式）：
# 格式 1: "本地目录名|Git仓库地址" (使用仓库默认分支)
# 格式 2: "本地目录名|Git仓库地址|要切的目标分支"
REPOS=(
    "000_PADDashFormation|git@github.com:Mapaler/PADDashFormation.git"
    "010_PadMstData|git@github.com:hpsnk/PadMstData.git|main"
    "020_PadMstJs|git@github.com:hpsnk/PadMstJs.git|main"
    "030_PadMstWeb|git@github.com:hpsnk/PadMstWeb.git|main"
    "040_PadMstWebVue|git@github.com:hpsnk/PadMstWebVue.git|main"
)

echo -e "当前工作路径: ${GREEN}$(pwd)${NC}\n"

# 3. 循环处理各个仓库
for item in "${REPOS[@]}"; do
    # 清空变量，防止上一次循环残留
    DIR=""
    URL=""
    BRANCH=""

    # 解析配置项
    IFS="|" read -r DIR URL BRANCH <<< "$item"
    
    echo -e "${BLUE}----------------------------------------${NC}"
    echo -e "正在处理仓库: ${GREEN}$DIR${NC}"
    echo -e "仓库地址: $URL"
    
    # 检查本地目录是否存在，存在则直接跳过 clone 及后续操作
    if [ -d "$DIR" ]; then
        echo -e "${YELLOW}目录 $DIR 已存在，跳过该仓库的克隆与更新。${NC}\n"
        continue
    fi

    echo -e "${YELLOW}正在克隆仓库...${NC}"
    git clone "$URL" "$DIR"
    cd "$DIR"

    # 根据是否传了 BRANCH 参数做不同处理
    if [ -n "$BRANCH" ]; then
        echo -e "切换到指定分支: ${GREEN}$BRANCH${NC}"
        git checkout "$BRANCH"
    fi
    
    # 返回上级目录
    cd ..
    echo -e "${GREEN}✓ $DIR 处理完成${NC}\n"
done

echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  开发环境准备完毕！                   ${NC}"
echo -e "${BLUE}========================================${NC}"
