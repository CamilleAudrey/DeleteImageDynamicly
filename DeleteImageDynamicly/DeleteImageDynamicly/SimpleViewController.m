//
//  SimpleViewController.m
//  DeleteImageDynamicly
//
//  Created by 刘曼 on 15/11/10.
//  Copyright © 2015年 刘曼. All rights reserved.
//
//
#import "SimpleViewController.h"

@interface SimpleViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGRect rect;
    CGSize size;
    
    
    //    NSMutableArray *imageArray;
    //    NSMutableArray *imageUrlArray;
    UIImageView *imageView;
    UIButton *deleteButton;
    UIView * subView;
    int addcount;
    UIView *photoView;
}
@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    rect = [[UIScreen mainScreen] bounds];
    size = rect.size;
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    addcount = 0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 60, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.center = CGPointMake(size.width/2, 30);
    label.text = @"基础版";
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
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addImage{
    [self.view endEditing:YES];
    if (addcount<9) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择途径" message:@"添加图片吧" preferredStyle: UIAlertControllerStyleActionSheet];
        [self presentViewController:alertController animated:YES completion:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *AlubmAction = [UIAlertAction actionWithTitle:@"从相册选" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImageFromAlbum];
        }];
        
        UIAlertAction *CameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pickImageFromCamera];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:AlubmAction];
        [alertController addAction:CameraAction];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:@"这里最多只能选九张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"不操作");
        }];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
#pragma mark 从用户相册获取活动图片
- (void)pickImageFromAlbum
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark 从用户相机获取活动图片
- (void)pickImageFromCamera
{
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:@"相机不可连接" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"不操作");
        }];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    //允许用户进行编辑
    picker.allowsEditing = YES;
    //设置委托对象
    picker.delegate = self;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    addcount = imageArray.count;
    CGFloat leftGap = 10;
    CGFloat topGap = 0;
    CGFloat middleGap = 10;
    CGFloat imageW = (size.width - leftGap*2-middleGap*2)/3.0;
    CGFloat imageH = imageW;
    int L = addcount%3;
    int H = addcount/3;
    CGFloat imageX = leftGap + (imageW + middleGap)*L;
    //通过CGRectGetMaxY 可以得到当前控件的最大值
    CGFloat imageY =  topGap + (imageW + leftGap+10)*H;
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.tag = 100+addcount;
    [photoView addSubview:imageView];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(CGRectGetMaxX(imageView.frame)-10, CGRectGetMinY(imageView.frame)-5, 20, 20);
    deleteButton.tag = 200+addcount;
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"组-23"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(delegateImage:) forControlEvents:UIControlEventTouchUpInside];
    [photoView addSubview:deleteButton];
    
    
    UIImage *myImage=[info objectForKey:UIImagePickerControllerEditedImage];
    //    NSData *imageData = UIImagePNGRepresentation(myImage);
    //    [imageArray addObject:imageData];
    
    imageView.image = myImage;
    addcount++;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)delegateImage:(UIButton *)tmpButton{
    int index = (int)tmpButton.tag-200;
    //addcount = imageArray.count;
    NSArray *views = photoView.subviews;
    
    // 得到所有的图片数组
    NSMutableArray *imageArr = [NSMutableArray array];
    for (UIImageView *tmpImageView in views) {
        if ([tmpImageView isKindOfClass:[UIImageView class]]) {
            [imageArr addObject:tmpImageView];
        }
        
    }
    
    //得到所有的按钮数组
    NSMutableArray *buttonArr = [NSMutableArray array];
    for (UIButton *tmpButton in views) {
        if ([tmpButton isKindOfClass:[UIButton class]]) {
            [buttonArr addObject:tmpButton];
        }
    }
    
    __block CGRect newImageFrame;
    __block CGRect newButtonFrame;
    for (int j = index; j < [imageArr count]; j++)
    {
        UIImageView *obj = [imageArr objectAtIndex:j];
        __block CGRect nextImageFrame = obj.frame;
        
        UIButton *bu = [buttonArr objectAtIndex:j];
        __block CGRect nextBtFrame = bu.frame;
        
        if (j == index)
        {
            //删除这个view
            [obj removeFromSuperview];
            [bu removeFromSuperview];
            addcount--;
            
        }else{
            for (subView in views) {
                
                if (subView.tag == j+100 || subView.tag == j+200) {
                    subView.tag--;
                    
                }
                
            }
            
            
            //并且位置动画改变
            [UIView animateWithDuration:0.6 animations:^
             {
                 obj.frame = newImageFrame;
                 bu.frame = newButtonFrame;
             } completion:^(BOOL finished)
             {
                 
             }];
        }
        //记住上一个view的位置
        newImageFrame = nextImageFrame;
        newButtonFrame = nextBtFrame;
    }
    //数组移除
    [imageArr removeObjectAtIndex:index];
    //    [imageArray removeObjectAtIndex:index];
    //    [imageUrlArray removeObjectAtIndex:index];
    [buttonArr removeObjectAtIndex:index];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

