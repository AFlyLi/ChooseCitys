//
//  OneViewController.m
//  城市搜索1
//
//  Created by 邱荣贵 on 2017/10/25.
//  Copyright © 2017年 邱荣贵. All rights reserved.
//
#import "ResultTableViewController.h"

#import "OneViewController.h"

#import "SearchController.h"

#import "HeaderTableViewCell.h"

#import "Citys.h"

#import <MapKit/MapKit.h>

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#define userDefaults  [NSUserDefaults standardUserDefaults]
//RGB
#define BackgroundColor RGB(33, 192, 174)

#define BarTintColor RGB(8, 42, 72)
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)



@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating,ResultTableViewControllerCitysDelegate,HeaderTableViewCellCitysDelegate,CLLocationManagerDelegate>{
    
    SearchController *search ;
    
}

/** <#name#>*/
@property (nonatomic,strong) CLLocationManager  *locationManager;

/**
 *  定位城市
 */
@property (nonatomic, strong) NSMutableArray *localCityData;
/**
 *  热门城市
 */
@property (nonatomic, strong) NSMutableArray *hotCityData;
/**
 *  最近访问城市
 */
@property (nonatomic, strong) NSMutableArray *commonCityData;

/** <#name#>*/
@property (nonatomic,strong) UITableView  *table;

/** <#name#>*/
@property (nonatomic,strong) NSMutableArray  *data;
/** <#name#>*/
@property (nonatomic,strong) NSMutableArray  *titleData;
/** <#name#>*/
@property (nonatomic,strong) NSMutableArray  *cityData;

/** 搜索数据 Data*/
@property (nonatomic,strong) NSMutableArray  *searchData;

/** <#name#>*/
@property (nonatomic,strong) ResultTableViewController  *resultTableViewController;
@end

@implementation OneViewController

- (NSMutableArray *)data{
    
    if(!_data){
        _data = [NSMutableArray array];
    }
    return _data;
}

- (UITableView *)table{
    
    if(!_table){
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height) style:UITableViewStylePlain];
        _table.sectionIndexBackgroundColor = [UIColor clearColor];
        _table.sectionIndexColor = [UIColor redColor];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];


    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    [self.view addSubview:self.table];
    
    [self locationStart];
    
    /** 添加搜索框*/
    [self setSearchController];
    
    self.titleData = [NSMutableArray array];
    
    self.cityData = [NSMutableArray array];
    
   
    self.localCityData = [NSMutableArray array];
    self.commonCityData = [NSMutableArray arrayWithArray:[userDefaults objectForKey:@"commonCityData"]];
    self.hotCityData = [NSMutableArray arrayWithArray:@[@"北京",@"上海",@"广东",@"珠海"]];

    NSLog(@"%@---",self.commonCityData);
    
    
    
    [self.data addObject:self.localCityData];
    [self.data addObject:self.commonCityData];
    [self.data addObject:self.hotCityData];
   
    
    [self.titleData addObjectsFromArray:@[UITableViewIndexSearch, @"定位", @"最近", @"最热"]];

    NSString *path = [[NSBundle mainBundle]pathForResource:@"CityData.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        City *mod =  [City cityWithDic:obj];
        [self.data addObject:mod.citys];
        [self.titleData addObject:mod.initial];

    }];
    
}


- (void)setSearchController{
    
    self.resultTableViewController = [[ResultTableViewController alloc] init];
    self.resultTableViewController.delegate = self;
    
    search = [[SearchController alloc] initWithSearchResultsController:self.resultTableViewController];
    /** 处理搜索界面的下滑偏移问题*/
    self.definesPresentationContext = YES;
    search.searchBar.delegate = self;
    search.searchResultsUpdater = self;
    
    
    self.table.tableHeaderView = search.searchBar;

}

