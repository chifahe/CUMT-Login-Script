# CUMT-Login-Script

该脚本用于在您的操作系统上安装/卸载自动登录校园网脚本，目前仅支持 Windows 系统。  
**脚本很容易被篡改，因此使用前请确保其中没有窃取您的账户和密码的内容！**

`iOS`、`iPadOS`和`macOS`的登录脚本请见[J1an](https://github.com/Jlan45)大佬的[快捷指令]()

## 使用方法

### Windows

下载`setup-windows.bat`文件到本地，双击执行。

### OpenWrt

将`setup-openwrt.sh`上传到路由器，在终端里执行。

## 原理

通过输入的账户、密码和运营商生成一个登录的目标 url，再用 curl 去访问它。直接用浏览器访问也是一样的。

### Windows

-   在`%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\`文件夹下，创建`CUMT-Login-Script.bat`文件，实现开机自启功能。
-   用`schtasks`指令添加一个每天早上 7:15 执行登录脚本的计划任务。

### OpenWrt

-   向`/etc/crontabs/root`文件中写入一个每天早上 7:15 执行的登录校园网指令。
-   目前还不支持自动删除，但是在该指令前后都写了明显的注释，不需要时自行删除或注释掉即可。
