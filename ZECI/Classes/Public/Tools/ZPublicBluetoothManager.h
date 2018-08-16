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

@property (nonatomic,strong) void (^findChangeBlock)(void);
@property (nonatomic,strong) void (^connectBlock)(CBPeripheral *cbPeripheral);
@property (nonatomic,strong) void (^testDataBlock)(NSString *testData);

+ (ZPublicBluetoothManager *)shareInstance;


// 扫描设备
- (void)scanForPeripherals;

// 连接设备
- (void)connectToPeripheral;

// 清空设备
- (void)clearPeripherals;
@end
