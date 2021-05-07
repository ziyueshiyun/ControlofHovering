function [value,isterminal,direction] = EventFun( t,x )
%EventFun 事件检测函数，用于终止ode45在特定位置处的积分

value = x(2); % 触发时间，当其值为0时候，时间会触发
isterminal = 1; % 设定为1时会，触发时间会停止求解器，设0时触发不影响工作
direction = 0;% 触发方向设1时是上升触发，设-1是下降触发，设0是双向触发



end

