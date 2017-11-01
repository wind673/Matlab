%*******************************(C) COPYRIGHT 2016 Wind��л���죩*********************************%
%{
===========================================================================
@FileName    : ������
@Description : None
@Date        : 2017/7/23
@By          : Wind��л���죩
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}
% ����1 -------------------------------------------------------------------
figure(1);

% �������� ------------------------------------
X_LENTH = 4096;
Main_Sin_Vpp = 3.3;
Main_Freq = 100;

% ���ݲ������� ------------------------------------
x = 1:1:X_LENTH; %0~X_LENTH����1
y = sin(2*pi*x*Main_Freq/X_LENTH)*Main_Sin_Vpp;
y1 = awgn(y,15,'measured');%��15dB����


y2 = zeros(1,X_LENTH);%Ԥ�����ڴ�
%ƽ���˲�
for i = 1:X_LENTH
    temp = 0;
    for j = 1:Filter_Deep
        if i>Filter_Deep
            temp = temp + y1(i-j);
        end
    end
    y2(i) = temp/(Filter_Deep);
end  




% ��ͼ���� ------------------------------------
subplot(3,1,1);
plot(x,y,'black'); %��������
title('ԭʼ�ź�','Color','blue');%д����
set(gca,'XLim',[920,1060]);%X���������ʾ��Χ
set(gca,'YLim',[-5,5]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',0:15:1060);%����X��������
set(gca,'YTick',-5:2:5);%����Y��������
hold on;%����

subplot(3,1,2);
plot(x,y1,'red'); %��������
title('�������ź�','Color','blue');%д����
set(gca,'XLim',[920,1060]);%X���������ʾ��Χ
set(gca,'YLim',[-5,5]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',0:15:1060);%����X��������
set(gca,'YTick',-5:2:5);%����Y��������
hold on;%���� 

subplot(3,1,3);
plot(x,y2,'black'); %��������
hold on;%���� 
plot(x,y3,'red'); %��������
hold on;%���� 
plot(x,y4,'blue'); %��������
hold on;%���� 
plot(x,y5,'blue.'); %��������
hold on;%���� 
title('�˲�����ź�','Color','blue');%д����
set(gca,'XLim',[920,1060]);%X���������ʾ��Χ
set(gca,'YLim',[-5,5]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',0:15:1060);%����X��������
set(gca,'YTick',-5:2:5);%����Y��������
hold on;%����








