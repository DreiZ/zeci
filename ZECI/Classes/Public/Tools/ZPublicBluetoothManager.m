//
//  ZPublicBluetoothManager.m
//  ZECI
//
//  Created by zzz on 2018/8/16.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZPublicBluetoothManager.h"
#import "ZBluetoothLostView.h"
#import "ZBluetoothPowerOffView.h"

// 蓝牙4.0设备名
static NSString * const kBlePeripheralName = @"LanQianTech";
// 蓝牙4.0设备名
static NSString * const kBlePeripheralNameECI = @"ECI";

// 通知服务
static NSString * const kNotifyServerUUID = @"FFF0";
// 通知特征值
static NSString * const kNotifyCharacteristicUUID = @"FFF1";



@interface ZPublicBluetoothManager ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong) ZBluetoothLostView *lostView;
@property (nonatomic,strong) ZBluetoothPowerOffView *powerOffView;
@property (nonatomic,assign) BOOL isConnectLost;
@end

@implementation ZPublicBluetoothManager
+ (ZPublicBluetoothManager *)shareInstance {
    static ZPublicBluetoothManager *publicBluetoothManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicBluetoothManager = [[ZPublicBluetoothManager alloc] init];
    });
    return publicBluetoothManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self centralManager];
    }
    return self;
}

#pragma mark lazy loading...
- (NSMutableArray *)peripherals
{
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    return _peripherals;
}

- (CBCentralManager *)centralManager
{
    if (!_centralManager)
    {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey:@NO}];
    }
    return _centralManager;
}


