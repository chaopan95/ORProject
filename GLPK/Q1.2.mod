########################################################
####### ATHENS - GRAPH COLORING FOR AN ASSIGNMENT PROBLEM ###########
########################################################

param nbVertex, integer, > 0;
param nbEdge, integer, > 0;

set V := {1..nbVertex};
set E := {1..nbEdge};

# Adjacency matrix
param A{V, E};
# Capacity
param C1{E};
param C2{E};
# Cost
param cost1{e in E}, >= 0;
param cost2{e in E}, >= 0;
# Degree of in-flow and out-flow
param degree{v in V};


### 1. Variables ###

# Flow
var f{1..nbEdge}, >=0;

# Choice of tupe, 0 1 2
var x1{1..nbEdge}, binary;
var x2{1..nbEdge}, binary;


### 2. Constraints ###

# flow <= capacity
s.t. flowCapacity{e in 1..nbEdge}:
	f[e] <= x1[e]*C1[e] + x2[e]*C2[e];

# tupe 1 and tupe 2 are incompatble
s.t. tupeIncomp{e in 1..nbEdge}:
	x1[e] + x2[e] <= 1;

# flow out = flow in for each node
s.t. flowEquality{v in V}: sum{e in E} A[v, e]*f[e] = degree[v];


### 3. Objective function ###

minimize obj:
	sum{e in 1..nbEdge} (cost1[e]*x1[e] + cost2[e]*x2[e]);

solve;

printf "\n";
printf "----------------------\n";
printf "Total cost: %10g\n", sum{e in E} (cost1[e]*x1[e] + cost2[e]*x2[e]);
printf "----------------------\n";
printf "Each edge:\n";
printf "e\tx1\tcost1\tx2\tcost2\tflow\n";
printf {e in E} "%d\t%d\t%d\t%d\t%d\t%d\n", e, x1[e], cost1[e], x2[e], cost2[e], f[e];


data;

param nbVertex := 12;

param nbEdge := 20;


# Order of vertex
/*
's':1
'P1':2
'P2':3
'P3':4
'P4':5
'B':6
'C':7
'A':8
'E':9
'F':10
'D':11
't':12
*/

# Order of edges
/*
('s', 'P1'): 1
('s', 'P2'): 2
('s', 'P3'): 3
('s', 'P4'): 4
('P1', 'B'): 5
('P1', 'C'): 6
('P2', 'A'): 7
('P2', 'B'): 8
('P3', 'A'): 9
('P3', 'E'): 10
('P4', 'E'): 11
('P4', 'F'): 12
('A', 'D'): 13
('B', 'D'): 14
('C', 'D'): 15
('C', 't'): 16
('D', 't'): 17
('E', 'D'): 18
('E', 'F'): 19
('F', 't'): 20
*/

param A :
	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20:=
1	-1	-1	-1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
2	1	0	0	0	-1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	0
3	0	1	0	0	0	0	-1	-1	0	0	0	0	0	0	0	0	0	0	0	0
4	0	0	1	0	0	0	0	0	-1	-1	0	0	0	0	0	0	0	0	0	0
5	0	0	0	1	0	0	0	0	0	0	-1	-1	0	0	0	0	0	0	0	0
6	0	0	0	0	1	0	0	1	0	0	0	0	0	-1	0	0	0	0	0	0
7	0	0	0	0	0	1	0	0	0	0	0	0	0	0	-1	-1	0	0	0	0
8	0	0	0	0	0	0	1	0	1	0	0	0	-1	0	0	0	0	0	0	0
9	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	-1	-1	0
10	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	-1
11	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	-1	1	0	0
12	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	1
;

param : C1 :=
1	205
2	75
3	95
4	195
5	200
6	200
7	200
8	200
9	200
10	200
11	200
12	200
13	200
14	200
15	200
16	200
17	200
18	200
19	200
20	200
;

param : C2 :=
1	205
2	75
3	95
4	195
5	400
6	400
7	400
8	400
9	400
10	400
11	400
12	400
13	400
14	400
15	400
16	400
17	400
18	400
19	400
20	400
;

param : degree :=
1	-570
2	0
3	0
4	0
5	0
6	0
7	0
8	0
9	0
10	0
11	0
12	570
;

param : cost1 :=
1	0.0
2	0.0
3	0.0
4	0.0
5	14.0
6	19.0
7	9.0
8	10.0
9	12.0
10	18.0
11	26.0
12	10.0
13	25.0
14	11.0
15	8.0
16	14.0
17	15.0
18	4.0
19	7.0
20	20.0
;

param : cost2 :=
1	0.0
2	0.0
3	0.0
4	0.0
5	21.0
6	28.5
7	13.5
8	15.0
9	18.0
10	27.0
11	39.0
12	15.0
13	37.5
14	16.5
15	12.0
16	21.0
17	22.5
18	6.0
19	10.5
20	30.0
;

end;
