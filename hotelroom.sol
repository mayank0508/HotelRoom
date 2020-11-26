pragma solidity ^0.6.0;

contract HotelRoom {
    
    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    
    event Occupy (address _occupant, uint _value);
     
     
    address payable public owner; // this code will tell the smart contract that who is the owner of the contract and
                                 //  will always send the amount to this addres everytime a room is booked
    
    
    
    constructor () public {
        owner =msg.sender;//msg.sender is the ethereum address for the user who call this contract (aka the onwer of this contract)
        currentStatus = Statuses.Vacant;
    }
    
    
    modifier onlyWhileVacant {
        //check the Status
        require(currentStatus == Statuses.Vacant, "Currently Occupied."); // this line of code tells us that if the statment is true then it will carry on with 
                                                                           // the code, but if the code is false the the statment in ".." will be aired
        _;
    }
    
    
    modifier costs (uint _amount) {
                //check the Price
        require(msg.value >= _amount, "Not enough ether provided."); // this line of code tells us that if the statment is true then it will carry on with
                                                                     // the code, but if the code is false the the statment in ".." will be aired
        _;
    }
    
    
    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);    
     emit Occupy(msg.sender, msg.value);
    }
}
