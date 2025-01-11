# 判断用户
user=${SUDO_USER:-$LOGNAME}

# 判断是否已经安装脚本
if [ $(grep -c "CUMT-Login-Script" /var/spool/cron/$user) -ne '0' ]; then
    echo 请问您要卸载该脚本吗？（是请输入 Y，否则 N）
    read choice
    if [ $choice == "Y" ]; then
        # 删除含有CUMT-Login-Script的行
        sed -i '/CUMT-Login-Script/d' /var/spool/cron/$user
    fi
    exit 0
fi

echo 该脚本是Linux下校园网自动登录脚本的安装程序。
echo 安装时会询问您的账户、密码和运营商，因此请注意不要随便使用从不明渠道下载的该脚本。
echo 如果需要卸载自动登录脚本，只需要再次执行该脚本即可。

echo 请输入账号：
read account

echo 请输入密码：
read password

echo 您的运营商是？（请输入选项前的数字）
options=("电信" "移动" "联通")
select opt in ${options[@]}; do
    case $opt in
    "电信")
        =
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
    *) echo 不存在该选项 ;;
    esac
done

# 向crontab配置文件中写入脚本
file="~/CUMT-Login-Script.cron"
cat >$file <<EOF
@reboot sleep 60 && curl "http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=${account}%40${operator}&user_password=${password}" # CUMT-Login-Script
15 7 * * * curl "http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=${account}%40${operator}&user_password=${password}" # CUMT-Login-Script
EOF
crontab $file

echo 安装完成！
