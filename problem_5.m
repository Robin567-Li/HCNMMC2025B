clc,clear,close all

format long g

p_static = 28.*4;     % J
delta = 0.75;
eta = 0.35;+
N_active = [50,50,50,100];

p_rb = delta.*sum(N_active);
p_transmit = ( 10.^( ([10,10,30,40]-30)./10 ) )./1000; % 要转化单位
p_tx = sum(p_transmit)./eta;

p = p_static + p_rb + p_tx  % 单位 J


