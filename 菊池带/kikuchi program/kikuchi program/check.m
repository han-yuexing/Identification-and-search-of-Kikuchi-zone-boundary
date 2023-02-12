function [allow,dis] = check(strcheck,sLine,threshold1,threshold2,theta_threshold)
% ���ܣ�ֱ�����߶μ��������˫��ɸѡ
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: strcheck: ����ɸѡ��ֱ��
%       sLine: ����ɸѡ���߶�
%       threshold1: �߶���ֱ�߾���֮�����Сֵ
%       threshold2: �߶���ֱ�߾���֮������ֵ
%       theta_threshold: �߶���ֱ�߽ǶȲ�����ֵ
% ���: ��
% Return: allow: ֱ���Ƿ�����ɸѡ����
%         dis: �߶ε�ֱ�ߵľ���
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