begin_version
3
end_version
begin_metric
0
end_metric
9
begin_variable
var0
-1
2
Atom at_1(counter, fetch)
NegatedAtom at_1(counter, fetch)
end_variable
begin_variable
var1
-1
2
Atom at_1(tablered, fetch)
NegatedAtom at_1(tablered, fetch)
end_variable
begin_variable
var2
-1
2
Atom at_2(counter, fetch)
NegatedAtom at_2(counter, fetch)
end_variable
begin_variable
var3
-1
2
Atom at_2(tablered, fetch)
NegatedAtom at_2(tablered, fetch)
end_variable
begin_variable
var4
-1
2
Atom p_psi()
NegatedAtom p_psi()
end_variable
begin_variable
var5
-1
2
Atom teleported_1(counter, fetch)
NegatedAtom teleported_1(counter, fetch)
end_variable
begin_variable
var6
-1
2
Atom teleported_1(tablered, fetch)
NegatedAtom teleported_1(tablered, fetch)
end_variable
begin_variable
var7
-1
2
Atom teleported_2(counter, fetch)
NegatedAtom teleported_2(counter, fetch)
end_variable
begin_variable
var8
-1
2
Atom teleported_2(tablered, fetch)
NegatedAtom teleported_2(tablered, fetch)
end_variable
9
begin_mutex_group
1
2 0
end_mutex_group
begin_mutex_group
1
0 0
end_mutex_group
begin_mutex_group
1
4 0
end_mutex_group
begin_mutex_group
1
7 0
end_mutex_group
begin_mutex_group
1
6 0
end_mutex_group
begin_mutex_group
1
3 0
end_mutex_group
begin_mutex_group
1
8 0
end_mutex_group
begin_mutex_group
1
1 0
end_mutex_group
begin_mutex_group
1
5 0
end_mutex_group
begin_state
1
1
1
1
1
1
0
1
0
end_state
begin_goal
1
4 0
end_goal
6
begin_operator
teleport counter fetch
0
7
2 5 1 7 1 0 -1 0
2 5 1 7 1 2 -1 0
1 5 0 4 -1 0
1 7 0 4 -1 0
1 7 1 5 1 0
1 7 1 5 1 0
1 5 1 7 -1 0
0
end_operator
begin_operator
teleport tablered fetch
0
7
2 6 1 8 1 1 -1 0
2 6 1 8 1 3 -1 0
1 6 0 4 -1 0
1 8 0 4 -1 0
1 8 1 6 1 0
1 8 1 6 1 0
1 6 1 8 -1 0
0
end_operator
begin_operator
teleport2 counter fetch
0
7
2 5 1 7 1 0 -1 0
2 5 1 7 1 2 -1 0
1 5 0 4 -1 0
1 7 0 4 -1 0
1 7 1 5 -1 0
1 7 1 5 -1 0
1 5 1 7 1 0
0
end_operator
begin_operator
teleport2 tablered fetch
0
7
2 6 1 8 1 1 -1 0
2 6 1 8 1 3 -1 0
1 6 0 4 -1 0
1 8 0 4 -1 0
1 8 1 6 -1 0
1 8 1 6 -1 0
1 6 1 8 1 0
0
end_operator
begin_operator
teleport300 counter fetch
2
5 0
7 1
1
0 4 -1 0
0
end_operator
begin_operator
teleport300 tablered fetch
2
6 0
8 1
1
0 4 -1 0
0
end_operator
0
