pragma solidity ^0.4.24;

import './SafeMath.sol';
import './Ownable.sol';

contract PetShop is Ownable {
    using SafeMath for uint;

     struct Pet {
        uint petId;
        uint quantity;
        uint price;
        string location;
    }
    Pet[] public pets; 
    mapping(uint => uint) public petsIndex; // petid to petIndex + 1
    mapping(address => mapping(uint => uint)) public records;

    event Purchase(uint petId, address buyer, uint newQuantity);
    event Sell(uint petId, address seller, uint quantity);

    constructor(uint initPrice, uint initQuantity) public {
        // init 16 pets with different price

        for(uint i = 0; i < 16; i ++) {
            petsIndex[i] = i + 1;
            pets.push(Pet(i, initQuantity,  1 ether * initPrice, 'SG' ));
        }
    }
    
    // Purchase a pet
    // input petid to purchase, return true or false
    // reduce pet's quantity after purchase
    // emit purchase event
    function purchase(uint petId) payable public returns (bool) {
        // 
        require(petsIndex[petId] > 0);
        uint petIndex = petsIndex[petId].sub(1);
        require(pets[petIndex].price <= msg.value && pets[petIndex].quantity > 0);
        records[msg.sender][petId] += 1;
        pets[petIndex].quantity -= 1;
        emit Purchase(petId, msg.sender, pets[petIndex].quantity);
        return true;

    }

    // sell back the pets to owner
    // get ether in return
    function sell(uint petId, uint quantity) public returns(bool) {
        uint petIndex = petsIndex[petId];
        require(petIndex > 0);
        require(records[msg.sender][petId] >= quantity);
        records[msg.sender][petId] -= quantity;
        msg.sender.transfer(quantity * pets[petIndex]. price);
        return true;
    }

    // add one mroe pet
    function addOnePet(uint petId, uint quantity, uint price, string location) public onlyOwner() returns(bool) {
        uint petIndex = petsIndex[petId];
        require(petIndex == 0);
        pets.push(Pet(petId, quantity,  1 ether * price, location ));
        petsIndex[petId] = pets.length - 1;
        return true;
    }

    // remove a pet from the lsi
    function removePet(uint petId) public onlyOwner() returns(bool) {
        uint petIndex = petsIndex[petId];
        require(petIndex > 0);
        for(uint i = 0; i < pets.length; i ++){
            if (petIndex - 1 ==i){
                delete pets[i];
                pets[i] = pets[pets.length - 1];
                pets.length --;
                break;
            }
        }
        return true;

    }

    // change a pet's price
    function changePrice(uint petId, uint newPrice) public onlyOwner()  returns(bool) {
        uint petIndex = petsIndex[petId];
        require(petIndex > 0);
        pets[petIndex - 1].price = newPrice;
        return true;
       
    }

    // withdraw eth from contract to owner
    function withdrawEth(uint amount) public onlyOwner() returns(bool) {
        require(amount < address(this).balance);
        msg.sender.transfer(amount);
        return true;
    }

}