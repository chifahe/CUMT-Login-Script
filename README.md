# CUMT-Login-Script

**_本人目前已离校实习，无法测试该脚本，因此有任何问题欢迎在 issue 中提出！我会尽快改正的！_** 🥰

该脚本用于在您的操作系统上安装/卸载自动登录校园网脚本，目前支持 Windows 和 Linux。<br>
**脚本很容易被篡改，因此使用前请确保其中没有窃取您的账户和密码的内容！**

iOS、iPadOS 和 macOS 的登录脚本可以试试[J1an](https://github.com/Jlan45)大佬的[快捷指令](https://www.icloud.com/shortcuts/75b60062ac5e4d6c970bcf8f0e89be5e)。

## 优点

1. 使用的是 crontab 来设置定时任务，所以 OpenWrt 也可以用。
2. 该脚本无需任何依赖（一般 Linux 发行版都有 crontab 吧…？）、体积小、而且源码完全开放，相比手动登录和发行的登录软件个人认为有相当的优势。
3. 全程**无需**管理员/root 用户权限。

## 使用方法

### Windows

下载`setup-windows.bat`文件到设备上，并执行。

### Linux

下载`setup-linux.sh`文件到设备上，并在终端里执行。

## 原理

通过输入的账户、密码和运营商生成一个登录的目标 url，再用 curl 去访问它。直接用浏览器访问也是一样的。

### Windows

-   在`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\`文件夹下，创建`CUMT-Login-Script.bat`文件，实现开机自启。
-   用 schtasks 指令添加一个每天早上 7:15 执行登录脚本的计划任务。

### Linux

-   用 crontab 实现开机 1 分钟后 和 每天早上 7:15 执行登录校园网指令。
