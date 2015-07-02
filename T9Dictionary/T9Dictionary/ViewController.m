//
//  ViewController.m
//  T9Dictionary
//
//  Created by Shekhar Sasikumar on 7/2/15.
//  Copyright (c) 2015 Myaango. All rights reserved.
//

#import "ViewController.h"
#import "Tree.h"
#import "FileReader.h"
#import "KeyPadCell.h"

@interface ViewController ()<TreeDelegate>
{
    int gridCount;
    NSMutableArray *array;
    NSString *predictedWord;
    NSString *buttonPattern;
    int predictionCount;
}

@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property(nonatomic,strong) NSMutableArray *cellItems;
@property (weak, nonatomic) IBOutlet UICollectionView *cvKeyPad;
@property (weak, nonatomic) IBOutlet UIButton *btnNextPrediction;
@property (weak, nonatomic) IBOutlet UILabel *lblWord;
- (IBAction)btnNextPredictionClicked:(id)sender;
- (IBAction)btnClearClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cvKeyPad registerNib:[UINib nibWithNibName:@"KeyPadCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    predictedWord = [[NSString alloc]init];
    buttonPattern = [[NSString alloc]init];
    predictionCount = 0;
    gridCount = 9;
    [self parseData];
    Tree *tree = mTree;
    for (NSString *string in array) {
        [mTree addString:string];
    }
    mTree.delegate = self;
    [self setUpInterface];
    [self.cvKeyPad reloadData];
    
//    NSString *pattern = @"2665";
//    NSDate *start = [NSDate date];
//    NSString *word = [mTree getWordFromPattern:pattern] ;
//    NSDate *end = [NSDate date];
//    NSLog(@"%@ start%@ end%@",word,start,end);

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setUpInterface
{
    self.cellItems = [NSMutableArray array];
    for (int i = 0; i < gridCount; i++) {
        CellItem *item = [[CellItem alloc]init];
        switch (i) {
            case 0:
            {
             item.alphabets = @"";
            item.number = @"1";
            }
                break;
            case 1:
            {
                item.alphabets = @"ABC";
                item.number = @"2";
            }
                break;
            case 2:
            {
                item.alphabets = @"DEF";
                item.number = @"3";
            }
                break;
            case 3:
            {
                item.alphabets = @"GHI";
                item.number = @"4";
            }
                break;
            case 4:
            {
                item.alphabets = @"JKL";
                item.number = @"5";
            }
                break;
            case 5:
            {
                item.alphabets = @"MNO";
                item.number = @"6";
            }
                break;
            case 6:
            {
                item.alphabets = @"PQRS";
                item.number = @"7";
            }
                break;
            case 7:
            {
                item.alphabets = @"TUV";
                item.number = @"8";
            }
                break;
            case 8:
            {
                item.alphabets = @"WXYZ";
                item.number = @"9";
            }
                break;
                
            default:
                break;
        }
        
        [self.cellItems addObject:item];
    }
}

- (void)parseData
{
    array = [NSMutableArray array];
    NSString* filePath = @"TopT9Words";//file path...
    NSString* fileRoot = [[NSBundle mainBundle]
                          pathForResource:filePath ofType:@"txt"];
    FileReader * reader = [[FileReader alloc] initWithFilePath:fileRoot];
    NSString * line = nil;
    while ((line = [reader readLine])) {
        line = [line stringByReplacingOccurrencesOfString:@" "
                                               withString:@""];
        NSMutableArray *lineArray = (NSMutableArray *)[line componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        array = lineArray;
    }
    
}

#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return gridCount;
}

- (KeyPadCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KeyPadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    CellItem *cellItem = [self.cellItems objectAtIndex:indexPath.row];
    if (!cell) cell = [KeyPadCell loadKeyPadCell];
    
    // Configure the cell...
    [cell setData:cellItem];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    CellItem *item = [self.cellItems objectAtIndex:indexPath.row];
    buttonPattern = [buttonPattern stringByAppendingString:item.number];
    //predictedWord = [mTree getWordFromPattern:buttonPattern andPredictionCount:predictionCount];
    self.lblWord.text = predictedWord;
    if (buttonPattern.length == 0) {
        predictedWord = @"";
    }
    //if (predictionCount == 0) {
        self.lblWord.text = buttonPattern;
   // }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNextPredictionClicked:(id)sender {
    predictionCount++;
   
    if (predictionCount > 0) {
        [self.btnNextPrediction setTitle:@"Show Next Prediction" forState:UIControlStateNormal];;
    }
    predictedWord = [mTree getWordFromPattern:buttonPattern andPredictionCount:predictionCount];
    self.lblWord.text = predictedWord;
}

- (IBAction)btnClearClicked:(id)sender {
    buttonPattern = @"";
    predictedWord = @"";
    predictionCount = 0;
    self.lblWord.text = predictedWord;
}
#pragma mark - Tree Delegate

- (void)predictionCountReset
{
    predictionCount = 0;
}
- (void)buttonPatternReset;
{
    predictionCount = 0;
    buttonPattern = @"";
    predictionCount = 0;
    predictedWord = @"";
}

@end
