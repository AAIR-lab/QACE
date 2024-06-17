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
Atom empty_1(gripper)
NegatedAtom empty_1(gripper)
end_variable
begin_variable
var1
-1
3
Atom empty_2(gripper)
Atom ingripper_1(canred, gripper)
<none of those>
end_variable
begin_variable
var2
-1
3
Atom ingripper_2(canred, gripper)
Atom order_2(canred, counter)
<none of those>
end_variable
begin_variable
var3
-1
2
Atom order_1(canred, counter)
NegatedAtom order_1(canred, counter)
end_variable
begin_variable
var4
-1
2
Atom p_psi()
NegatedAtom p_psi()
end_variable
15
begin_mutex_group
1
0 0
end_mutex_group
begin_mutex_group
1
0 0
end_mutex_group
begin_mutex_group
2
0 0
1 1
end_mutex_group
begin_mutex_group
2
0 0
2 0
end_mutex_group
begin_mutex_group
1
1 0
end_mutex_group
begin_mutex_group
1
1 0
end_mutex_group
begin_mutex_group
2
1 0
1 1
end_mutex_group
begin_mutex_group
2
1 0
2 0
end_mutex_group
begin_mutex_group
2
1 1
2 1
end_mutex_group
begin_mutex_group
2
2 0
2 1
end_mutex_group
begin_mutex_group
1
2 1
end_mutex_group
begin_mutex_group
1
2 1
end_mutex_group
begin_mutex_group
1
2 1
end_mutex_group
begin_mutex_group
1
4 0
end_mutex_group
begin_mutex_group
1
3 0
end_mutex_group
begin_state
0
0
1
0
1
end_state
begin_goal
1
4 0
end_goal
4
begin_operator
grasp gripper counter canred fetch
1
3 0
9
3 1 0 2 1 3 0 0 0 1
4 0 0 1 0 2 1 3 0 1 -1 1
4 0 0 1 0 2 1 3 0 2 -1 0
1 0 1 4 -1 0
1 1 1 4 -1 0
1 1 2 4 -1 0
1 2 0 4 -1 0
1 2 2 4 -1 0
1 3 1 4 -1 0
0
end_operator
begin_operator
grasp2 gripper counter canred fetch
0
10
3 1 0 2 1 3 0 0 -1 1
3 0 0 2 1 3 0 1 0 1
3 0 0 1 0 3 0 2 1 0
4 0 0 1 0 2 1 3 0 3 -1 0
1 0 1 4 -1 0
1 1 1 4 -1 0
1 1 2 4 -1 0
1 2 0 4 -1 0
1 2 2 4 -1 0
1 3 1 4 -1 0
0
end_operator
begin_operator
grasp300_v1 gripper counter canred fetch
2
2 0
3 0
1
0 4 -1 0
0
end_operator
begin_operator
grasp300_v2 gripper counter canred fetch
2
2 2
3 0
1
0 4 -1 0
0
end_operator
0
