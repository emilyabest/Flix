//
//  DetailsViewController2.m
//  Flix2
//
//  Created by emilyabest on 6/27/19.
//  Copyright © 2019 emilyabest. All rights reserved.
//

#import "DetailsViewController2.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController2 ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController2

static NSString * const reuseIdentifier = @"Cell";

/**
 Loads the view.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Fill posterView
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    // Fill backdropView
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    // Fill titleLabel, dateLabel, synopsisLabel
    self.titleLabel.text = self.movie[@"title"];
    self.dateLabel.text = self.movie[@"release_date"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    // Adjust sizing for title and synopsis
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
}

@end
