function [Fitset,noderes,nodemap] = detect(img,peaknum_line,peak_num_segline,Nhood_line,Nhood_segline,check_max,check_min,check_theta,FakeDiminish,check_max1,check_min1,check_theta1,FakeDiminish1,node_dis,node_nhood,node_num,canny_sigma,canny_ratio)
% 功能：包含检测直线、线段以及交点的总函数
% 作者：李睿祺 刘梦炀 2020-1-17
% 改写：无
% 输入: img: 原始图片
%       peaknum_line: 检测直线数量
%       peak_num_segline: 检测线段数量
%       Nhood_line: 检测直线抑制块边长
%       Nhood_segline: 检测线段抑制块边长
%       check_max: 线段-中心线匹配距离最大值
%       check_min: 线段-中心线匹配距离最小值
%       check_theta: 线段-中心线匹配角度差最大值
%       FakeDiminish: 虚假中心线剔除强度
%       check_max1: 线段-单边直线匹配距离最大值
%       check_min1: 线段-单边直线匹配距离最小值
%       check_theta1: 线段-单边直线匹配角度差最大值
%       FakeDiminish1: 虚假单边直线剔除强度
%       node_dis: 交点检测关联距离
%       node_nhood: 交点检测抑制块长度
%       node_num: 交点检测检测个数
%       canny_sigma: Canny算子sigma值
%       canny_ratio: Canny算子高低阈值比
% 输出: 无
% Return: Fitset: 包含所有检测到中心线的FitStructure结构体
%         noderes: 检测得到的全部交点坐标
%         nodemap: 中心线经过渲染函数所得的结果
    Image = img;
    [StrLines,EditImg] = Lines_detect(Image,peaknum_line,Nhood_line,canny_sigma,canny_ratio);
    ShortLines = getlines(EditImg,peak_num_segline,Nhood_segline);
    Fitset = [];  %全部初始直线检测结果(FitStructure结构)
    Fitset1 = [];  %满足虚假直线剔除强度的初始直线检测结果
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
    Fitset = [];  %此处Fitset内的直线为中心线
    [StrLines,uselineset] = Two2one(lines1,img);
    Fitset5 = [];  %此处Fitset5内的直线经过Two2one后匹配得到的成对单边直线
    for i = 1:length(uselineset)
        tmp = FitStructure(uselineset(i));
        Fitset5 = [Fitset5,tmp];
    end
    for i = 1:length(StrLines)
        tmp = FitStructure(StrLines(i));
        Fitset = [Fitset,tmp];
    end
    Fitset2 = [];  %此处Fitset2内的直线为满足虚假直线剔除强度的初始直线检测结果中未被Two2one匹配的部分（在翻折中会对其使用）
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
    
    Fitsettemp = [];  %将全部满足虚假直线剔除强度的直线重新组装到Fitset中
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

    % %% 翻折部分(自动）
    % % 直线关于交点进行翻折
    % Fitset3 = [];  %交点坐标以及直线所构成的peak_line结构体
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
    % %         此处之所有没有选择只用一条直线对应一个最接近的点是因为实际翻折的情况下并不能保证最近的点就一定是需要进行翻折的对称菊池带交点
    % %         解决的思路是找到所有在合适范围内的点线对，由于外循环是线，在后面的处理中，一次性将同一条线的点线对全部取出，然后翻折比较得到匹配线段数最多的翻折直线选用
    % %         之所以这里能够只选其中的一条是因为，菊池带的半边一定只会对应另半边，不可能和两条直线对应，所以一个正确点线对只可能翻折出一个正确的翻折直线，这里即选用最正确的一条
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
    % % 进行翻折，这里的x实际画线并没有用到，所以不对其做过多处理
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
    %     %     翻折得到的单侧边缘线(尚未进行检验是否正确)
    %     else
    %         x = currentline.x_cut;
    %         y = 2*peak_y - currentline.slope*2*peak_x - currentline.y_cut;
    %         strlines = [strlines,myLine(currentline.slope,x,y,currentline.centerx,currentline.centery)];
    %     %     翻折得到的单侧边缘线(尚未进行检验是否正确)
    %     end
    % end
    % % % 检查是否有效（必须有线段匹配单边直线）
    % % % 但是这里可能会导致正确的直线却因为单侧边缘的模糊而找不到足够的匹配线段
    % % Fitset4 = [];  %经过单边检验的翻折单边直线
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
    % %存储的是每条直线翻折多次当中唯一选取作为之后构造另一侧菊池带边缘的直线，其他生成的直线未放入其中。每一条直线有且仅有一条翻折的直线会被选入
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
    % % % 下面这种方案是吧对于翻折之后的直线是否正确完全交给了中心线来进行判断，好处是能够避免单侧边缘找不到线段的情况，坏处就是可能会是一条正确的边，一条错误的边
    % % % for i = 1:length(strlines)
    % % %     tmp = FitStructure(strlines(i));
    % % %     Fitset6 = [Fitset6,tmp];
    % % % end
    % % 
    % % % 这里之后再把Fitset7里面的原本翻折前的直线加进去做Two2one，之所以不需要进行筛选就能放进去，因为这些直线都是第一遍做完Two2one剩下的，一定不可能匹配，所以全放在里面去匹配不会有问题
    % % % 如果直接用Fitset3里面会有重复的
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
    % % %     经过匹配的翻折直线
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
    % % %         经过中心线检验的翻折直线中心线（全部，包括原本就有的中心线）
    % %     else
    % %         continue;
    % %     end
    % % end
    % %% 翻折部分（手动）
    % % 检查是否有效（必须有线段匹配单边直线）
    % Fitset4 = [];
    % for i = 1:length(strlines)
    %     tmp = FitStructure(strlines(i));
    %     Fitset4 = [Fitset4,tmp];
    % end
    % Fitset6 = [];
    % for i =1:length(Fitset4)
    %     currentline = Fitset4(i).StraightLine;
    % %     翻折之后符合检验条件的单边直线
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
    % % 这里之后再把Fitset7里面的原本翻折前的直线加进去做Two2one，之所以不需要进行筛选就能放进去，因为这些直线都是第一遍做完Two2one剩下的，一定不可能匹配，所以全放在里面去匹配不会有问题
    % % 如果直接用Fitset3里面会有重复的
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