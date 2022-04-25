% Aluno:
%   Gabriel Lando (291399)

clear;
close;
clc;

% carrega o package Communications pra usar as funções de encode e decode
pkg load communications;

% Constantes configuraveis 
modulacao = 2; % Ordem de modulacao para M-PSK (2 = BPSK)
n_t = 8; % Quantidade de antenas de transmissao (tambem representa a qtde de simbolos transmitidos)
n_r = 4; % Quantidade de antenas de recepcao

% Constantes derivadas
num_bits = n_t;
H = zeros(n_t, n_r); % Inicializa a matriz H zerada
info = Info(num_bits); % Cria uma instancia da classe de geracao de dados
psk = PSK(modulacao); % Cria uma instancia do modulador M-PSK

% Gerando o pacote de dados para transmitir...
disp("Gerando o pacote de dados para transmitir...");
data = info.generateData();
  
% Modulando vetor de bits usando PSK...
disp("Modulando vetor de bits usando PSK...");
psk_mod = psk.modulate(data);
X_mod = transpose(psk_mod); % Inverte a matriz de 1xN para Nx1

% Transmissao
disp("Gerando a matriz complexa H...");
H = complex(randn(n_r,n_t), randn(n_r,n_t));

disp("Transmitindo os dados...");
Y = H * X_mod;

% Recepcao
disp("Gerando a inversa da matriz complexa H...");
H_inv = pinv(H);

disp("Detectando os simbolos recebidos...");
X_r = H_inv * Y;

% Demodulacao
disp("Demodulando simbolos usando PSK...");
psk_demod = psk.demodulate(X_r);
X_demod = transpose(psk_demod); % Inverte a matriz de Nx1 para 1xN


disp("\n");
% Exibindo os resultados
disp("Dados gerados:");
data

disp("Simbolos modulados transmitidos:");
X_mod

disp("Matriz H:");
H

disp("Matriz pseudo-inversa de H:");
H_inv

disp("Simbolos recebidos antes da deteccao:");
Y

disp("Simbolos recebidos apos a deteccao:");
X_r

disp("Dados demodulados recebidos:");
X_demod

