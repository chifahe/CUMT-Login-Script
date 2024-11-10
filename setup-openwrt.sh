echo 该脚本是校园网自动登录脚本的安装程序，安装前请备份crontab的内容，以免不必要的损失。
echo 安装时会询问您的账户、密码和运营商，因此请注意不要随便使用从不明渠道下载的该脚本。
echo OpenWrt版暂时不支持卸载，不再需要时请您自行删除。

echo 请输入账号：
read account

echo 请输入密码：
read password

echo 您的运营商是？（请输入选项前的数字）
options=("电信" "移动" "联通")
select opt in ${options[@]}
do
    case $opt in
        "电信")
            operator=telecom
            break
            ;;
        "移动")
            operator=cmcc
            break
            ;;
        "联通")
            operator=unicom
            break
            ;;
        *) echo 不存在该选项;;
    esac
done

# 向crontab配置文件中写入脚本
cat > /etc/crontabs/root << EOF
# 校园网登录指令开始
15 7 * * * curl "http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=${account}%40${operator}&user_password=${password}"
# 结束
EOF

# TODO: 添加一个开机自动登录的计划
# 但我觉得路由器也不会经常在大白天重启，开机自启的意义或许不是特别大？

echo 安装完成！