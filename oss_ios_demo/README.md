## oss_ios_demo
本工程给出了阿里云移动服务相关产品的IOS端的使用DEMO，欢迎参考与使用。
注：demo中的账号信息配置只为方便demo例程的运行，真实产品中我们建议您使用安全黑匣子或其他方式保障密钥的安全性。

### oss_ios_common_support
通用支持包，包括设置AK、SK、endPoint、创建temp文件等。

### oss_ios_init_demo
OSS client初始化demo

```
AliyunOSSPlaintextInitDemo，明文设置初始化client
AliyunOSSCustomInitDemo，自签名模式初始化client
AliyunOSSSTSInitDemo，Federation鉴权模式初始化client
```

### oss_upload_demo
OSS上传demo

```
AliyunOSSSimpleUploadDemo，简单上传
AliyunOSSAppendUploadDemo，追加上传
AliyunOSSMultipartUploadDemo，断点续传
AliyunOSSMD5UloadDemo，MD5校验上传
```

### oss_download_demo
OSS下载demo

```
AliyunOSSSimpleDownloadDemo，简单下载
AliyunOSSScopeDownloadDemo，指定范围下载
AliyunOSSHeaderDownloadDemo，只获取文件元数据
```


### oss_ios_demo
调用各个demo
AliyunOSSDemoTest，选择调用不同Demo
