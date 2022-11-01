// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./User.sol";

contract Tenant is User {

    uint private servicePrice;
    uint private aptAddress;
    address private consorcioAddress;

    event ExpensesPaid(uint pricePaid);
    
    constructor(
        uint newId,
        address newAddress,
        uint newServicePrice,
        uint newAptAddress,
        address newConsorcioAddress
    ) payable User(newId, newAddress) {
        servicePrice = newServicePrice;
        aptAddress = newAptAddress;
        consorcioAddress = newConsorcioAddress;
    }

    function deposit() public payable {
        emit EtherReceived(msg.value, address(this), address(this).balance);
    }

    function payExpenses() public {
        require(address(this).balance >= servicePrice, "Insufficient funds");
        
        (bool success,) = consorcioAddress.call{value: servicePrice}("");

        require(success == true, "Payment failed. Try again in some minutes.");

        emit ExpensesPaid(servicePrice);
    }

}