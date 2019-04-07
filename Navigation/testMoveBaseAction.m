%% Test script to call the move_base action server for navigation

% Copyright 2019 The MathWorks, Inc.

%% SETUP
connectToRobot
% Define ROS Action Client to move_base
[moveBaseClient,moveBaseMsg] = rosactionclient(MOVE_BASE_ACTION);

%% EXECUTION
% Define target pose [X Y theta_RAD] 
goalPose = [5 0 -1.57];

% Package goal pose into ROS message
moveBaseMsg.TargetPose.Header.FrameId = MAP_FRAME;
moveBaseMsg.TargetPose.Header.Stamp = rostime('now');
moveBaseMsg.TargetPose.Pose.Position.X = goalPose(1);
moveBaseMsg.TargetPose.Pose.Position.Y = goalPose(2);
q = eul2quat([goalPose(3) 0 0]);
moveBaseMsg.TargetPose.Pose.Orientation.W = q(1);
moveBaseMsg.TargetPose.Pose.Orientation.X = q(2);
moveBaseMsg.TargetPose.Pose.Orientation.Y = q(3);
moveBaseMsg.TargetPose.Pose.Orientation.Z = q(4);

% Send the command
result = sendGoalAndWait(moveBaseClient,moveBaseMsg);
