//
//  ZPublicBluetoothManager.h
//  ZECI
//
//  Created by zzz on 2018/8/16.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface ZPublicBluetoothManager : NSObject
/// 中央管理者 -->管理设备的扫描 --连接
@property (nonatomic, strong) CBCentralManager *centralManager;
// 存储的设备
@property (nonatomic, strong) NSMutableArray *peripherals;
// 扫描到的设备
@property (nonatomic, strong) CBPeripheral *cbPeripheral;
// 蓝牙状态
@property (nonatomic, assign) CBManagerState peripheralState;

//蓝牙状态
@property (nonatomic,strong) void (^bluetoothChangeBlock)(void);
//发现设备
@property (nonatomic,strong) void (^findChangeBlock)(void);
//连接蓝牙
@property (nonatomic,strong) void (^connectBlock)(CBPeripheral *cbPeripheral);

//匹配服务及特征
@property (nonatomic,strong) void (^testMatchingBlock)(void);
//返回测量数据
@property (nonatomic,strong) void (^testDataBlock)(NSString *testData);


+ (ZPublicBluetoothManager *)shareInstance;


// 扫描设备
- (void)scanForPeripherals;

// 连接设备
- (void)connectToPeripheral;

// 清空设备
- (void)clearPeripherals;
@end