#pragma mark -- UISearchBarDelegate,UISearchResultsUpdating

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    UIButton *but = [searchBar valueForKey:@"_cancelButton"];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSLog(@"%@--",searchController.searchBar.text);
    
    NSString *searchString = [searchController.searchBar text];

    
    self.searchData = [NSMutableArray array];
    
    NSArray *array = [self.data subarrayWithRange:NSMakeRange(3, self.data.count - 3)];
    
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        for(Citys *cs in obj){
            
            NSRange chinese = [cs.city_name rangeOfString:searchString options:NSCaseInsensitiveSearch];
            NSRange  letters = [cs.pinyin rangeOfString:searchString options:NSCaseInsensitiveSearch];
            NSRange  initials = [cs.initials rangeOfString:searchString options:NSCaseInsensitiveSearch];
            
            if (chinese.location != NSNotFound || letters.location != NSNotFound || initials.location != NSNotFound) {
                [self.searchData addObject:cs];
            }
            //两种选择
            //            if ([city.cityName containsString:searchText] || [city.pinyin containsString:searchText] || [city.initials containsString:searchText]) {
            //                [self.searchCities addObject:city];
            //            }
            
        }

    }];
    
    
    self.resultTableViewController.data = self.searchData;
    [self.resultTableViewController.tableView reloadData];


}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section <= 2){

        return [HeaderTableViewCell returnHeighWithArray:self.data[indexPath.section]];
    }else{
        return 44;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return self.titleData[section + 1];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section <= 2){
        return 1;
    }else{
        NSArray *array = self.data[section];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(indexPath.section <= 2){
        
        static NSString *Cell = @"header";
        
        HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        if(!cell){
            cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        }
        cell.delegate = self;
        cell.array = self.data[indexPath.section];
        return cell;

    }else{
        
        static NSString *Cell = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        }
        
        NSArray *array = self.data[indexPath.section];
        Citys *mod = array[indexPath.row];
        cell.textLabel.text = mod.short_name;
        return cell;

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.data[indexPath.section];
    Citys *mod = array[indexPath.row];
    
    [self addCityName:mod.short_name];
    
}

- (void)addCityName:(NSString *)aName{
    
    if(self.commonCityData.count == 9){
        
        [self.commonCityData removeLastObject];
    }
    
    if([self.commonCityData containsObject:aName]){
        
        [self.commonCityData removeObject:aName];
    }
    
    [self.commonCityData insertObject:aName atIndex:0];
    [userDefaults setValue:self.commonCityData forKey:@"commonCityData"];
    [userDefaults synchronize];

    [self.data replaceObjectAtIndex:1 withObject:self.commonCityData];
    
    [self.table reloadData];
    
    if([self.delegate respondsToSelector:@selector(backCityName:)]){
        [self.delegate backCityName:aName];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;                               // return list of section titles to display in section index view (e.g. "ABCD...Z#")

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.titleData;
}

#pragma mark HeaderTableViewCellCitysDelegate

- (void)HeaderTableViewCell:(UITableViewCell *)HeaderTableViewCell citysName:(NSString *)name{
    
    [self addCityName:name];

}
#pragma make ResultTableViewControllerCitysDelegate

- (void)ResultTableViewController:(UITableViewController *)ResultTableViewController citysName:(NSString *)name{
    
    NSLog(@"%@---name",name);
 
    [self addCityName:name];
    
}

//开始定位
-(void)locationStart{
    //判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init] ;
        self.locationManager.delegate = self;
        //设置定位精度
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
//        if (IOS8) {
            //使用应用程序期间允许访问位置数据
            [self.locationManager requestWhenInUseAuthorization];
        // 开始定位
        [self.locationManager startUpdatingLocation];
    }else {
        //提示用户无法进行定位操作
        NSLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
        
    }
}
#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.locationManager stopUpdatingLocation];
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count >0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *currCity = placemark.locality;
             if (!currCity) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
             }
             if (self.localCityData.count <= 0) {
                
                 [self.localCityData addObject:currCity];
                 [self.data replaceObjectAtIndex:0 withObject:self.localCityData];
                 [self.table reloadData];
             }
             
         } else if (error ==nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error !=nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
         
     }];
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code ==kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    
}

@end
