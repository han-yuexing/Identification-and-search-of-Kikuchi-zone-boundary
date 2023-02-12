function [xy_Point] = Coordinate_correction(point_set,y_cut,rotateRad)
% ���ܣ�����������ƫת�Ƕ�ƫת֮��õ�����
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: point_set: ��ͼƬ����Ϊԭ��ĵ�����
%       y_cut: �����ߵ�y��ؾ�
%       rotateRad: ƫת�Ƕȣ���������
% ���: ��
% Return: xy_Point: ƫת֮��ĵ�����
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