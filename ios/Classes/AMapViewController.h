//
//  AMapViewController.h
//  amap_flutter_map
//
//  Created by lly on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapViewController : NSObject<FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (void)startMovingMakerWithSecond:(CGFloat)second points:(id)points resume:(id)resume;

- (void)stopMovingMarker;

- (void)addCircleWithPoint:(id)point radius:(id)radius;

- (void)removeCircle;
@end

NS_ASSUME_NONNULL_END
