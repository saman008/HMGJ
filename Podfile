# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'HMGJ' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HMGJ
    pod 'Alamofire'   #网络请求
    pod 'Kingfisher' #图片缓存
    pod 'IQKeyboardManager' #键盘管理
    pod 'YYModel' #字典转模型
    pod 'MJRefresh' #刷新控件
    pod 'SnapKit' #约束布局
    pod 'MBProgressHUD' #菊花圈
    pod 'SDWebImage'
    pod 'TTTAttributedLabel' #富文本
    pod 'KVNProgress'
    pod 'SSZipArchive' #解压包
#========oc=======    
    pod ‘QZPTool’, :git => 'https://github.com/qzp2016/QZPTool'
    pod 'ReactiveCocoa', '~> 2.5'	
    pod 'AFNetworking'
    pod 'YYWebImage'    

    pod 'YTKKeyValueStore'



    pod 'JPush' #极光推送
    # Pods for testing
   # react_path 是你react-native文件夹路径。     
  react_path = './RNUtil/node_modules/react-native'
  yoga_path = File.join(react_path, 'ReactCommon/yoga')

  pod 'React', :path => react_path, :subspecs => [
    'Core',
    'RCTText',
    'RCTImage',
    'RCTWebSocket', # needed for debugging
    'RCTNetwork'
  ]
  pod 'Yoga', :path => yoga_path

  end
