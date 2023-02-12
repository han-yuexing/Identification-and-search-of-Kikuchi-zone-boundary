function [xy_Point] = Coordinate_correction(point_set,y_cut,rotateRad)
% 功能：点坐标依照偏转角度偏转之后得到坐标
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: point_set: 以图片中心为原点的点坐标
%       y_cut: 中心线的y轴截距
%       rotateRad: 偏转角度（分正负）
% 输出: 无
% Return: xy_Point: 偏转之后的点坐标
    rho_theta_set = [];
    for i = 1:length(point_set)
        pointTheta = atan((point_set(i,2) - y_cut) / point_set(i,1));
        pointRho = sqrt((point_set(i,2) - y_cut)^2 + point_set(i,1)^2);
        if (point_set(i,1)>0 && point_set(i,2)>y_cut)
            pointTheta = pointTheta;
        elseif(point_set(i,1)<0 && point_set(i,2)>y_cut)
            pointTheta = pi + pointTheta;
        elseif(point_set(i,1)<0 && point_set(i,2)<y_cut)
            pointTheta = pi + pointTheta;
        else
            pointTheta = pointTheta;
        end
        rho_theta_set = [rho_theta_set; pointTheta+rotateRad, pointRho];
    end
    xy_Point = [];
    for i = 1:length(point_set)
        theta = rho_theta_set(i,1);
        rho = rho_theta_set(i,2);
        xy_Point = [xy_Point;rho * cos(theta),rho * sin(theta)+y_cut];
    end
end