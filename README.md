# XMultiTabModule-iOS

[![CI Status](https://img.shields.io/travis/lixianke1/XMultiTabModule-iOS.svg?style=flat)](https://travis-ci.org/lixianke1/XMultiTabModule-iOS)
[![Version](https://img.shields.io/cocoapods/v/XMultiTabModule-iOS.svg?style=flat)](https://cocoapods.org/pods/XMultiTabModule-iOS)
[![License](https://img.shields.io/cocoapods/l/XMultiTabModule-iOS.svg?style=flat)](https://cocoapods.org/pods/XMultiTabModule-iOS)
[![Platform](https://img.shields.io/cocoapods/p/XMultiTabModule-iOS.svg?style=flat)](https://cocoapods.org/pods/XMultiTabModule-iOS)

XMultiTabModule-iOS是支持底部异型Tab的底部导航控制器。

通过实现SSSMultiTabDelagate中的两个代理方法，可以实现Native和Web页面的自定义加载。

## Example

![](https://img14.360buyimg.com/imagetools/jfs/t1/144209/12/26794/149293/63242ae7E1bfc645f/b34109edb29e43c9.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Usage

实现以下两个协议，分别是Web和Native页面的加载

```
@protocol SSSMultiTabDelagate <NSObject>

@optional
- (UIViewController *)loadWebWithURL:(NSString *)url;
- (UIViewController *)loadNativeWithModule:(NSString *)module params:(NSString *)params;

@end
```
支持进入默认选中Tab，设置Tab的背景色

```
"tabConfig": {
    "selectIndex": 1,
    "tabBackground": "#FFFFFF"
}
```

这是单个Tab的配置
```
{
    "specialType": 0, // 是否是异形Tab，1 是，默认0非异形
    "tabType": 1, // tab类型 0是web，1是native
    "tabName": "品类秒杀", // tab描述
    "tabImage": "https://m.360buyimg.com/seckillcms/jfs/t1/209124/8/14576/8527/61cef392E721d5c8d/a14d75499c085949.png!q70.jpg.webp", // tab非选中背景图片
    "selectTabImage": "https://m.360buyimg.com/seckillcms/jfs/t1/218045/39/9722/8643/61cef38fEc4dbaffe/2713c583a730d4be.png!q70.jpg.webp", // tab选中背景图片
    "module": "openappurl:native", // 路由
    "params": "{\"title\":\"品类秒杀\"}", // 传递原生容器参数，有多少传递多少
    "link": "https://prodev.m.jd.com/mall/active/G7sQ92vWSBsTHzk4e953qUGWQJ4/index.html" // H5链接
}
```
## Requirements

iOS 9.0

## Installation

XMultiTabModule-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XMultiTabModule-iOS'
```

## Author

lixianke1, lixianke1@jd.com

## License

XMultiTabModule-iOS is available under the MIT license. See the LICENSE file for more info.
