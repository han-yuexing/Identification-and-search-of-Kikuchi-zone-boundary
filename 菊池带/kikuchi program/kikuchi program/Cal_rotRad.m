function [rad_move] = Cal_rotRad(StrLine)
% ���ܣ�����ֱ��б��ȷ��ƫת�ĽǶ�
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: StrLine: ֱ����Ϣ������б�ʺ�y��ؾࣩ
% ���: ��
% Return: rad_move: ֱ��ƫת�Ƕ�
    theta = atan(StrLine(1));
    rad_move = 0;
    % rad_move>0������ʱ����ת
    % rad_move<0����˳ʱ����ת
    if theta > 0
        rad_move = pi / 2 - theta;
    else
        rad_move = - (theta + pi / 2);
    end
end

