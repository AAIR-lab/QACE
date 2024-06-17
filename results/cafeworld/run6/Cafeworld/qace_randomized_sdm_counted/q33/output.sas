begin_version
3
end_version
begin_metric
0
end_metric
4
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
3
Atom at_2(counter, fetch)
Atom at_2(tablered, fetch)
<none of those>
end_variable
begin_variable
var3
-1
2
Atom p_psi()
NegatedAtom p_psi()
end_variable
4
begin_mutex_group
2
2 0
2 1
end_mutex_group
begin_mutex_group
1
3 0
end_mutex_group
begin_mutex_group
1
0 0
end_mutex_group
begin_mutex_group
1
1 0
end_mutex_group
begin_state
0
1
0
1
end_state
begin_goal
1
3 0
end_goal
8
begin_operator
move counter tablered fetch
0
7
1 2 0 0 0 1
2 0 0 2 0 1 -1 0
2 0 0 2 0 1 -1 0
2 0 0 2 0 2 -1 1
1 0 1 3 -1 0
1 2 1 3 -1 0
1 2 2 3 -1 0
0
end_operator
begin_operator
move tablered counter fetch
0
7
2 1 0 2 1 0 -1 0
2 1 0 2 1 0 -1 0
1 2 1 1 0 1
2 1 0 2 1 2 -1 0
1 1 1 3 -1 0
1 2 0 3 -1 0
1 2 2 3 -1 0
0
end_operator
begin_operator
move2 counter tablered fetch
0
7
1 2 0 0 -1 1
2 0 0 2 0 1 -1 0
2 0 0 2 0 1 -1 0
1 0 0 2 0 1
1 0 1 3 -1 0
1 2 1 3 -1 0
1 2 2 3 -1 0
0
end_operator
begin_operator
move2 tablered counter fetch
0
7
2 1 0 2 1 0 -1 0
2 1 0 2 1 0 -1 0
1 2 1 1 -1 1
1 1 0 2 1 0
1 1 1 3 -1 0
1 2 0 3 -1 0
1 2 2 3 -1 0
0
end_operator
begin_operator
move300_v1 counter tablered fetch
2
1 0
2 0
1
0 3 -1 0
0
end_operator
begin_operator
move300_v1 tablered counter fetch
2
0 0
2 1
1
0 3 -1 0
0
end_operator
begin_operator
move300_v2 counter tablered fetch
2
1 0
2 2
1
0 3 -1 0
0
end_operator
begin_operator
move300_v2 tablered counter fetch
2
0 0
2 2
1
0 3 -1 0
0
end_operator
0
