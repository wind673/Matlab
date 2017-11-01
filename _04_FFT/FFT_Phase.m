%*******************************(C) COPYRIGHT 2016 Wind��л���죩*********************************%
%{
===========================================================================
@FileName    : FFT
@Description : None
@Date        : 2017/7/27
@By          : Wind��л���죩
@Email       : 1659567673@ qq.com
@Platform    : Matlab 2017a
@Explain     : None
===========================================================================
%}

% ����1 -------------------------------------------------------------------

% �������� ------------------------------------
Main_Sin_Vpp = 36;
Main_Freq = 50;

as_Main_T = 8;%��n������
as_Main_N = 64;%ÿ������N����
as2_Main_T_gap = (1000000/Main_Freq)/(as_Main_N); %ÿ����Ĳ���ʱ���� us
as2_Main_T_sum = as2_Main_T_gap*as_Main_T*as_Main_N/1000; %ÿ�β���ʱ�䳤 ms  
as_Main_N_Rev = mod((as2_Main_T_gap-floor(as2_Main_T_gap))*as_Main_T*as_Main_N,as_Main_N);%й¶����
as1_Main_Phase = 130;%���� ��


if as_Main_N_Rev > as_Main_N/2
    as_Main_N_Rev = abs(as_Main_N - as_Main_N_Rev);
end

fprintf("�ź�Ƶ�� %0.2f Hz \n",Main_Freq);
fprintf("�� %d ������ - ",as_Main_T);
fprintf("ÿ������ %d �� - ",as_Main_N);
fprintf("FFT���� %d \n",as_Main_N*as_Main_T);
fprintf("й¶���� %0.2f - ",as_Main_N_Rev);
fprintf("й¶�� %0.2f %%\n",as_Main_N_Rev*100/(as_Main_N*as_Main_T));
fprintf("ÿ����Ĳ���ʱ���� %0.2f us(��%0.1fHzΪ��) \n",as2_Main_T_gap,Main_Freq);
fprintf("ÿ�β���ʱ�䳤 %0.2f ms \n",as2_Main_T_sum);   
fprintf("ʵ������ %0.4f�� \n",as1_Main_Phase); 


X_LENTH = as_Main_T*as_Main_N - as_Main_N_Rev;
% ���ݲ������� ------------------------------------
x = 0:1:X_LENTH; %0~X_LENTH����1 
y1 = sin(2*pi*x*as_Main_T/X_LENTH+ 0/360*2*pi)*Main_Sin_Vpp + sin(2*pi*x*as_Main_T*10/X_LENTH+ 66/360*2*pi)*Main_Sin_Vpp*0.1; 
y2 = sawtooth((2*pi*x*as_Main_T/X_LENTH + (as1_Main_Phase+90)/360*2*pi),0.5)*Main_Sin_Vpp*0.1 + sin(2*pi*x*as_Main_T*17/X_LENTH+ 66/360*2*pi)*Main_Sin_Vpp*0.03; 
y1 = awgn(y1,30,'measured');%������  
y2 = awgn(y2,30,'measured');%������  

FFT1 = fft(y1); 
FFT2 = fft(y2); 
 
max1 = 0;
max1_X = 0; 
max1_real = 0;
max1_imag = 0;
for i=1:X_LENTH/2 
    if abs(real(FFT1(i))) > max1
       max1 = sqrt(real(FFT1(i))*real(FFT1(i))+imag(FFT1(i))*imag(FFT1(i)));
       max1_X = i;
       max1_real = real(FFT1(i));
       max1_imag = imag(FFT1(i)); 
    end 
end
phase1 = atan2(max1_imag,max1_real)/pi*180;

max2 = 0;
max2_X = 0; 
max2_real = 0;
max2_imag = 0;
for i=1:X_LENTH/2
    if abs(real(FFT2(i))) > max2
       max2 = sqrt(real(FFT2(i))*real(FFT2(i))+imag(FFT2(i))*imag(FFT2(i)));
       max2_X = i;
       max2_real = real(FFT2(i));
       max2_imag = imag(FFT2(i)); 
    end 
end
phase2 = atan2(max2_imag,max2_real)/pi*180;
 
if phase2 - phase1 > 180
    as1_phase = -360 + phase2 - phase1;
    
end

if  phase2 - phase1 <= 180
    as1_phase = phase2 - phase1;
end

fprintf("������� %0.4f�� \n",as1_phase); 
fprintf("��� %0.4f�� (130��������) \n",abs(as1_Main_Phase - as1_phase));
fprintf("------------------------------\n");


% ��ͼ���� ------------------------------------ 
figure(1);
left = 0;
right = X_LENTH;
up = Main_Sin_Vpp*2;
down = - up;
 
plot(x,y1,'blue'); %��������
hold on;%����  
plot(x,y2,'red'); %��������
hold on;%����   
title('�����ź�');%д����
legend('��ѹ','����'); 
set(gca,'XLim',[left,right]);%X���������ʾ��Χ
set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',left:(right - left)/10:right);%����X��������
set(gca,'YTick',down:(up - down)/8:up);%����Y��������
hold on;%���� 
grid;

% ��ͼ���� ------------------------------------ 
figure(2);
left = 0;
right = X_LENTH;
up = Main_Sin_Vpp*300;
down = - up;

subplot(2,1,1);
plot(x,real(FFT1),'blue'); %��������
hold on;%����  
plot(x,imag(FFT1),'red'); %��������
hold on;%����   
title('��ѹFFT');%д����
legend('real','imag'); 
% set(gca,'XLim',[left,right]);%X���������ʾ��Χ
% set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
% set(gca,'XTick',left:(right - left)/10:right);%����X��������
% set(gca,'YTick',down:(up - down)/8:up);%����Y��������
hold on;%����
grid;

left = 0;
right = X_LENTH;
up = Main_Sin_Vpp*30;
down = - up;
subplot(2,1,2);
plot(x,real(FFT2),'blue'); %��������
hold on;%����  
plot(x,imag(FFT2),'red'); %��������
hold on;%����   
title('����FFT');%д����
legend('real','imag'); 
set(gca,'XLim',[left,right]);%X���������ʾ��Χ
set(gca,'YLim',[down,up]);%Y���������ʾ��Χ
% text(950,0,'string');%ͼ������д��
set(gca,'XTick',left:(right - left)/10:right);%����X��������
set(gca,'YTick',down:(up - down)/8:up);%����Y��������
hold on;%����
grid;


