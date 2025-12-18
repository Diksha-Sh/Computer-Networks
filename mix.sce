//=================================================================
// Experiment : Hierarchical Hybrid Topology using NL_T_MultiLevel
// Nodes      : 30
// Platform   : Scilab 6.0.0 (64-bit) Windows
// Toolbox    : NARVAL
//=================================================================

clear;
clc;

//---------------------------------------------------------------
// PARAMETERS FOR MULTI-LEVEL HIERARCHICAL NETWORK
//---------------------------------------------------------------

// Waxman parameters for each layer
A  = [0.3 0.3 0.3];      // alpha values
B  = [0.9 0.6 0.4];      // beta values

// Number of nodes per layer (TOTAL = 30)
Nl = [10 10 10];         // nodes per layer

// Area size per layer
L  = [800 300 120];      // square side per layer

// Max nodes per subnetwork
N  = [3 3 3];

// Number of layers
S  = 3;

// Node diameter parameters
DB = 20;    // base diameter
DD = 4;     // diameter decrement per layer

// Colours for each layer
// 2 = Blue, 5 = Red, 3 = Green
C  = [2 5 3];

//---------------------------------------------------------------
// CREATE MULTI-LEVEL HYBRID TOPOLOGY
//---------------------------------------------------------------
[G, D, Nl] = NL_T_MultiLevel(A, B, Nl, L, N, S, DB, DD, C);

//---------------------------------------------------------------
// a. DISPLAY THE CREATED TOPOLOGY
//---------------------------------------------------------------
WindowIndex = 1;
NL_G_ShowGraph(G, WindowIndex);
xtitle("Hierarchical Hybrid Topology (30 Nodes)", "X-Nodes", "Y-Nodes");

//---------------------------------------------------------------
// b. NUMBER THE NODES AND EDGES
//---------------------------------------------------------------
WindowIndex = 2;
NL_G_ShowGraphNE(G, WindowIndex);
xtitle("Node and Edge Numbering", "X-Nodes", "Y-Nodes");

//---------------------------------------------------------------
// c. COLOURING (AUTOMATIC)
//---------------------------------------------------------------
disp("NOTE: Node colours and diameters are automatically assigned per layer");

//---------------------------------------------------------------
// d. PRINT NUMBER OF EDGES PER NODE
//    AND NODE WITH MAXIMUM EDGES
//---------------------------------------------------------------
disp("Node Degree Information:");

TotalNodes = size(G.node_x, "*");

MaxEdges = 0;
MaxNode = 0;

for i = 1:TotalNodes
    EdgeList = NL_G_EdgesOfNode(G, i);
    EdgeCount = length(EdgeList);
    disp("Node " + string(i) + " has " + string(EdgeCount) + " edges");

    if EdgeCount > MaxEdges then
        MaxEdges = EdgeCount;
        MaxNode = i;
    end
end

disp("Node with Maximum Edges:");
disp("Node " + string(MaxNode) + " with " + string(MaxEdges) + " edges");

//---------------------------------------------------------------
// e. PRINT TOTAL NUMBER OF NODES AND EDGES
//---------------------------------------------------------------
[TotalNodes, TotalEdges] = NL_G_GraphSize(G);

disp("Total Number of Nodes:");
disp(TotalNodes);

disp("Total Number of Edges:");
disp(TotalEdges);
