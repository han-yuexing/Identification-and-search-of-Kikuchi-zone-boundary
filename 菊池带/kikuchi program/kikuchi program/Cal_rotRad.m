function [rad_move] = Cal_rotRad(StrLine)
% 功能：根据直线斜率确定偏转的角度
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: StrLine: 直线信息（包括斜率和y轴截距）
% 输出: 无
% Return: rad_move: 直线偏转角度
    theta = atan(StrLine(1));
    rad_move = 0;
    % rad_move>0代表逆时针旋转
    % rad_move<0代表顺时针旋转
    if theta > 0
        rad_move = pi / 2 - theta;
    else
        rad_move = - (theta + pi / 2);
    end
end

