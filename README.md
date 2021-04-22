# wxc-jpush

## 安装

```shell script
eeui plugin install https://github.com/Fang-NB-Plus/wxc-jpush
```

## 卸载

```shell script
eeui plugin uninstall https://github.com/Fang-NB-Plus/wxc-jpush
```

## 参数配置

[eeui.config.js](https://eeui.app/guide/config.html) 配置如下：

```js
module.exports = {
    //......
    "jpush": {
		"JPUSH_APPID":"0ba7dd2002a3aa84c21c8371",
		"JPUSH_APPKEY":"",
		"JPUSH_APPSECRET":"",
		"XIAOMI_APPID": "",
		"XIAOMI_APPKEY": "",
		"MEIZU_APPID": "",
		"MEIZU_APPKEY": "",
		"HUAWEI_APPID": "",
		"OPPO_APPKEY": "",
		"OPPO_APPSECRET": "",
		"VIVO_APPID": "",
		"VIVO_APPKEY": ""
	},
    //......
}
```

## 引用

```js
const jpush = app.requireModule("eeuiJpush");
```
## 使用
----
### iOS 额外所需操作

![image](https://console.eeui.app/uploads/picture/1/202104/f93431ecd2301c5f7b1de173d4a8ff20.jpg)

如图所示添加iOS推送模块 更多设置请参照极光官网设置

## API

### 设置标签
```js
jpush.setTags(resulte=>{
  if(resulte === ture){
  //设置成功
  }
})
```

### 删除标签
```js
jpush.deleteTags(resulte=>{
  if(resulte === ture){
  //设置成功
  }
})
```

### 获取当前所有标签
```js
jpush.getAllTags(resulte=>{
  //resulte是一个数组对象
})
```

### 清除所有标签
```js
jpush.clearTags(resulte=>{
  if(resulte === ture){
  //清除成功
  }
})
```

### 设置别名
```js
jpush.setAlias(resulte=>{
  if(resulte === ture){
  //设置成功
  }
})
```

### 获取别名
```js
jpush.getAlias(resulte=>{
  //resulte是一个字符串
})
```

### 删除别名
```js
jpush.deleteAlias(resulte=>{
  if(resulte === ture){
  //清除成功
  }
})
```

## 监听收到通知

```js
pageMessage(data) {
  		let msg = data.message;
            
            if (msg.type === "notification"){
                //获取消息实体
                let notification = msg.data;
                console.log(notification);
            }
       },
```