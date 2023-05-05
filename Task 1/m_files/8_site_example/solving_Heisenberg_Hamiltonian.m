%%%%%% INITIATION OF VARS + INPUT FILE (BEGIN) %%%%%%
fid = fopen('input_J_A_CrBr_3.dat', 'r');
data1 = fscanf(fid, '%f');
N = data1(1);     %% number of sites/magnetic moments 
S = 1.5;          %% magnitude of spins
theta = 60; phi = 180;
A = reshape(data1(2:10), 3, 3).';
J_0 = reshape(data1(11:19), 3, 3).';
J_m120 = reshape(data1(20:28), 3, 3).';
J_p120 = reshape(data1(29:37), 3, 3).';
%%%%%% INITIATION OF VARS + INPUT FILE (END) %%%%%%
%%%%%% FILLING THE PRISTINE HAMILTONIAN == H0 == M (BEGIN) %%%%%%
M = fill_big_matrix_M(N,A,J_0,J_m120,J_p120);
%%%%%% FILLING THE 'BIG' MATRIX == M (END) %%%%%%
%%%%%% VARIATION OF B (BEGIN) %%%%%%
Bstart = -5; Bend = 5; Bstep = 0.25; 
Sinit = zeros(3*N,1);
for l = 1:1:N
  Sinit(3*l-2,1) = 1e-1;
  Sinit(3*l,1) = -sqrt(S*S-Sinit(3*l-2,1)*Sinit(3*l-2,1));
end
hysteresis1 = B_swipe(N,S,M,Sinit,theta,phi,Bstart,Bend,Bstep);
hysteresis2 = B_swipe(N,S,M,-Sinit,theta,phi,Bend,Bstart,-Bstep);
% %%%%%% VARIATION OF B (END) %%%%%%
figure()
hold on
plot(hysteresis1(:,1),hysteresis1(:,2),'k-*');
plot(hysteresis2(:,1),hysteresis2(:,2),'r-*');
hold off
xlim([Bstart Bend]);
ylim([-4/3*S 4/3*S]);
