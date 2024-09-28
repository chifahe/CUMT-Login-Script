@ECHO OFF

SET file="%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\CUMT-Login-Script.bat"

IF EXIST %file%(    
    CHOICE /M "请问您要卸载该脚本吗？（是请输入 Y，否则 N）"
    IF ERRORLEVEL 2 EXIT
    SCHTASKS /delete /tn CUMT-Login-Script
    DEL /Q %file%
    EXIT
)

SET /P account=请输入账号：
SET /P password=请输入密码：

ECHO 1.电信
ECHO 2.移动
ECHO 3.联通
CHOICE /C 123 /M "您的运营商是？（请输入选项前的数字）"
IF ERRORLEVEL 3 SET operator="unicom"
IF ERRORLEVEL 2 SET operator="cmcc"
IF ERRORLEVEL 1 SET operator="telecom"

ECHO "curl ""http://10.2.5.251:801/eportal/?c=Portal&a=login&login_method=1&user_account=%account%%%40%operator%&user_password=%password%""" > %file%

SCHTASKS /create /tn CUMT-Login-Script /tr %file% /sc once /st 7:15
./%file%