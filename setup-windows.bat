@ECHO OFF

SET file="%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\CUMT-Login-Script.bat"

@REM 判断是否已经安装脚本
IF EXIST %file% (
    CHOICE /M "请问您要卸载该脚本吗？（是请输入 Y，否则 N）"
    IF ERRORLEVEL 2 EXIT
    SCHTASKS /delete /tn CUMT-Login-Script
    DEL /Q %file%
    ECHO 卸载完成，按任意键退出……
    PAUSE
    EXIT
)

ECHO 该脚本是Windows下校园网自动登录脚本的安装脚本。
ECHO 安装时会询问您的账户、密码和运营商，因此请注意不要随便使用从不明渠道下载的该脚本。
ECHO 如果需要卸载自动登录脚本，只需要再次执行该脚本即可。

SET /P account=请输入账号：
SET /P password=请输入密码：

ECHO 1.电信
ECHO 2.移动
ECHO 3.联通
CHOICE /C 123 /M "您的运营商是？（请输入选项前的数字）"
IF %errorlevel%==1 SET operator=telecom
IF %errorlevel%==2 SET operator=cmcc
IF %errorlevel%==3 SET operator=unicom

@REM 生成登录url，并把它写入脚本里
ECHO curl "http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=%account%%%%%40%operator%&user_password=%password%" > %file%

@REM 创建一个每天早上7:15执行的计划任务
SCHTASKS /create /tn CUMT-Login-Script /tr \"%file%\" /sc DAILY /st 07:15

ECHO 安装完成，按任意键退出……
PAUSE