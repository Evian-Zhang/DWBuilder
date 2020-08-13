# macOS Mojave 动态壁纸生成器 DWBuilder 下载及使用说明
## 下载与安装

## macOS 11.0及以上

支持macOS 11.0及以上的DWBuilder（x86_64, arm64）下载地址：<https://github.com/Evian-Zhang/DWBuilder/releases/latest/download/DWBuilder.zip>

## macOS 10.15及以下

支持macOS 10.15及以下的DWBuilder下载地址：<https://github.com/Evian-Zhang/DWBuilder/releases/download/v1.1/DWBuilder.dmg>

## 使用说明
DWBuilder可以生成用户自定义的macOS Mojave支持的动态壁纸。<br>
本程序在设计的时候借鉴了 https://itnext.io/macos-mojave-dynamic-wallpaper-fd26b0698223 的思想，增加了UI，并增加了太阳高度角及太阳方位角的自动计算。<br>

### macOS Mojave 动态壁纸原理
动态壁纸扩展名为.heic, 格式为HEIF格式（High Efficiency Image File Format）,是苹果公司近年来用于存储图片的一种高效图片格式。其编码和解码的工作
已有Nokia相关技术人员完成，可以参看 https://github.com/nokiatech/heif .<br>
每一张系统自带的动态壁纸由16张图片组成，其存储的信息为拍摄该图片时的太阳高度角(elevation)及太阳方位角(azimuth).当用户的Mac所处地点的太阳高度角和太阳方位角
达到对应的角度时，就会自动更换壁纸。这解决了以往动态壁纸无法精确切换白天和黑夜的不足。

### DEMO

我拿了我们东大的李文正图书馆的照片（拍摄+修图：我）和中国传统的天色计时法各做了一个demo，可在 https://github.com/Evian-Zhang/DWBuilder/tree/master/demo 下载。

### 问题反馈

开发者邮箱：evianzhang1999@gmail.com
