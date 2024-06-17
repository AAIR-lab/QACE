begin_version
3
end_version
begin_metric
0
end_metric
5
begin_variable
var0
-1
2
Atom p_psi()
NegatedAtom p_psi()
end_variable
begin_variable
var1
-1
2
Atom teleported_1(counter, fetch)
NegatedAtom teleported_1(counter, fetch)
end_variable
begin_variable
var2
-1
2
Atom teleported_1(tablered, fetch)
NegatedAtom teleported_1(tablered, fetch)
end_variable
begin_variable
var3
-1
2
Atom teleported_2(counter, fetch)
NegatedAtom teleported_2(counter, fetch)
end_variable
begin_variable
var4
-1
2
Atom teleported_2(tablered, fetch)
NegatedAtom teleported_2(tablered, fetch)
end_variable
7
begin_mutex_group
1
3 0
end_mutex_group
begin_mutex_group
1
3 0
end_mutex_group
begin_mutex_group
1
4 0
end_mutex_group
begin_mutex_group
1
4 0
end_mutex_group
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
1 0
end_mutex_group
begin_state
1
0
0
0
0
end_state
begin_goal
1
0 0
end_goal
4
begin_operator
put gripper counter canred fetch
0
2
0 1 -1 0
0 3 -1 1
0
end_operator
begin_operator
put2 gripper counter canred fetch
0
2
0 1 -1 0
0 3 -1 1
0
end_operator
begin_operator
put300 gripper counter canred fetch
2
1 0
3 1
1
0 0 -1 0
0
end_operator
begin_operator
put300 gripper tablered canred fetch
2
2 0
4 1
1
0 0 -1 0
0
end_operator
0
