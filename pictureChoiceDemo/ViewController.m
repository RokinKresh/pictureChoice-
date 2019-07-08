//
//  ViewController.m
//  pictureChoiceDemo
//
//  Created by llbt on 2019/6/21.
//  Copyright © 2019 robin. All rights reserved.
//

#import "ViewController.h"
#import "BaseChoseImageView.h"
#import "PreviewPhotoUseVC.h"
#import "WPhotoViewController.h"

@interface ViewController () <BaseChoseImageViewDelegate>

@property (nonatomic,strong) BaseChoseImageView *choseImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _choseImageView = [[BaseChoseImageView alloc] init];
    _choseImageView.frame = CGRectMake(0, 270, [UIScreen mainScreen].bounds.size.width, 300);
    _choseImageView.delegate = self;
    _choseImageView.picNumber = 5;
    _choseImageView.addTile.hidden = YES;
    _choseImageView.backgroundColor = [UIColor clearColor];
    _choseImageView.previewType = PreviewWithBigType;
    
    [self.view addSubview:_choseImageView];
}

- (void)choseTheImageForChoseView:(BaseChoseImageView *_Nullable)choseView {
    [self choseNewThingTwoThePicButtonPressed];
}

- (void)previewWithTheBigTypeAndThePicNumber:(NSInteger)pickNumber {
    PreviewPhotoUseVC *previewVC = [[PreviewPhotoUseVC alloc] init];
    previewVC.editImageChoice = _choseImageView;
    previewVC.startImage = pickNumber;
    [previewVC.imageArray addObjectsFromArray:_choseImageView.imageArray];
    
    //这里用导航栏推出的，预览视图的控制器的导航栏添加了删除按钮
    [self.navigationController pushViewController:previewVC animated:YES];
}

//选择要修改的图片
- (void)choseNewThingTwoThePicButtonPressed {
    //NSLog(@"相册");
    //选择多张图片
    WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
    //选择图片的最大数
    WphotoVC.selectPhotoOfMax = 5 - _choseImageView.imageArray.count;
    [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
        for (int i = 0; i < phostsArr.count; i++) {
            UIImage *itemImage = [phostsArr[i] objectForKey:@"image"];
            [self.choseImageView reloadAllitemSubviewswithImage:itemImage];
            
        }
    }];
    [self presentViewController:WphotoVC animated:YES completion:nil];
    
}


@end
