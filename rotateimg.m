function [sbw,angle]=rotateimg(sbw1)
%%
%Step6 ���㳵��ˮƽͶӰ������ˮƽͶӰ���з�ȷ���
histcol1=sum(sbw1);      %���㴹ֱͶӰ
histrow=sum(sbw1');      %����ˮƽͶӰ
figure,subplot(2,1,1),bar(histcol1);title('��ֱͶӰ�����߿�');%�����ֱͶӰ
subplot(2,1,2),bar(histrow);     title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
figure,subplot(2,1,1),bar(histrow);     title('ˮƽͶӰ�����߿�');%���ˮƽͶӰ
subplot(2,1,2),imshow(sbw1);title('���ƶ�ֵ��ͼ');%�����ֵͼ
%��ˮƽͶӰ���з�ȷ���
meanrow=mean(histrow);%��ˮƽͶӰ��ƽ��ֵ
minrow=min(histrow);%��ˮƽͶӰ����Сֵ
levelrow=(meanrow+minrow)/2;%��ˮƽͶӰ��ƽ��ֵ
count1=0;
l=1;
for k=1:hight
    if histrow(k)<=levelrow                             
        count1=count1+1;                                
    else 
        if count1>=1
            markrow(l)=k;%������
            markrow1(l)=count1;%�ȿ�ȣ��½�������һ�������㣩
            l=l+1;
        end
        count1=0;
    end
end
markrow2=diff(markrow);%����루����������һ�������㣩
[~,n1]=size(markrow2);
n1=n1+1;
markrow(l)=hight;
markrow1(l)=count1;
markrow2(n1)=markrow(l)-markrow(l-1);
% l=0;
for k=1:n1
    markrow3(k)=markrow(k+1)-markrow1(k+1);%�½���
    markrow4(k)=markrow3(k)-markrow(k);%���ȣ����������½��㣩
    markrow5(k)=markrow3(k)-double(uint16(markrow4(k)/2));%������λ��
end 
%%
%Step7 ���㳵����ת�Ƕ�
%(1)�����������½����ҵ�һ��Ϊ1�ĵ�
[m2,n2]=size(sbw1);%sbw1��ͼ���С
[m1,n1]=size(markrow4);%markrow4�Ĵ�С
maxw=max(markrow4);%�����Ϊ�ַ�
if markrow4(1) ~= maxw%����ϱ�
    ysite=1;
    k1=1;
    for l=1:n2
    for k=1:markrow3(ysite)%�Ӷ�������һ�����½���ɨ��
        if sbw1(k,l)==1
            xdata(k1)=l;
            ydata(k1)=k;
            k1=k1+1;
            break;
        end
    end
    end
else  %����±�
    ysite=n1;
    if markrow4(n1) ==0
        if markrow4(n1-1) ==maxw
           ysite= 0; %���±�
       else
           ysite= n1-1;
       end
    end
    if ysite ~=0
        k1=1;
        for l=1:n2
            k=m2;
            while k>=markrow(ysite) %�ӵױ������һ�����������ɨ��
                if sbw1(k,l)==1
                    xdata(k1)=l;
                    ydata(k1)=k;
                    k1=k1+1;
                    break;
                end
                k=k-1;
            end
        end
    end
end       
%(2)������ϣ�������x�н�
fresult = fit(xdata',ydata','poly1');   %poly1    Y = p1*x+p2
p1=fresult.p1;
angle=atan(fresult.p1)*180/pi; %���Ȼ�Ϊ�ȣ�360/2pi,  pi=3.14
%(3)��ת����ͼ��
subcol = imrotate(subcol1,angle,'bilinear','crop'); %��ת����ͼ��
sbw = imrotate(sbw1,angle,'bilinear','crop');%��תͼ��
figure,subplot(2,1,1),imshow(subcol);title('���ƻҶ���ͼ');%���������ת��ĻҶ�ͼ�������ʾ���ƻҶ���ͼ
subplot(2,1,2),imshow(sbw);title('');%���������ת��ĻҶ�ͼ��
title(['������ת��: ',num2str(angle),'��'] ,'Color','r');%��ʾ���Ƶ���ת�Ƕ