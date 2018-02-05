//
//  MapViewController.m
//  HelloWorld
//
//  Created by test on 17/12/20.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "Masonry.h"

@interface MapViewController ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mapView];
    
    [self lxt_updateContraints];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}

- (void)dealloc
{
    _mapView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)lxt_updateContraints{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark BaiduMapDelegate
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
   
}
- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate
{
  
    
}
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
  
}

#pragma mark - getter setter

- (BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] init];
//        _mapView.mapType = BMKMapTypeSatellite;
        _mapView.zoomLevel = 14;
        _mapView.logoPosition = BMKLogoPositionRightTop;
    }
    
    return _mapView;
}


@end
