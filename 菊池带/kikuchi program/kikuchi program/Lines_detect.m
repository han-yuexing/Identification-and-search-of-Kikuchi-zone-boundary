function [Slines,EditImg] = Lines_detect(Img_0,peaknums,Nhoods,canny_sigma,canny_ratio)
% ���ܣ�����ͼƬ�е�ֱ�߽��м��
% ���ߣ������ ����� 2020-1-17
% ��д����
% ����: Img_0: ԭʼͼƬ
%       peaknums: ���ֱ������
%       Nhoods: ���ֱ�����ƿ�߳�
%       canny_sigma: Canny����sigmaֵ
%       canny_ratio: Canny���Ӹߵ���ֵ��
% ���: ��
% Return: Slines: ���õ���ֱ�ߣ�����mylines�ṹ����
%         EditImg: Canny���ӱ�Ե�������Ϊ������أ���getlines����ʹ�ã������ظ�����
    peaknum = peaknums;
    Nhood = [Nhoods,Nhoods];
    if size(Img_0,3) == 3
        Img_0 = rgb2gray(Img_0);
    end
    Img_0 = Img_0 / 2;  %���ڳ�ʼͼƬ��Ԥ������ͬ���͵�ͼƬ�˴�ʹ�õķ���Ӧ�ò�ͬ
    % ģ�崰�ڵĴ�Сһ�����1+2*ceil(3*nSigma) ceil������ȡ������������ceil(0.6)=1
    canny_field = 1+2*ceil(3*canny_sigma);
    EdImg1 = edge_canny(Img_0,[canny_field,canny_field],canny_sigma,0.9,canny_ratio);
    EditImg = EdImg1;
    EdImg_result = EditImg;
    theta = 0:0.5:179.5;
    [R0,rho0] = radon(EdImg_result,theta);
    peaks0 = radonpeaks(R0,peaknum,'Threshold',ceil(0.12*max(R0(:))),'Nhood',Nhood);
    type = 1;
    if type == 1
        lines1 = radonlines(Img_0,theta,rho0',peaks0,type);
    end
    mylines = [];
    for i = 1:length(lines1)
        mylines = [mylines;myLine(lines1(i,1),lines1(i,2),lines1(i,3),lines1(i,4),lines1(i,5))];
    end
    Slines = mylines;
end