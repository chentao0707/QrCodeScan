# More Important:

##该项目已经有了升级版本：

>* ZBar的编译项目新地址： https://github.com/SkillCollege/ZBarBuildProj
>* ZBar的示例项目新地址： https://github.com/SkillCollege/ZBarScanProj
>* ZXing3.1.0版本项目地址： https://github.com/SkillCollege/ZXingProject

如果使用ZBar解码并且使用ZXing3.1.0扫描，只需要修改ZXingProj中的DecodeHandler解码模块，将ZXing的解码换成ZBar即可

如：

```Java

private void decode(byte[] data, int width, int height) {
		Size size = activity.getCameraManager().getPreviewSize();

		// 这里需要将获取的data翻转一下，因为相机默认拿的的横屏的数据
		byte[] rotatedData = new byte[data.length];
		for (int y = 0; y < size.height; y++) {
			for (int x = 0; x < size.width; x++)
				rotatedData[x * size.height + size.height - y - 1] = data[x + y * size.width];
		}

		// 宽高也要调整
		int tmp = size.width;
		size.width = size.height;
		size.height = tmp;

		Rect rect = activity.getCropRect();

		ZBarDecoder zBarDecoder = new ZBarDecoder();
		String result = zBarDecoder.decodeCrop(rotatedData, size.width, size.height, rect.left, rect.top, rect.width(), rect.height());

		if (result != null) {
			if (null != activity.getHandler()) {
				Message msg = new Message();
				msg.obj = result;
				msg.what = R.id.decode_succeeded;
				activity.getHandler().sendMessage(msg);
			}
			// Message message = Message.obtain(activity.getHandler(),
			// R.id.decode_succeeded, result);
			// if (null != message) {
			// message.sendToTarget();
			// }
		} else {
			// Message message = Message.obtain(activity.getHandler(),
			// R.id.decode_failed);
			// if (null != message) {
			// message.sendToTarget();
			// }
			if (null != activity.getHandler()) {
				activity.getHandler().sendEmptyMessage(R.id.decode_failed);
			}
		}
	}
	
```

QrCodeScan
==========

  这是Android手机客户端关于二维码扫描的源码，使用了高效的ZBar解码库，并修复了中文乱码。

融合了ZXing代码（使用其中的相机管理功能）。

一、 使用开源ZXing扫描的缺点

1、原始代码是横屏模式，尽管可以改成竖屏，但是扫描界面的自定义和多屏幕适配不好做

2、有效扫描区域不好控制，可能是我自己技术不成熟，没找到好方法

3、ZXing是Java写的，对二维码的解析效率没有ZBar快

二、 使用iOS开发经常使用的ZBar扫描的缺点

1、 ZBar是C实现的二维码解析，但是在解析中文时会乱码

2、 ZBar的扫描界面对相机的控制没有ZXing封装的好

基于以上一些原因，笔者决定何不将二者结合起来，用ZXing来控制摄像头取得图像，用ZBar来解析扫描到的数据，最终形成目前的项目。

三、 开发步骤

  首先剥离ZXing的Camera控制代码，得到扫描的原始数据，ZXing的ViewFindView个人感觉不是很好，索性我就把它去掉了，
  
  直接通过xml文件进行布局，多屏幕的适配瞬间就解决了。并且对于扫描激光线的动画效果，横竖屏的控制都只需要稍稍变换代码即可实现。
  对于ZBar的中文乱码应该怎么解决呢？网上找了之后发现需要修改ZBar的qrcodetxt.c将里面的编码ISO-8859-1改成GBK就可以了
  
四、 使用方法

1、 Eclipse直接导入运行即可

2、 如果是在Android Studio运行，出现

    Couldn't load libzbar from loader dalvik.system.PathClassLoader findLibrary returned null

    异常的解决方法是：

    A. 把so文件放到如下目录(src/main/jniLibs/armeabi/libzbar.so)

    |src
    |--main/
    |----java/
    |----res/
    |----jniLibs/
    |------armeabi
    |--------libzbar.so

    B.Rebuild Project

    注意：如果是想要在自己的项目中直接使用项目提供的ZbarManager源码。需要保持包名一致（com.zbar.lib）

感谢@Houny提供的Android Studio下运行异常解决方法。

