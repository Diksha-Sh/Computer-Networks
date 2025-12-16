//=================================================================
// Experiment : Hybrid Topology using Bus + Star + Tree
// Nodes      : 25
// Platform   : Scilab 6.0.0 (64-bit) Windows
// Toolbox    : NARVAL
//=================================================================

clear;
clc;

//---------------------------------------------------------------
// a. Create Hybrid Topology
//---------------------------------------------------------------
NameOfNetwork = 'Hybrid Topology (Bus + Star + Tree)';
NumberOfNodes = 25;

//---------------- BUS (1–8) ----------------
BusStart = [1 2 3 4 5 6 7];
BusEnd   = [2 3 4 5 6 7 8];

//---------------- STAR (center = 4) --------
StarStart = [9 10 11 12 13 14 15 16];
StarEnd   = [4 4 4 4 4 4 4 4];

//---------------- TREE (root = 6) ----------
TreeStart = [17 18 19 20 21 22 23 24 25];
TreeEnd   = [6 6 17 17 18 18 19 19 20];

// Combine all edges
StartingNodesOfConnection = [BusStart StarStart TreeStart];
EndingNodesOfConnection   = [BusEnd   StarEnd   TreeEnd];

//---------------------------------------------------------------
// Node Coordinates
//---------------------------------------------------------------
XCoordinatesOfNodes = [
  200 300 400 500 600 700 800 900, ...     // Bus
  500 450 550 500 450 550 480 520, ...     // Star
  600 550 650 520 580 620 680 700 750      // Tree
];

YCoordinatesOfNodes = [
  500 500 500 500 500 500 500 500, ...
  650 700 700 600 600 600 750 750, ...
  350 300 300 250 250 250 250 200 200
];

//---------------------------------------------------------------
// Create Graph
//---------------------------------------------------------------
TopologyGraph = NL_G_MakeGraph( ...
    NameOfNetwork, ...
    NumberOfNodes, ...
    StartingNodesOfConnection, ...
    EndingNodesOfConnection, ...
    XCoordinatesOfNodes, ...
    YCoordinatesOfNodes ...
);

//---------------------------------------------------------------
// a. Display the created topology
//---------------------------------------------------------------
WindowIndex = 1;
NL_G_ShowGraph(TopologyGraph, WindowIndex);
xtitle("Hybrid Topology (Bus + Star + Tree)", "X-Nodes", "Y-Nodes");

//---------------------------------------------------------------
// b. Number the nodes and edges
//---------------------------------------------------------------
WindowIndex = 2;
NL_G_ShowGraphNE(TopologyGraph, WindowIndex);
xtitle("Hybrid Topology with Node & Edge Numbers", "X-Nodes", "Y-Nodes");

//---------------------------------------------------------------
// c. Colour the nodes and edges
//---------------------------------------------------------------
NodeColor = 5;          // Red nodes
BorderThickness = 10;
NodeDiameter = 25;

NL_G_HighlightNodes(TopologyGraph, 1:25, NodeColor, BorderThickness, NodeDiameter, 3);
xtitle("Coloured Nodes", "X-Nodes", "Y-Nodes");

EdgeColor = 3;          // Green edges
EdgeWidth = 5;
NL_G_HighlightEdges(TopologyGraph, 1:length(StartingNodesOfConnection), EdgeColor, EdgeWidth, 4);
xtitle("Coloured Edges", "X-Nodes", "Y-Nodes");

//---------------------------------------------------------------
// d. Print number of edges for each node
//    and node with maximum edges
//---------------------------------------------------------------
disp("Node Degree (Number of edges per node):");

MaxEdges = 0;
MaxNode = 0;

for i = 1:NumberOfNodes
    EdgeList = NL_G_EdgesOfNode(TopologyGraph, i);
    EdgeCount = length(EdgeList);
    disp("Node " + string(i) + " has " + string(EdgeCount) + " edges");
    
    if EdgeCount > MaxEdges then
        MaxEdges = EdgeCount;
        MaxNode = i;
    end
end

disp("Node with maximum edges:");
disp("Node " + string(MaxNode) + " with " + string(MaxEdges) + " edges");

//---------------------------------------------------------------
// e. Print total number of nodes and edges
//---------------------------------------------------------------
[TotalNodes, TotalEdges] = NL_G_GraphSize(TopologyGraph);

disp("Total Number of Nodes: ");
disp(TotalNodes);

disp("Total Number of Edges: ");
disp(TotalEdges);
