#!/bin/bash

# 设置颜色
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RED=$(tput setaf 1)
BOLD=$(tput bold)
RESET=$(tput sgr0)

# 显示标题
echo "${CYAN}${BOLD}"
echo "╔════════════════════════════════════════════════╗"
echo "║               🚀  脚本合集 🚀                  ║"
echo "╚════════════════════════════════════════════════╝"
echo "${RESET}"

# 菜单函数
show_menu() {
  echo "${YELLOW}${BOLD}请选择操作:${RESET}"
  echo "${GREEN}1)${RESET} 批量创建账户"
  echo "${GREEN}2)${RESET} 运行 Teneo 节点机器人"
  echo "${GREEN}3)${RESET} 退出"
  echo ""
}

# 返回主菜单函数
return_to_menu() {
  echo "${BLUE}按回车键返回主菜单...${RESET}"
  read -r  # 等待用户按回车键
}

# 主逻辑
while true; do
  show_menu
  read -p "${CYAN}选择一个选项 (1-3): ${RESET}" choice
  case $choice in
    1)
      echo "${BLUE}${BOLD}下载并运行 Teneo 自动批量创建账户...${RESET}"
      [ -f "teneo-account.sh" ] && rm teneo-account.sh
      wget -q -O teneo-account.sh https://raw.githubusercontent.com/ziqing888/-bot-collection/refs/heads/main/teneo-account.sh
      chmod +x teneo-account.sh
      ./teneo-account.sh
      return_to_menu
      ;;
    2)
      echo "${BLUE}${BOLD}下载并运行 Teneo 节点机器人...${RESET}"
      [ -f "Teneo-bot.sh" ] && rm Teneo-bot.sh
      wget -q -O Teneo-bot.sh https://raw.githubusercontent.com/ziqing888/-bot-collection/refs/heads/main/Teneo-bot.sh
      chmod +x Teneo-bot.sh
      ./Teneo-bot.sh
      return_to_menu
      ;;
    3)
      echo "${YELLOW}${BOLD}退出脚本。${RESET}"
      exit 0
      ;;
    *)
      echo "${RED}${BOLD}无效选项，请重新选择。${RESET}"
      ;;
  esac
done
