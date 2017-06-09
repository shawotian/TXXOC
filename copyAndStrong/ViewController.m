//
//  ViewController.m
//  copyAndStrong
//
//  Created by 小河 on 2017/5/27.
//  Copyright © 2017年 小河. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSString *strongStr;//错 为了防止赋值给它的是可变的数据，如果可变的数据发生了变化，那么该property也会发生变化。
@property(nonatomic,copy)NSString *coStr;//对
@property(nonatomic,strong)NSMutableString *strongNsMutableStr;//对
@property(nonatomic,copy)NSMutableString *coNsMutableStr;//错 可变字符串如果用copy修饰，值就不会改变，达不到可变的效果


@property (strong, nonatomic) NSArray *strongArr;
@property (copy, nonatomic) NSArray *copArr;
@property (strong, nonatomic) NSMutableArray *strongNsMutableArr;
@property (copy, nonatomic) NSMutableArray *copNsMutableArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /**
     
     在定义一个类的property时候，为property选择strong还是copy特别注意和研究明白的，如果property是NSString或者NSArray及其子类的时候，最好选择使用copy属性修饰。为什么呢？这是为了防止赋值给它的是可变的数据，如果可变的数据发生了变化，那么该property也会发生变化。
     
     说到底，其实就是不同的修饰符，对应不同的setter方法，
     1. strong对应的setter方法，是将_property先release（_property release），然后将参数retain（property retain），最后是_property = property。
     2. copy对应的setter方法，是将_property先release（_property release），然后拷贝参数内容（property copy），创建一块新的内存地址，最后_property = property。
     
     */
    [self testStringCopyOrStrong];
    
    [self testArrayCopyOrStrong];

    
}
//测试字符串用strong还是copy
-(void)testStringCopyOrStrong
{
    
    NSMutableString *mutstr = [NSMutableString stringWithFormat:@"给不可变字符串赋值：String"];
    
    //给copy strong 分别赋值可变字符串
    self.strongStr = mutstr;
    self.coStr = mutstr;
    
    //改编可变字符串的值
    [mutstr appendString:@"++++++something"];
    
    NSLog(@"self.strongStr:%p %@",self.strongStr,self.strongStr);
    NSLog(@"self.coStr:%p %@",self.coStr,self.coStr);
    
    
    NSMutableString *mutstr2 = [NSMutableString stringWithFormat:@"给不可变字符串赋值：String"];
    self.strongNsMutableStr = mutstr2;
    self.coNsMutableStr = mutstr2;
    
    //改编可变字符串的值
    [mutstr2 appendString:@"++++++something2"];
    
    NSLog(@"%p %@",self.strongNsMutableStr,self.strongNsMutableStr);
    NSLog(@"%p %@",self.coNsMutableStr,self.coNsMutableStr);
}
//测试数组用strong还是copy
-(void)testArrayCopyOrStrong
{
    //不可变数组用copy还是strong
    NSMutableArray *books = [@[@"book1"] mutableCopy];
    self.strongArr = books;
    self.copArr = books;
    [books addObject:@"book2"];
    
    NSLog(@"strongArr:%p %@",self.strongArr,self.strongArr);
    NSLog(@"copArr:%p %@",self.copArr,self.copArr);
    
    //可变数组用strong还是copy
    NSMutableArray *mutbooks = [@[@"mutbook1"] mutableCopy];
    self.strongNsMutableArr = mutbooks;
    self.copNsMutableArr = mutbooks;
    [mutbooks addObject:@"mutbook2"];
    
    NSLog(@"strongNsMutableArr:%p %@",self.strongNsMutableArr,self.strongNsMutableArr);
    NSLog(@"copNsMutableArr:%p %@",self.copNsMutableArr,self.copNsMutableArr);
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
