function [Fitset,noderes,nodemap] = detect(img,peaknum_line,peak_num_segline,Nhood_line,Nhood_segline,check_max,check_min,check_theta,FakeDiminish,check_max1,check_min1,check_theta1,FakeDiminish1,node_dis,node_nhood,node_num,canny_sigma,canny_ratio)
% ���ܣ��������ֱ�ߡ��߶��Լ�������ܺ���
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: img: ԭʼͼƬ
%       peaknum_line: ���ֱ������
%       peak_num_segline: ����߶�����
%       Nhood_line: ���ֱ�����ƿ�߳�
%       Nhood_segline: ����߶����ƿ�߳�
%       check_max: �߶�-������ƥ��������ֵ
%       check_min: �߶�-������ƥ�������Сֵ
%       check_theta: �߶�-������ƥ��ǶȲ����ֵ
%       FakeDiminish: ����������޳�ǿ��
%       check_max1: �߶�-����ֱ��ƥ��������ֵ
%       check_min1: �߶�-����ֱ��ƥ�������Сֵ
%       check_theta1: �߶�-����ֱ��ƥ��ǶȲ����ֵ
%       FakeDiminish1: ��ٵ���ֱ���޳�ǿ��
%       node_dis: �������������
%       node_nhood: ���������ƿ鳤��
%       node_num: �����������
%       canny_sigma: Canny����sigmaֵ
%       canny_ratio: Canny���Ӹߵ���ֵ��
% ���: ��
% Return: Fitset: �������м�⵽�����ߵ�FitStructure�ṹ��
%         noderes: ���õ���ȫ����������
%         nodemap: �����߾�����Ⱦ�������õĽ��
    Image = img;
    [StrLines,EditImg] = Lines_detect(Image,peaknum_line,Nhood_line,canny_sigma,canny_ratio);
    ShortLines = getlines(EditImg,peak_num_segline,Nhood_segline);
    Fitset = [];  %ȫ����ʼֱ�߼����(FitStructure�ṹ)
    Fitset1 = [];  %�������ֱ���޳�ǿ�ȵĳ�ʼֱ�߼����
    for i = 1:length(StrLines)
        tmp = FitStructure(StrLines(i));
        Fitset = [Fitset,tmp];
    end
    for i =1:length(Fitset)
        currentline = Fitset(i).StraightLine;
        slope = currentline.slope;
        strcheck = [slope,currentline.x_cut,currentline.y_cut,currentline.centerx,currentline.centery];
        distance = [];
        for j = 1:length(ShortLines)
            [allow,dis] = check(strcheck,ShortLines(j),check_min1,check_max1,check_theta1);
            if allow == true
                Fitset(i).ShortLines = [Fitset(i).ShortLines;ShortLines(j)];
                distance = [distance;dis];
            end
        end
        if(length(Fitset(i).ShortLines)>FakeDiminish1)
            Fitset(i).Distances = distance;
            tmp = FitStructure(Fitset(i).StraightLine);
            Fitset1 = [Fitset1,tmp];
        else
            continue;
        end
    end
    lines1 = [];
    for i=1:length(Fitset1)
        currentLine = Fitset1(i).StraightLine;
        lines1 = [lines1;[currentLine.slope,currentLine.x_cut,currentLine.y_cut,currentLine.centerx,currentLine.centery]];
    end
    Fitset = [];  %�˴�Fitset�ڵ�ֱ��Ϊ������
    [StrLines,uselineset] = Two2one(lines1,img);
    Fitset5 = [];  %�˴�Fitset5�ڵ�ֱ�߾���Two2one��ƥ��õ��ĳɶԵ���ֱ��
    for i = 1:length(uselineset)
        tmp = FitStructure(uselineset(i));
        Fitset5 = [Fitset5,tmp];
    end
    for i = 1:length(StrLines)
        tmp = FitStructure(StrLines(i));
        Fitset = [Fitset,tmp];
    end
    Fitset2 = [];  %�˴�Fitset2�ڵ�ֱ��Ϊ�������ֱ���޳�ǿ�ȵĳ�ʼֱ�߼������δ��Two2oneƥ��Ĳ��֣��ڷ����л����ʹ�ã�
    for i = 1:length(Fitset1)
        tag = 0;
        for j = 1:length(Fitset5)
            currentline1 = Fitset1(i).StraightLine;
            currentline2 = Fitset5(j).StraightLine;
            if currentline1.slope == currentline1.slope && currentline1.x_cut == currentline2.x_cut && currentline1.y_cut == currentline2.y_cut
                tag = 1;
                break;
            end
        end
        if tag == 0
            Fitset2 = [Fitset2,Fitset1(i)];
        end
    end
    for i =1:length(Fitset)
        currentline = Fitset(i).StraightLine;
        slope = currentline.slope;
        strcheck = [slope,currentline.x_cut,currentline.y_cut,currentline.centerx,currentline.centery];
        distance = [];
        for j = 1:length(ShortLines)
            [allow,dis] = check(strcheck,ShortLines(j),check_min,check_max,check_theta);
            if allow == true
                Fitset(i).ShortLines = [Fitset(i).ShortLines;ShortLines(j)];
                distance = [distance;dis];
            end
        end
        if(length(Fitset(i).ShortLines)>(FakeDiminish-1))
            Fitset(i).Distances = distance;
        else
            continue;
        end
    end
    
    Fitsettemp = [];  %��ȫ���������ֱ���޳�ǿ�ȵ�ֱ��������װ��Fitset��
    for i =1:length(Fitset)
        if length(Fitset(i).ShortLines) >= FakeDiminish
            Fitsettemp = [Fitsettemp,Fitset(i)];
        end
    end
    Fitset = Fitsettemp;

    map = AccMap(Fitset,Image,node_dis);
    nodemap = map;
    peaks = FindPeaks(map,node_num,[node_nhood,node_nhood]);
    noderes = peaks;

    % %% ���۲���(�Զ���
    % % ֱ�߹��ڽ�����з���
    % Fitset3 = [];  %���������Լ�ֱ�������ɵ�peak_line�ṹ��
    % Fitset7 = [];
    % for i = 1:length(Fitset2)
    %     currentLine = Fitset2(i).StraightLine;
    %     tag = 0;
    %     for j = 1:length(peaks)
    %         if (abs(currentLine.slope) < 1e-6)
    %             temp_distance = abs(peaks(j,1) - currentLine.y_cut);
    %         elseif (abs(currentLine.slope) > 1e+15)
    %             temp_distance = abs(peaks(j,2) - currentLine.x_cut);
    %         else
    %             temp_distance = abs(currentLine.slope*peaks(j,2)-peaks(j,1)+currentLine.y_cut)/sqrt(1+currentLine.slope * currentLine.slope);
    %         end
    % %         �˴�֮����û��ѡ��ֻ��һ��ֱ�߶�Ӧһ����ӽ��ĵ�����Ϊʵ�ʷ��۵�����²����ܱ�֤����ĵ��һ������Ҫ���з��۵ĶԳƾճش�����
    % %         �����˼·���ҵ������ں��ʷ�Χ�ڵĵ��߶ԣ�������ѭ�����ߣ��ں���Ĵ����У�һ���Խ�ͬһ���ߵĵ��߶�ȫ��ȡ����Ȼ���۱Ƚϵõ�ƥ���߶������ķ���ֱ��ѡ��
    % %         ֮���������ܹ�ֻѡ���е�һ������Ϊ���ճش��İ��һ��ֻ���Ӧ���ߣ������ܺ�����ֱ�߶�Ӧ������һ����ȷ���߶�ֻ���ܷ��۳�һ����ȷ�ķ���ֱ�ߣ����Ｔѡ������ȷ��һ��
    %         if temp_distance > check_max || temp_distance < check_min
    %             continue;
    %         else
    %             Fitset3 = [Fitset3,peak_line(peaks(j,2),peaks(j,1),Fitset2(i).StraightLine)];
    %             tag = 1;
    %         end
    %     end
    %     if tag == 1
    %         Fitset7 = [Fitset7,currentLine];
    %     end
    % end
    % % ���з��ۣ������xʵ�ʻ��߲�û���õ������Բ����������ദ��
    % strlines = [];
    % for i = 1:length(Fitset3)
    %     currentline = Fitset3(i).StraightLine;
    %     peak_x = Fitset3(i).peak_x;
    %     peak_y = Fitset3(i).peak_y;
    %     if (abs(currentline.slope) < 1e-6)
    %         x = currentline.x_cut;
    %         y = 2*peak_y - currentline.y_cut;
    %         strlines = [strlines,myLine(currentline.slope,x,y,currentline.centerx,currentline.centery)];
    %     elseif (abs(currentline.slope) > 1e+15)
    %         x = 2*peak_x - currentline.x_cut;
    %         y = -currentline.slope*x;
    %         strlines = [strlines,myLine(currentline.slope,x,y,currentline.centerx,currentline.centery)];
    %     %     ���۵õ��ĵ����Ե��(��δ���м����Ƿ���ȷ)
    %     else
    %         x = currentline.x_cut;
    %         y = 2*peak_y - currentline.slope*2*peak_x - currentline.y_cut;
    %         strlines = [strlines,myLine(currentline.slope,x,y,currentline.centerx,currentline.centery)];
    %     %     ���۵õ��ĵ����Ե��(��δ���м����Ƿ���ȷ)
    %     end
    % end
    % % % ����Ƿ���Ч���������߶�ƥ�䵥��ֱ�ߣ�
    % % % ����������ܻᵼ����ȷ��ֱ��ȴ��Ϊ�����Ե��ģ�����Ҳ����㹻��ƥ���߶�
    % % Fitset4 = [];  %�������߼���ķ��۵���ֱ��
    % % for i = 1:length(strlines)
    % %     tmp = FitStructure(strlines(i));
    % %     Fitset4 = [Fitset4,tmp];
    % % end
    % % for i =1:length(Fitset4)
    % %     currentline = Fitset4(i).StraightLine;
    % %     slope = currentline.slope;
    % %     strcheck = [slope,currentline.x_cut,currentline.y_cut,currentline.centerx,currentline.centery];
    % %     distance = [];
    % %     for j = 1:length(ShortLines)
    % %         [allow,dis] = check(strcheck,ShortLines(j),check_min1,7,4);
    % %         if allow == true
    % %             Fitset4(i).ShortLines = [Fitset4(i).ShortLines;ShortLines(j)];
    % %             distance = [distance;dis];
    % %         end
    % %     end
    % %     if(length(Fitset4(i).ShortLines)>FakeDiminish1)
    % %         Fitset4(i).Distances = distance;
    % %     else
    % %         continue;
    % %     end
    % % end
    % % Fitset6 = [];
    % %�洢����ÿ��ֱ�߷��۶�ε���Ψһѡȡ��Ϊ֮������һ��ճش���Ե��ֱ�ߣ��������ɵ�ֱ��δ�������С�ÿһ��ֱ�����ҽ���һ�����۵�ֱ�߻ᱻѡ��
    % % tempnum = 0;
    % % tempmin = -1;
    % % slopesign = 0;
    % % xsign = 0;
    % % ysign = 0;
    % % for i = 1:length(Fitset4)
    % %     currentline = Fitset4(i).StraightLine;
    % %     if currentline.slope ~= slopesign || currentline.x_cut ~= xsign || currentline.y_cut ~= ysign
    % %         if tempnum ~= 0
    % %             tmp = FitStructure(Fitset4(tempnum).StraightLine);
    % %             Fitset6 = [Fitset6,tmp];
    % %         end
    % %         slopesign = currentline.slope;
    % %         xsign = currentline.x_cut;
    % %         ysign = currentline.y_cut;
    % %         tempnum = 0;
    % %         tempmin = -1;
    % %     end
    % %     if (length(Fitset4(i).ShortLines) > FakeDiminish1) && (length(Fitset4(i).ShortLines) > tempmin)
    % %         tempnum = i;
    % %         tempmin = length(Fitset4(i).ShortLines);
    % %     end
    % %     if i == length(Fitset4) && tempnum ~= 0
    % %         tmp = FitStructure(Fitset4(tempnum).StraightLine);
    % %         Fitset6 = [Fitset6,tmp];
    % %     end
    % % end
    % % 
    % % % �������ַ����ǰɶ��ڷ���֮���ֱ���Ƿ���ȷ��ȫ�������������������жϣ��ô����ܹ����ⵥ���Ե�Ҳ����߶ε�������������ǿ��ܻ���һ����ȷ�ıߣ�һ������ı�
    % % % for i = 1:length(strlines)
    % % %     tmp = FitStructure(strlines(i));
    % % %     Fitset6 = [Fitset6,tmp];
    % % % end
    % % 
    % % % ����֮���ٰ�Fitset7�����ԭ������ǰ��ֱ�߼ӽ�ȥ��Two2one��֮���Բ���Ҫ����ɸѡ���ܷŽ�ȥ����Ϊ��Щֱ�߶��ǵ�һ������Two2oneʣ�µģ�һ��������ƥ�䣬����ȫ��������ȥƥ�䲻��������
    % % % ���ֱ����Fitset3��������ظ���
    % % for i = 1:length(Fitset7)
    % %     tmp = FitStructure(Fitset7(i));
    % %     Fitset6 = [Fitset6,tmp];
    % % end
    % % %%
    % % lines1 = [];
    % % for i=1:length(Fitset6)
    % %     currentLine = Fitset6(i).StraightLine;
    % %     lines1 = [lines1;[currentLine.slope,currentLine.x_cut,currentLine.y_cut,currentLine.centerx,currentLine.centery]];
    % % end
    % % StrLines = Two2one(lines1,img);
    % % for i = 1:length(StrLines)
    % % %     ����ƥ��ķ���ֱ��
    % %     tmp = FitStructure(StrLines(i));
    % %     Fitset = [Fitset,tmp];
    % % end
    % % for i =1:length(Fitset)
    % %     currentline = Fitset(i).StraightLine;
    % %     slope = currentline.slope;
    % %     strcheck = [slope,currentline.x_cut,currentline.y_cut,currentline.centerx,currentline.centery];
    % %     distance = [];
    % %     for j = 1:length(ShortLines)
    % %         [allow,dis] = check(strcheck,ShortLines(j),check_min,check_max,check_theta);
    % %         if allow == true
    % %             Fitset(i).ShortLines = [Fitset(i).ShortLines;ShortLines(j)];
    % %             distance = [distance;dis];
    % %         end
    % %     end
    % %     if length(Fitset(i).ShortLines) > (FakeDiminish-1)
    % %         Fitset(i).Distances = distance;
    % % %         ���������߼���ķ���ֱ�������ߣ�ȫ��������ԭ�����е������ߣ�
    % %     else
    % %         continue;
    % %     end
    % % end
    % %% ���۲��֣��ֶ���
    % % ����Ƿ���Ч���������߶�ƥ�䵥��ֱ�ߣ�
    % Fitset4 = [];
    % for i = 1:length(strlines)
    %     tmp = FitStructure(strlines(i));
    %     Fitset4 = [Fitset4,tmp];
    % end
    % Fitset6 = [];
    % for i =1:length(Fitset4)
    %     currentline = Fitset4(i).StraightLine;
    % %     ����֮����ϼ��������ĵ���ֱ��
    %     figure;
    %     imshow(img);
    %     hold on       
    %     x1 = 0:size(img,2);
    %     y1 = currentline.slope*x1 + currentline.y_cut;
    %     plot(x1,y1,'r');
    %     checkans = input('T or F');
    %     if checkans == 'T'
    %         tmp = FitStructure(currentline);
    %         Fitset6 = [Fitset6,tmp];
    %     end
    % end
    % % ����֮���ٰ�Fitset7�����ԭ������ǰ��ֱ�߼ӽ�ȥ��Two2one��֮���Բ���Ҫ����ɸѡ���ܷŽ�ȥ����Ϊ��Щֱ�߶��ǵ�һ������Two2oneʣ�µģ�һ��������ƥ�䣬����ȫ��������ȥƥ�䲻��������
    % % ���ֱ����Fitset3��������ظ���
    % for i = 1:length(Fitset7)
    %     tmp = FitStructure(Fitset7(i));
    %     Fitset6 = [Fitset6,tmp];
    % end
    % lines2 = [];
    % for i=1:length(Fitset6)
    %     currentLine = Fitset6(i).StraightLine;
    %     lines2 = [lines2;[currentLine.slope,currentLine.x_cut,currentLine.y_cut,currentLine.centerx,currentLine.centery]];
    % end
    % StrLines = Two2one(lines2,img);
    % for i = 1:length(StrLines)
    %     tmp = FitStructure(StrLines(i));
    %     Fitset = [Fitset,tmp];
    % end
    % Fitsettemp = [];
    % for i =1:length(Fitset)
    %     if length(Fitset(i).ShortLines) == 0
    %         currentline = Fitset(i).StraightLine;
    %         slope = currentline.slope;
    %         strcheck = [slope,currentline.x_cut,currentline.y_cut,currentline.centerx,currentline.centery];
    %         distance = [];
    %         for j = 1:length(ShortLines)
    %             [allow,dis] = check(strcheck,ShortLines(j),check_min,check_max,check_theta);
    %             if allow == true
    %                 Fitset(i).ShortLines = [Fitset(i).ShortLines;ShortLines(j)];
    %                 distance = [distance;dis];
    %             end
    %         end
    %         Fitset(i).Distances = distance;
    %         Fitsettemp = [Fitsettemp,Fitset(i)];
    %     elseif length(Fitset(i).ShortLines) >= FakeDiminish
    %         Fitsettemp = [Fitsettemp,Fitset(i)];
    %     end
    % end
    % Fitset = Fitsettemp;
    % 
    % map = AccMap(Fitset,Image,node_dis);
    % nodemap = map;
    % peaks = FindPeaks(map,node_num + 10,[node_nhood,node_nhood]);
    % noderes = peaks;
end