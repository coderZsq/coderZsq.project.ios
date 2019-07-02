## Example

```objc
{
    "hook-controller": "ViewController", // 获取想要hook的控制器
    "bind-list": [ // 绑定想替换的字符串列表
        "provinceLabel",
        "cityLabel",
        "areaLabel",
        "addressLabel"
    ],
    "alert-title": "「已捕获」剪贴板地址", // 自定义弹窗显示文字
    "alert-message": "是否需要一键复制 嘻嘻!",
    "alert-confirm-title": "确定"
}
```

```objc
{
    "hook-controller": "CreateAddressVC",
    "bind-list": [
        "addresscell.AreaTextField", // 如果是绑定2个控件, 自动将省市区合并
        "addresscell.addressTextView"  // KVC 可以一直通过属性查找到目标控件
    ],
    "alert-title": "「已捕获」剪贴板地址",
    "alert-message": "是否需要一键复制 嘻嘻!",
    "alert-confirm-title": "确定"
}
```
