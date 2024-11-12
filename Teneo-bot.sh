#!/bin/bash

# 定义颜色
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# 显示标题
echo "${YELLOW}${BOLD}====================================="
echo "🚀 Teneo 节点机器人自动化安装脚本 🚀"
echo "=====================================${RESET}"

# 保存初始目录
START_DIR=$(pwd)

# 菜单函数
show_menu() {
  echo ""
  echo "${BLUE}${BOLD}请选择操作:${RESET}"
  echo "${GREEN}1)${RESET} 安装依赖"
  echo "${GREEN}2)${RESET} 编辑账户配置"
  echo "${GREEN}3)${RESET} 编辑代理配置"
  echo "${GREEN}4)${RESET} 配置是否使用代理"
  echo "${GREEN}5)${RESET} 启动 Teneo 节点机器人"
  echo "${GREEN}6)${RESET} 退出"
  echo ""
}

# 克隆仓库并安装依赖
clone_and_install_dependencies() {
  if [ -d "teneo-node-bot" ]; then
    echo "${YELLOW}teneo-node-bot 目录已存在，跳过克隆。${RESET}"
  else
    echo "${BLUE}正在克隆仓库...${RESET}"
    git clone https://github.com/ziqing888/teneo-node-bot.git || { echo "${RED}克隆仓库失败${RESET}"; exit 1; }
  fi

  echo "${BLUE}进入 teneo-node-bot 目录并安装依赖...${RESET}"
  cd teneo-node-bot || { echo "${RED}无法进入 teneo-node-bot 目录${RESET}"; exit 1; }
  npm install && npm run setup || { echo "${RED}依赖安装失败${RESET}"; exit 1; }
  cd "$START_DIR"
  echo "${GREEN}依赖安装完成！${RESET}"
}

# 编辑账户配置
edit_accounts() {
  echo "${BLUE}打开账户配置文件 (account.js) 进行编辑...${RESET}"
  nano teneo-node-bot/accounts.js
}

# 编辑代理配置
edit_proxies() {
  echo "${BLUE}打开代理配置文件 (proxy.js) 进行编辑...${RESET}"
  nano teneo-node-bot/proxy.js
}

# 配置是否使用代理
edit_use_proxy() {
  echo "${BLUE}打开代理配置文件 (config.js) 进行编辑...${RESET}"
  nano teneo-node-bot/config.js
}

# 启动项目
start_project() {
  echo "${BLUE}进入 teneo-node-bot 目录并启动 Teneo 节点机器人...${RESET}"
  cd teneo-node-bot || { echo "${RED}无法进入 teneo-node-bot 目录${RESET}"; exit 1; }
  npm run start || { echo "${RED}启动失败${RESET}"; exit 1; }
  cd "$START_DIR"
}

# 主逻辑
while true; do
  show_menu
  read -p "请选择一个选项 (1-6): " choice
  case $choice in
    1)
      clone_and_install_dependencies
      ;;
    2)
      edit_accounts
      ;;
    3)
      edit_proxies
      ;;
    4)
      edit_use_proxy
      ;;
    5)
      start_project
      ;;
    6)
      echo "${YELLOW}退出脚本。${RESET}"
      exit 0
      ;;
    *)
      echo "${RED}无效选项，请重新选择。${RESET}"
      ;;
  esac
done
