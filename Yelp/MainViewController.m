//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCellTableViewCell.h"
#import "FilterViewController.h"


NSString * const kYelpConsumerKey = @"cdYgtulMSKrzeNso6m3ymQ";
NSString * const kYelpConsumerSecret = @"rHOBrhLqQN81x1GsJbbCcUkEn-c";
NSString * const kYelpToken = @"uOtoyfSOakmfhaYKpePO6V6yrVqKCUZM";
NSString * const kYelpTokenSecret = @"B0Bq1bYurxgMA248HCbS2cbdqb4";

/*
NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";
*/


/*
NSString * const kYelpConsumerKey = @"msoreE5hy5AYOnfx5IZN2w";
NSString * const kYelpConsumerSecret = @"ezapqrAJFpdt2Jwc96RJPx__jZ0";
NSString * const kYelpToken = @"5kkSkntscwI0LvaiE_efZk0ZtL2ipiBP";
NSString * const kYelpTokenSecret = @"xQAmvDB3DqguX85wwIitZs_PfbU";
*/

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate,FilterViewControllerDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSDictionary *filters;

-(void)fetchBusinessesWithDictionary:(NSString *)query params:(NSDictionary *)params;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.searchBar = [[UISearchBar alloc] init];
        self.searchBar.delegate = self;
        self.navigationItem.titleView = self.searchBar;
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self fetchBusinessesWithDictionary:@"Restaurants" params:nil];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessCellTableViewCell"];
    
    self.tableView.rowHeight = 90;
    self.tableView.sectionFooterHeight = 0.0;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Yelp";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCellTableViewCell"];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// search bar methods
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES];
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO];
    
    if (![self.searchBar.text isEqualToString:@""]) {
        [self fetchBusinessesWithDictionary:self.searchBar.text params:self.filters];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar endEditing:YES];
}

-(void) fetchBusinessesWithDictionary:(NSString *)query params:(NSDictionary *)params {
    
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        //NSLog(@"self.businesses: %@", self.businesses);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}

-(void)filtersViewController:(FilterViewController *)filtersViewController didChangeFilters:(NSDictionary *)filters {
    NSLog(@"fire new network event%@",filters);
    self.filters = filters;
    [self fetchBusinessesWithDictionary:@"Restaurants" params:self.filters];
}

-(void)onFilterButton {
    FilterViewController *vc = [[FilterViewController alloc]init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

@end
