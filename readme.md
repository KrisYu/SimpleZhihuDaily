### SimpeZhihuDaily

-----------

#### 最终效果

![](https://github.com/KrisYu/SimpleZhihuDaily/blob/master/gif.gif?raw=true)

#### 注意的点：

 - 项目开始于AppDelegate，重写了App入口，并非Main Storyboard.
 - info.plist 一开始就要删除从main storyboad load的选项，否则报错，同时还要让App可以arbitrary loads
 
基本模仿[Swift-ZhihuDaily](https://github.com/jxd001/Swift-ZhihuDaily),做了适当简化和适配Swift 2.2。

#### Todo:

- load界面动画 或者说 activityIndicator
- NSArray Array化