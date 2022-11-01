// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./User.sol";

contract Employee is User {

    string private profession;
    string private schedule;
    uint private salary;

    mapping(uint => uint) salaryById;

    constructor(
        uint newId,
        address newAddress,
        string memory newProfession,
        string memory newSchedule,
        uint newSalary
    ) User(newId, newAddress) {
        profession = newProfession;
        schedule = newSchedule;
        salary = newSalary;
        salaryById[newId] = salary;
    }

    function getSalary(uint _id) public view returns(uint) {
        return salaryById[_id];
    }
}