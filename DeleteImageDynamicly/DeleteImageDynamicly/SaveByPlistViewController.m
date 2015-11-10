//
//  SaveByPlistViewController.m
//  DeleteImageDynamicly
//
//  Created by 刘曼 on 15/11/10.
//  Copyright © 2015年 刘曼. All rights reserved.
//

#import "SaveByPlistViewController.h"

@interface SaveByPlistViewController ()
{
    CGSize size;
    int addcount;
    UIView *photoView;
}
@end

@implementation SaveByPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    size = [[UIScreen mainScreen] bounds].size;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    addcount = 0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 70, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.center = CGPointMake(size.width/2, 30);
    label.text = @"plist存储版";
    [self.view addSubview:label];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame), CGRectGetWidth(label.frame), CGRectGetHeight(label.frame))];
    button.center = CGPointMake(size.width/2, 50);
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitle:@"添加图片" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    photoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), size.width, size.height-CGRectGetMaxY(button.frame))];
    photoView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:photoView];
    // Do any additional setup after loading the view.
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addImage{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
