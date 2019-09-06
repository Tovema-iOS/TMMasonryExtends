# TMMasonryExtends

TMMasonryExtends 是一个 Masonry 扩展库，可以用它为视图显示和隐藏状态设置不同的约束。

封装这个库主要是为了解决视图显示、隐藏的时候引入的大量条件判断和约束变更的代码。

![预览图](./Doc/imgs/preview.png)

## Usage

``` objc
#import <TMMasonryExtends/TMMasonryExtends.h>


[self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // self.imageView 隐藏时，顶部间距自动设置为 0
    make.top.equalTo(self.btnToggle.mas_bottom).offset(50).tm_collapseWhenHidden(self.imageView);
    // self.imageView 隐藏时，高度设置为 0
    make.height.mas_equalTo(0).tm_installWhenHidden(self.imageView);
    // self.imageView 显示时，高度设置为 120
    make.height.mas_equalTo(120).tm_installWhenShow(self.imageView);
    make.height.with.equalTo(self.imageView.mas_width);
    make.centerX.mas_offset(0);
}];
```

## Requirements

iOS 8.0


## Installation

TMMasonryExtends is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/Tovema-iOS/Specs.git'
source 'https://github.com/CocoaPods/Specs.git'

pod 'TMMasonryExtends', '~> 0.1.0'
```

## Author

lxb_0605@qq.com

## License

TMMasonryExtends is available under the MIT license. See the LICENSE file for more info.
