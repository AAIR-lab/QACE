begin_version
3
end_version
begin_metric
0
end_metric
3
begin_variable
var0
-1
2
Atom ingripper_1(canred, gripper)
NegatedAtom ingripper_1(canred, gripper)
end_variable
begin_variable
var1
-1
2
Atom ingripper_2(canred, gripper)
NegatedAtom ingripper_2(canred, gripper)
end_variable
begin_variable
var2
-1
2
Atom p_psi()
NegatedAtom p_psi()
end_variable
5
begin_mutex_group
1
1 0
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
1
0 0
end_mutex_group
begin_mutex_group
1
2 0
end_mutex_group
begin_state
0
0
1
end_state
begin_goal
1
2 0
end_goal
4
begin_operator
put gripper counter canred fetch
1
0 0
3
1 0 0 1 -1 1
1 0 1 2 -1 0
1 1 1 2 -1 0
0
end_operator
begin_operator
put2 gripper counter canred fetch
0
4
2 0 0 1 0 0 -1 0
1 0 0 1 0 1
1 0 1 2 -1 0
1 1 1 2 -1 0
0
end_operator
begin_operator
put300 gripper counter canred fetch
2
0 0
1 1
1
0 2 -1 0
0
end_operator
begin_operator
put300 gripper tablered canred fetch
2
0 0
1 1
1
0 2 -1 0
0
end_operator
0
