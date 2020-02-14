########################################################
####### ATHENS - GRAPH COLORING FOR AN ASSIGNMENT PROBLEM ###########
########################################################

param nbVertex, integer, > 0;
param nbEdge, integer, > 0;

set V := {1..nbVertex};
set E := {1..nbEdge};

param A{V, E};
param C{E};
param cost{e in E}, >= 0;
param degree{v in V};

### 1. Variables ###

# flow
var f{1..nbEdge}, >=0;

# tupe is open or not
var x{1..nbEdge}, binary;

### 2. Constraints ###

# flow <= capacity
s.t. flowCapacity{e in 1..nbEdge}:
	f[e] <= x[e]*C[e];

# flow out = flow in for each node
s.t. flowEquality{v in V}: sum{e in E} A[v, e]*f[e] = degree[v];

### 3. Objective function ###

minimize obj:
	sum{e in 1..nbEdge} cost[e]*x[e];

solve;

printf "\n";
printf "----------------------\n";
printf "Total cost: %10g\n", sum{e in E} cost[e]*x[e];
printf "----------------------\n";
printf "Each edge:\n";
printf "e\tx\tcost\tflow\n";
printf {e in E} "%d\t%d\t%d\t%d\n", e, x[e], cost[e], f[e];

data;

param nbVertex := 12;

param nbEdge := 20;

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

param : C :=
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

param : cost :=
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

end;
