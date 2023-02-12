function [allow,dis] = check(strcheck,sLine,threshold1,threshold2,theta_threshold)
% 功能：直线与线段检测结果进行双向筛选
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: strcheck: 进行筛选的直线
%       sLine: 进行筛选的线段
%       threshold1: 线段与直线距离之间的最小值
%       threshold2: 线段与直线距离之间的最大值
%       theta_threshold: 线段与直线角度差的最大值
% 输出: 无
% Return: allow: 直线是否满足筛选条件
%         dis: 线段到直线的距离
    slope = strcheck(1);
    y_cut = strcheck(3);
    x1 = 20;
    y1 = slope*x1+y_cut;
    correct_point1 = [x1-strcheck(4),strcheck(5)-y1];
    point1 = sLine.point1;
    point2 = sLine.point2;
    slope = -slope;
    b = correct_point1(2) - slope*correct_point1(1);
    point1(1) = point1(1) - strcheck(4);
    point2(1) = point2(1) - strcheck(4);
    point1(2) = strcheck(5) - point1(2);
    point2(2) = strcheck(5) - point2(2);
    dis1 = abs(slope*point1(1)+b-point1(2))/sqrt(1+strcheck(1)*strcheck(1));
    dis2 = abs(slope*point2(1)+b-point2(2))/sqrt(1+strcheck(1)*strcheck(1));
    dis = (dis1 + dis2) / 2;
    if dis > threshold1 && dis < threshold2 && abs(atan(slope)-atan((point1(2)-point2(2))/(point1(1)-point2(1))))/(pi/180)<theta_threshold
        allow = true;
    else
        allow = false;
    end
end