- (ZBluetoothLostView *)lostView {
    if (!_lostView) {
        
        _lostView = [[ZBluetoothLostView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    }
    
    _lostView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    return _lostView;
}

- (ZBluetoothPowerOffView  *)powerOffView {
    if (!_powerOffView) {
        
        _powerOffView = [[ZBluetoothPowerOffView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    }
    
    _powerOffView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    return _powerOffView;
}


#pragma mark 蓝牙设备相关操作
// 扫描设备
- (void)scanForPeripherals
{
    
    if (self.peripheralState ==  CBManagerStatePoweredOn)
    {
        [self.centralManager stopScan];
        [self.peripherals removeAllObjects];
        if (_findChangeBlock) {
            _findChangeBlock();
        }
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    } else if (self.peripheralState ==  CBManagerStatePoweredOff){
        
        BOOL isLoaded = (BOOL)[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowPowerOffAlert"];
        if (!isLoaded ) {
            self.powerOffView.titleLabel.text = @"蓝牙未开启";
            self.powerOffView.alertLabel.text = [NSString stringWithFormat:@"请检查%@蓝牙是否正常开启，如还需测量，请去【设置】>【蓝牙】中打开蓝牙，打开蓝牙后再扫描蓝牙设备",[ZPublicManager getIsIpad] ? @"iPad":@"手机"];
            [[AppDelegate App].window addSubview:self.powerOffView];
        }
        
    }
}

// 连接设备
- (void)connectToPeripheral
{
    if (self.cbPeripheral != nil)
    {
        self.isConnectLost = YES;
        NSLog(@"连接设备");
        [self showMessage:@"连接设备"];
        [self.centralManager connectPeripheral:self.cbPeripheral options:nil];
    }
    else
    {
        [self showMessage:@"无设备可连接"];
    }
}

// 清空设备
- (void)clearPeripherals
{
    NSLog(@"清空设备");
    [self.peripherals removeAllObjects];
    [self showMessage:@"清空设备"];
    
    if (self.cbPeripheral != nil)
    {
        // 取消连接
        NSLog(@"取消连接");
        [self showMessage:@"取消连接"];
        self.isConnectLost = YES;
        [self.centralManager cancelPeripheralConnection:self.cbPeripheral];
    }
}


// 状态更新时调用
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStateUnknown:{
            NSLog(@"为知状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"重置状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"不支持的状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"未授权的状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"关闭状态");
            self.peripheralState = central.state;
        }
            break;
        case CBManagerStatePoweredOn:
        {
            NSLog(@"开启状态－可用状态");
            self.peripheralState = central.state;
            NSLog(@"%ld",(long)self.peripheralState);
        }
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"zzz 设备状态更新");
        if (self.bluetoothChangeBlock) {
            self.bluetoothChangeBlock();
        }
    });
}

/**
 扫描到设备
 
 @param central 中心管理者
 @param peripheral 扫描到的设备
 @param advertisementData 广告信息
 @param RSSI 信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    [self showMessage:[NSString stringWithFormat:@"发现设备,设备名:%@",peripheral.name]];
    NSLog(@"%@",[NSString stringWithFormat:@"发现设备,设备名:%@",peripheral.name]);
    
    if (![self.peripherals containsObject:peripheral] && peripheral.name)
    {
        if ( [peripheral.name hasPrefix:kBlePeripheralName] || [peripheral.name hasPrefix:kBlePeripheralNameECI])
        {
            [self.peripherals addObject:peripheral];
            [self showMessage:[NSString stringWithFormat:@"设备名:%@",peripheral.name]];
            self.cbPeripheral = peripheral;
        }
    }
    
    if (self.findChangeBlock) {
        self.findChangeBlock();
    }
}

/**
 连接失败
 
 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [[AppDelegate App].window showSuccessWithMsg:@"连接失败"];
    if (self.connectBlock) {
        self.connectBlock(nil);
    }
    
    if ( [peripheral.name hasPrefix:kBlePeripheralName] || [peripheral.name hasPrefix:kBlePeripheralNameECI])
    {
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

/**
 连接断开
 
 @param central 中心管理者
 @param peripheral 连接断开的设备
 @param error 错误信息
 */

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [self showMessage:@"断开连接"];
 
//    [[AppDelegate App].window showSuccessWithMsg:@"断开连接"];
    if (!self.isConnectLost) {
        self.lostView.titleLabel.text = @"设备已断开连接";
        self.lostView.alertLabel.text = @"请检查设备是否正常开启，如还需测量，请重新连接扫描蓝牙设备,并连接设备";
        [[AppDelegate App].window addSubview:self.lostView];
    }
    
    if (self.connectBlock) {
        self.connectBlock(nil);
    }
    if ( [peripheral.name hasPrefix:kBlePeripheralName] || [peripheral.name hasPrefix:kBlePeripheralNameECI])
    {
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
    self.isConnectLost = NO;
}

/**
 连接成功
 
 @param central 中心管理者
 @param peripheral 连接成功的设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //    self.peripheralText.text = [NSString stringWithFormat:@"连接设备:%@成功",peripheral.name];
    [self showMessage:[NSString stringWithFormat:@"连接设备:%@成功",peripheral.name]];
    // 设置设备的代理
    peripheral.delegate = self;
    // services:传入nil  代表扫描所有服务
    [peripheral discoverServices:nil];
    if (self.connectBlock) {
        self.connectBlock(peripheral);
    }
    [self.centralManager stopScan];
}


/**
 扫描到服务
 
 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历所有的服务
    for (CBService *service in peripheral.services)
    {
        // 获取对应的服务
        if ([service.UUID.UUIDString isEqualToString:kNotifyServerUUID])
        {
            // 根据服务去扫描特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

/**
 扫描到对应的特征
 
 @param peripheral 设备
 @param service 特征对应的服务
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 遍历所有的特征
    for (CBCharacteristic *characteristic in service.characteristics)
    {
//        NSLog(@"zzz 特征值:%@",characteristic.UUID.UUIDString);
        if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
        {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            if (self.testMatchingBlock) {
                self.testMatchingBlock();
            }
        }
    }
}

/**
 根据特征读到数据
 
 @param peripheral 读取到数据对应的设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
    {
        NSData *data = characteristic.value;
        
        NSString *testData  = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        if (self.testDataBlock) {
            self.testDataBlock(testData);
        }
//        NSLog(@"zzz 特征中数据 ：%@  = %@",data,testData);
    }
}

- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}


- (void)showMessage:(NSString *)message
{
//    [[AppDelegate App].window showSuccessWithMsg:message];
}
@end
