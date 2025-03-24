// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract GuardaLoteria { 
    uint numeroSorteado;
    address dono;
    uint contadorDeSorteios = 0;
    bool donoRico = false;

    constructor(uint numeroInicial) {
        require (msg.sender.balance >= 99 ether);

        numeroSorteado = numeroInicial;
        dono = msg.sender;
        contadorDeSorteios = 1;

        if (msg.sender.balance > 20 ether){
            donoRico = true;
        } else {
            donoRico = false;
        }

    }

    event TrocoEnviado(address pagador, uint troco);

    function set(uint enviado) public payable comCustoMinimo(1000){
        numeroSorteado = enviado;
        contadorDeSorteios++;
        
        if(msg.value > 1000){
            uint troco = msg.value - 1000;
            payable(msg.sender).transfer(troco);
            emit TrocoEnviado(msg.sender, troco);
        }
    }

    modifier comCustoMinimo(uint min){
        require(msg.value >= min, "Nao foi enviado Ether suficiente");
        _;
    }
    
    function get() public view returns (uint) {
        return numeroSorteado;
    }

}