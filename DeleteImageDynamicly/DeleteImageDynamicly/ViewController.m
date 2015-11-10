//
//  ViewController.m
//  DeleteImageDynamicly
//
//  Created by 刘曼 on 15/11/9.
//  Copyright © 2015年 刘曼. All rights reserved.
//

#import "ViewController.h"
#import "SimpleViewController.h"
#import "SaveByPlistViewController.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGSize size;

    UITableView *myTableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    size = [[UIScreen mainScreen] bounds].size;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, size.width, size.height) style:UITableViewStylePlain];
    myTableView.backgroundColor = [UIColor redColor];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.contentView.backgroundColor = [UIColor cyanColor];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"基础版";
        cell.detailTextLabel.text = @"SimpleViewController";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"plist存储版";
        cell.detailTextLabel.text = @"SaveByPlistViewController";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SimpleViewController *simple = [[SimpleViewController alloc]init];
        [self presentViewController:simple animated:YES completion:nil];
    }else if(indexPath.row == 1){
        SaveByPlistViewController *simple = [[SaveByPlistViewController alloc]init];
        [self presentViewController:simple animated:YES completion:nil];
    }
}
@end
