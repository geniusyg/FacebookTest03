//
//  ViewController.m
//  FacebookTest03
//
//  Created by yg on 2014. 1. 21..
//  Copyright (c) 2014년 yg. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController () <FBLoginViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profileImage;
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property NSArray *data;

@end

@implementation ViewController

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
	self.profileImage.profileID = user.id;
	self.nameLabel.text = user.name;
	
	FBRequest* fr = [FBRequest requestForMyFriends];
	[fr startWithCompletionHandler:^(FBRequestConnection *conn, NSDictionary *result, NSError *error){
		self.data = [result objectForKey:@"data"];
		
		[self.table reloadData];
	}];
	
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
	NSLog(@"Logout");
	self.profileImage.profileID = nil;
	self.nameLabel.text = @"";
	self.data = nil;
	
	[self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRIENDS_CELL"];
    
    NSDictionary *one = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = one[@"name"];
	
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.loginView setReadPermissions:@[@"basic_info", @"user_friends"]];
	self.loginView.delegate = self;
	 
	[self.view addSubview:self.loginView];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




























