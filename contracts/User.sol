// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

abstract contract User {

    uint public id;
    address public withdrawalAddress;

    event WithdrawalSuccessful(uint addressBalance);
    event EtherReceived(uint amount, address tenantAddress, uint balance);

    receive() external payable {
        emit EtherReceived(msg.value, address(this), address(this).balance);
    }
    fallback() external payable {
        emit EtherReceived(msg.value, address(this), address(this).balance);
    }

    constructor(uint newId, address newAddress) {
        id = newId;
        withdrawalAddress = newAddress;
    }

    function withdrawal(uint _amount) public {
        require(
            address(this).balance >= _amount,
            "User: Insufficient funds"
        );
        
        (bool success,) = withdrawalAddress.call{value: _amount}("");

        require(success == true, "Withdrawal failed. Try again in some minutes.");

        emit WithdrawalSuccessful(address(this).balance);
    }

    function getAddress() public view returns (address) {
        return address(this);
    }

}





