//
//  main.m
//  ObjectClassDemo
//
//  Created by liangchao on 17/10/9.
//  Copyright © 2017年 lch. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import <objc/objc.h>

@interface Animal : NSObject
@property(copy,nonatomic) NSString* name;
@end
@implementation Animal
@end

@interface Cat : Animal
@end
@implementation Cat
@end

@interface WhiteCat : Cat
- (void)speak;
@end
@implementation WhiteCat
- (instancetype) init{
    self = [super init];
    if (self) {
        id cls = [WhiteCat class];
        void *obj = &cls;
        [(__bridge id)obj speak];
    }
    return self;
}
- (void) speak{
    NSLog(@"I'm a white cat");
}
@end

@interface BlackCat : Cat
@end
@implementation BlackCat

- (instancetype) init{
    self = [super init];
    if(self){
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}

@end

@interface NSObject (Animal)
+ (void) eat;
@end
@implementation NSObject (Animal)
- (void)eat
{
    NSLog(@"IMP: -[NSObject(Animal) eat]");
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        objc_msgSend
//       objc_msgSendSuper
        
        /*
        // test case 1
        BlackCat *cat = [[BlackCat alloc]init];
        // test case 2
        BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
        BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
        BOOL res3 = [(id)[Animal class] isKindOfClass:[Animal class]];
        BOOL res4 = [(id)[Animal class] isMemberOfClass:[Animal class]];
        NSLog(@"%d %d %d %d", res1, res2, res3, res4);
        // test case 3
        [NSObject eat];
        [[NSObject new] eat];
         
         //test case 4
        [[WhiteCat alloc]init];
         */
        
        

        
        // 对象、类、元类
        
        // Cat继承自Animal类
        Cat* animal = [[Cat alloc]init];
        //类
        Class class = [animal class];
        //父类
        Class supperOfClass = [class superclass];
        Class metaOfSuperClass = object_getClass(supperOfClass);
        //元类（类的isa指向）
        Class metaOfClass = object_getClass(class);
        //元类的元类（元类的isa指向）
        Class metaOfMetaCls = object_getClass(metaOfClass);
        //元类的父类
        Class supperOfMetaCls = [metaOfClass superclass];
        //NSObject类
        Class rootObjClass = [NSObject class];
        //NSObject的父类
        Class supperOfRootCls = [rootObjClass superclass];
        //NSObject元类
        Class metaOfRootCls = object_getClass(rootObjClass);
        //NSObject元类的父类
        Class superOfRootObjMetaCls = [metaOfRootCls superclass];
      
    }
    return 0;
}

//- (BOOL)isKindOf:aClass
//{
//    Class cls;
//    for (cls = isa; cls; cls = cls->superclass){
//        if (cls == (Class)aClass)
//            return YES;
//    }
//    
//    return NO;
//}

//- (BOOL)isMemberOf:aClass
//{
//    return isa == (Class)aClass;
//}
