#!/bin/bash

# 设置颜色
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# 显示标题
echo "${YELLOW}==========================================="
echo "🚀 Teneo 自动批量创建账户安装脚本 🚀"
echo "===========================================${RESET}"

# 克隆项目库并安装依赖
setup_repository_and_dependencies() {
  if [ -d "teneo-auto-create-account" ]; then
    echo "${YELLOW}teneo-auto-create-account 目录已存在，跳过克隆。${RESET}"
  else
    echo "${BLUE}正在克隆项目库...${RESET}"
    git clone https://github.com/ziqing888/teneo-auto-create-account || { echo "${RED}克隆失败！${RESET}"; exit 1; }
  fi

  # 进入目录并安装依赖
  cd teneo-auto-create-account || { echo "${RED}无法进入项目目录${RESET}"; exit 1; }
  if ! npm list axios &>/dev/null || ! npm list chalk &>/dev/null; then
    echo "${BLUE}正在安装依赖...${RESET}"
    npm install axios chalk || { echo "${RED}依赖安装失败！${RESET}"; exit 1; }
  else
    echo "${GREEN}依赖已安装。${RESET}"
  fi
  cd ..
}

# 编辑邮箱列表
edit_email_file() {
  echo "${BLUE}编辑邮箱文件 email.txt...${RESET}"
  nano teneo-auto-create-account/email.txt
}

# 编辑配置文件
edit_config_js() {
  echo "${BLUE}编辑配置文件 config.js...${RESET}"
  nano teneo-auto-create-account/config.js
}

# 运行程序
run_script() {
  echo "${BLUE}运行批量创建账户脚本...${RESET}"
  read -p "请输入您的邀请码: " invite_code
  export INVITE_CODE=$invite_code # 设置邀请码
  cd teneo-auto-create-account || { echo "${RED}无法进入项目目录${RESET}"; exit 1; }
  node index.js
  cd ..
}

# 显示菜单
show_menu() {
  echo "${BLUE}请选择操作:${RESET}"
  echo "${GREEN}1)${RESET} 克隆项目库并安装依赖"
  echo "${GREEN}2)${RESET} 编辑邮箱列表 (email.txt)"
  echo "${GREEN}3)${RESET} 配置 config.js 文件"
  echo "${GREEN}4)${RESET} 运行批量创建账户脚本"
  echo "${GREEN}5)${RESET} 退出"
}

# 主循环
while true; do
  show_menu
  read -p "选择一个选项 (1-5): " choice
  case $choice in
    1) setup_repository_and_dependencies ;;
    2) edit_email_file ;;
    3) edit_config_js ;;
    4) run_script ;;
    5) echo "${YELLOW}退出脚本。${RESET}"; exit 0 ;;
    *) echo "${RED}无效选项，请重试。${RESET}" ;;
  esac
done
