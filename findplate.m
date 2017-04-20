function Iplate = findplate(Is)
% �˺���ͨ��һ�Ű������Ƶ�ͼ���ҵ�����λ�ã�
% �����ض�ֵ����ͼ��
% ----------------------------------------
% ����
% Iplate = findplate(Is)
% @���� Is     ԭʼͼ��
% @��� Iplate ����ͼ��
% ----------------------------------------
%                        ���ߣ� � @2017

%% ͼ��Ԥ����
Igray=rgb2gray(Is);%ת��Ϊ�Ҷ�ͼ��
Iedge=edge(Igray,'canny',0.5);%Canny���ӱ�Ե���

se1=[1;1;1]; %���ͽṹԪ�� 
Ierode=imerode(Iedge,se1);    %��ʴͼ��
se2=strel('rectangle',[25,25]); %���νṹԪ��
Ifill=imclose(Ierode,se2);%ͼ����ࡢ���ͼ��

If=bwareaopen(Ifill,2000);%�Ӷ������Ƴ����С��2000��С����

%% ���ƴֶ�λ 
[y,x]=size(If);%size������������������ص���һ�������������������������ص��ڶ����������
Idouble=double(If);

% ���ƴֶ�λ ȷ���е���ʼλ�ú���ֹλ��
Y1=zeros(y,1);%����y��1��ȫ������
for i=1:y
    for j=1:x
        if(Idouble(i,j)==1)
            Y1(i,1)= Y1(i,1)+1;%��ɫ���ص�ͳ��
        end
    end
end

[temp,MaxY]=max(Y1);%Y����������ȷ��������������temp��MaxY��temp������¼Y1��ÿ�е����ֵ��MaxY������¼Y1ÿ�����ֵ���к�
PY1=MaxY;
while ((Y1(PY1,1)>=50)&&(PY1>1))
        PY1=PY1-1;
end
PY2=MaxY;
while ((Y1(PY2,1)>=50)&&(PY2<y))
        PY2=PY2+1;
end
IY=Is(PY1:PY2,:,:);

% ���ƴֶ�λ ȷ���е���ʼλ�ú���ֹλ��
X1=zeros(1,x);%����1��x��ȫ������
for j=1:x
    for i=PY1:PY2
        if(Idouble(i,j,1)==1)
                X1(1,j)= X1(1,j)+1;               
         end  
    end       
end
PX1=1;
while ((X1(1,PX1)<3)&&(PX1<x))
       PX1=PX1+1;
end    
PX3=x;
while ((X1(1,PX3)<3)&&(PX3>PX1))
        PX3=PX3-1;
end
Ip=Is(PY1:PY2,PX1:PX3,:);

%% ���ƾ�ϸ��λ 
% Ԥ����
Ipgray=rgb2gray(Ip); %��RGBͼ��ת��Ϊ�Ҷ�ͼ��
c_max=double(max(max(Ipgray)));
c_min=double(min(min(Ipgray)));
T=round(c_max-(c_max-c_min)/3); %TΪ��ֵ������ֵ
Ipbw=im2bw(Ipgray,T/256);

% ȥ���߿����
[r,s]=size(Ipbw);%size������������������ص���һ�������������������������ص��ڶ����������
Iplate=double(Ipbw);
X2=zeros(1,s);%����1��s��ȫ������
for i=1:r
    for j=1:s
        if(Iplate(i,j)==1)
            X2(1,j)= X2(1,j)+1;%��ɫ���ص�ͳ��
        end
    end
end
[temp,MaxX]=max(X2);
% subplot(2,2,2),plot(0:s-1,X2),title('�ֶ�λ����ͼ���з������ص�ֵ�ۼƺ�'),xlabel('��ֵ'),ylabel('����');

% ȥ�����߿���� 
[g,h]=size(Iplate);
leftwidth=0;rightwidth=0;widthThreshold=5;
while sum(Iplate(:,leftwidth+1))~=0
    leftwidth=leftwidth+1;
end
if leftwidth<widthThreshold   % ��Ϊ��������
    Iplate(:,1:leftwidth)=0;%��ͼ��d��1��KuanDu��ȼ�ĵ㸳ֵΪ��
    Iplate=QieGe(Iplate); %ֵΪ��ĵ�ᱻ�и�
end
% subplot(2,2,3),imshow(Ipd),title('ȥ�����߿�Ķ�ֵ����ͼ��')

 % ȥ���Ҳ�߿����
[e,f]=size(Iplate);%��һ���ü���һ�Σ�������Ҫ�ٴλ�ȡͼ���С
d=f;
while sum(Iplate(:,d-1))~=0
    rightwidth=rightwidth+1;
    d=d-1;
end
if rightwidth<widthThreshold   % ��Ϊ���Ҳ����
    Iplate(:,(f-rightwidth):f)=0;%
    Iplate=QieGe(Iplate); %ֵΪ��ĵ�ᱻ�и�
end
% subplot(2,2,4),imshow(Ipd),title('��ȷ��λ�ĳ��ƶ�ֵͼ��')

end