function [res_line_set,uselineset] = Two2one(lines, Image)
% ���ܣ�ƥ�䵥��ֱ������������
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: lines: ֱ����Ϣ���ΰ���б�ʡ�x��ؾࡢy��ؾࡢͼƬ���������ء�ͼ�����������
%       Image: ԭʼͼƬ
% ���: ��
% Return: res_line_set: myLine�ṹ�����͵�������
%         uselineset: ���������������ߵĳɶԵ���ֱ��
    mylines = [];
    uselineset = [];
    for i = 1:length(lines)
        mylines = [mylines;myLine(lines(i,1),lines(i,2),lines(i,3),lines(i,4),lines(i,5))];
    end
    rad1 = pi / 180;
    rad_dis = zeros(length(mylines),length(mylines));
    for i = 1:length(mylines)
        for j = 1:length(mylines)
            theta1 = atan(mylines(i,1).slope);
            theta2 = atan(mylines(j,1).slope);
            if theta1 < 0
                theta1 = pi + theta1;
            end
            if theta2 < 0
                theta2 = pi + theta2;
            end
            rad_dis(i,j) = abs(theta1-theta2);
            if abs(theta1 - theta2)>90*rad1
                rad_dis(i,j) = (pi - abs(theta1-theta2));
            end
            if i==j
                rad_dis(i,j)=pi;
            end
        end
    end
    visited = zeros(1,length(lines));
    res_line_set = [];
    for i = 1:length(lines)
        if (abs(lines(i,1)) < 1e-6) && (lines(i,3) <= 3 || (size(Image,1) - lines(i,3) <= 3))
            visited(i) = 1;
        end
        if (abs(lines(i,1)) > 1e+15) && (lines(i,2) <= 3 || (size(Image,2) - lines(i,2) <= 3))
            visited(i) = 1;
        end
        if visited(i)==0
            visited(i) = 1;
            close_index = find(rad_dis(i,:)<2*rad1);
            if length(close_index)>1
                mindif = 9e+25;
                minind = -1;
                for m = 1:length(close_index)
                    temp = abs(mylines(close_index(m)).x_cut-mylines(i).x_cut)+abs(mylines(close_index(m)).y_cut-mylines(i).y_cut);
                    if abs(mylines(close_index(m)).x_cut-mylines(i).x_cut)+abs(mylines(close_index(m)).y_cut-mylines(i).y_cut)<=mindif
                        minind = close_index(m);
                        mindif = abs(mylines(close_index(m)).x_cut-mylines(i).x_cut)+abs(mylines(close_index(m)).y_cut-mylines(i).y_cut);
                    end
                end
                close_index = minind;
            elseif isempty(close_index)
                continue;
            end
            if visited(close_index)==1
                continue;
            else
                visited(close_index) = 1;
                res_line_set = [res_line_set;Merge(mylines,i,close_index)];
                uselineset = [uselineset,mylines(i)];
                uselineset = [uselineset,mylines(close_index)];
            end
        end
    end
end

function merged = Merge(liness,i,j)
    new_slope = (liness(i).slope + liness(j).slope)./2;
    if new_slope > 1e5
        fprintf('%d\n',new_slope);
        if abs(liness(i).x_cut-liness(j).x_cut)>100
            merged = [];
            return ;
        end
    end
    new_x_cut = (liness(i).x_cut + liness(j).x_cut)/2;
    new_y_cut = (liness(i).y_cut+liness(j).y_cut)/2;
    new_centerx = (liness(i).centerx+liness(j).centerx)/2;
    new_centery = (liness(i).centery+liness(j).centery)/2;
    merged = myLine(new_slope,new_x_cut,new_y_cut,new_centerx,new_centery);
end
