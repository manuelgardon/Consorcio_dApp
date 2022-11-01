// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts";
import "./User.sol";
import "./Employee.sol";
import "./Tenant.sol";

contract Consorcio is Ownable {

    struct Service {
        string service;
        uint price;
    }

    Employee[] private employeeList;
    Tenant[] private tenantList;
    Service[] private serviceList;

    function getEmployeeList() public view returns(Employee[] memory) {
        return employeeList;
    }

    Employee private anEmployee;
    Tenant private aTenant;
    Service private aService;

    receive() external payable {}
    fallback() external payable {}

    function paySalaries() public payable onlyOwner {
        //TODO
        ///Esta funcion deberia recorrer el array y calcular el total de salarios a pagar,
        ///validar que tenga fondos suficientes y si es suficiente, realizar el pago de todos los salarios.
        uint totalAmount = 0;

        for(uint i = 0; i < employeeList.length; i++) {

            totalAmount += employeeList[i].salary;
    
        }
        
        require(address(this).balance >= totalAmount, "Insufficient funds");

        for(uint j = 0; j < employeeList[j].length; j++) {

            (bool success,) = employeeList[j].newAddress.call { value: employeeList[j].salary } ("");
        
        }
    }

    function payAllServices() public {
        //TODO(4): Desarrollar la funcion para poder pagar todos los servicios, 
        /// con las mismas condiciones que la funcion paySalaries()
        uint totalAmount = 0;

        for(uint i = 0; i < serviceList.length; i++) {
            totalAmount += serviceList[i].price;
        }

        require(address(this).balance >= totalAmount, "Insufficient funds");

        for(uint j = 0; j < serviceList.length; j++) {
            
            (bool success,) = 

        }
    }

    function payService(uint index) public {}

    function addNewService(string memory _service, uint _price) public onlyOwner {
        aService = Service(_service, _price);
        serviceList.push(aService);
    }

    function showAddress() public view returns(address) {
        return address(this);
    }

    function addNewTenant(uint _id, address _address, uint _expenses, uint _aptAddress) public onlyOwner {
        aTenant = new Tenant(_id, _address, _expenses, _aptAddress, address(this));
        tenantList.push(aTenant);
    }

    function depositTenant() public payable {
        (bool sent, ) = aTenant.getAddress().call {
            value: msg.value
        }("");

        require (sent == true, "Deposit failed. Try again in some mminutes.");
    }

    function addNewEmployee(
        uint _id,
        address _address,
        string memory _profession,
        string memory _schedule,
        uint _salary
        ) public {
        anEmployee = new Employee( _id, _address, _profession, _schedule, _salary );
        employeeList.push( anEmployee );
    }

    function depositEmployee() public payable {

        (bool sent, ) = anEmployee.getAddress().call { value: msg.value }("");

        require( sent == true, "Deposit failed. Try again in some minutes." );
    }

    function tenantWithdrawal( uint _amount ) public {
        aTenant.withdrawal( _amount );
    }

}