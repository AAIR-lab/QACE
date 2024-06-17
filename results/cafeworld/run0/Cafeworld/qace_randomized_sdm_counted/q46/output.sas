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
Atom empty_1(gripper)
NegatedAtom empty_1(gripper)
end_variable
begin_variable
var1
-1
2
Atom empty_2(gripper)
NegatedAtom empty_2(gripper)
end_variable
begin_variable
var2
-1
3
Atom ingripper_1(canred, gripper)
Atom order_1(canred, counter)
<none of those>
end_variable
begin_variable
var3
-1
3
Atom ingripper_2(canred, gripper)
Atom order_2(canred, counter)
<none of those>
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
21
begin_mutex_group
2
0 0
2 0
end_mutex_group
begin_mutex_group
2
0 0
3 0
end_mutex_group
begin_mutex_group
2
1 0
2 0
end_mutex_group
begin_mutex_group
2
1 0
3 0
end_mutex_group
begin_mutex_group
1
2 0
end_mutex_group
begin_mutex_group
1
2 0
end_mutex_group
begin_mutex_group
1
2 0
end_mutex_group
begin_mutex_group
2
2 0
2 1
end_mutex_group
begin_mutex_group
2
2 0
3 1
end_mutex_group
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
3 0
end_mutex_group
begin_mutex_group
2
3 0
2 1
end_mutex_group
begin_mutex_group
2
3 0
3 1
end_mutex_group
begin_mutex_group
1
7 0
end_mutex_group
begin_mutex_group
1
7 0
end_mutex_group
begin_mutex_group
1
8 0
end_mutex_group
begin_mutex_group
1
8 0
end_mutex_group
begin_mutex_group
1
4 0
end_mutex_group
begin_mutex_group
1
5 0
end_mutex_group
begin_mutex_group
1
6 0
end_mutex_group
begin_state
1
1
0
0
1
0
0
0
0
end_state
begin_goal
1
4 0
end_goal
4
begin_operator
put gripper counter canred fetch
0
10
2 2 0 3 0 0 -1 0
2 2 0 3 0 1 -1 0
1 3 0 2 0 1
2 2 0 3 0 3 -1 1
1 2 1 4 -1 0
1 2 2 4 -1 0
1 3 1 4 -1 0
1 3 2 4 -1 0
2 2 0 3 0 5 -1 0
2 2 0 3 0 7 -1 1
0
end_operator
begin_operator
put2 gripper counter canred fetch
0
10
2 2 0 3 0 0 -1 0
2 2 0 3 0 1 -1 0
2 2 0 3 0 2 -1 1
1 2 0 3 0 1
1 2 1 4 -1 0
1 2 2 4 -1 0
1 3 1 4 -1 0
1 3 2 4 -1 0
2 2 0 3 0 5 -1 0
2 2 0 3 0 7 -1 1
0
end_operator
begin_operator
put300 gripper counter canred fetch
2
5 0
7 1
1
0 4 -1 0
0
end_operator
begin_operator
put300 gripper tablered canred fetch
2
6 0
8 1
1
0 4 -1 0
0
end_operator
0
