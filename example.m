%% ���ƴ������
%
%
clear
close all
clc

%% ��ȡ����ͼ��
% [fn,pn,~]=uigetfile('ChePaiKu\*.jpg','ѡ��ͼƬ');
% Is=imread([pn fn]);%����ԭʼͼ��
% clear fn pn
Is=imread('car2.jpg');%����ԭʼͼ��

%% �ҵ�����λ��
Iplate=findplate(Is); clear Is;

%% �����ַ��ָ�
[Ipcrop, Ipchar] = cropplate(Iplate); clear Iplate;

%% �����ַ�ʶ��
% [result, I]=recplate(Ipcrop, Ipchar);

%% ��ʾ���