//
//  GraphTests.m
//  GraphTests
//
//  Created by Ronaldo Faria Lima on 20/04/14.
//  Copyright (c) 2014 Ronaldo Faria Lima. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Graph.h"

@interface GraphTests : XCTestCase

@end

@implementation GraphTests
{
    NSArray *vertexes;
    NSDictionary *mapping;
    Graph *graph;
}

- (void)setUp
{
    [super setUp];
    vertexes = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G"];
    mapping = @{@"A":@[@"B", @"C"], @"B":@[@"F"], @"C":@[@"D"], @"D":@[@"E"], @"E":@[@"F"], @"F":@[@"G"]};
    // Mapping builds the following graph:
    // A -> B -> F -> G
    // |         ^
    // V         |
    // C -> D -> E
    graph = [[Graph alloc] initWithMapping:mapping];
}

- (void)tearDown
{
    [super tearDown];
}

// Test graph initialization by using a graph mapping
- (void)testGraphInitialization
{
    XCTAssertEqual(graph.allVertexes.count, 7, @"Wrong number of vertexes");
}

// Test graph addMapping: method
- (void)testGraphAddMapping
{
    Graph *aGraph = [[Graph alloc] init];
    [aGraph addMapping:mapping];
    XCTAssertEqual(aGraph.allVertexes.count, 7, @"Wrong number of vertexes");
}

// Test vertex addition method
- (void)testVertexAdd
{
    [vertexes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [graph addVertex:obj];
    }];
    XCTAssertEqual(graph.allVertexes.count, 7, @"Wrong number of vertexes. Found %d", graph.allVertexes.count);
}

// Test edge addition
- (void)testEdgeAddition
{
    for (NSString *vertex in mapping) {
        NSArray *edges = mapping[vertex];
        [edges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [graph addEdgeFromVertex:vertex toVertex:obj];
        }];
    }
    XCTAssertEqual(graph.allVertexes.count, 7, @"Wrong number of vertexes. Found %d", graph.allVertexes.count);
}

// Test edges from a given vertex
- (void)testEdges
{
    for (NSString *vertex in mapping) {
        NSSet *edges = [graph edgesForVertex:vertex];
        NSInteger expectedCount = [mapping[vertex] count];
        XCTAssertEqual(edges.count, expectedCount, @"Wrong number of edges. Expected: %d - Found: %d", expectedCount, edges.count);
    }
}


@end
