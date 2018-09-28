pragma solidity ^0.4.24;

import './SafeMath.sol';
import './Ownable.sol';

contract PetShopQuiz is Ownable {
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
            pets.push(Pet(i, initQuantity,  1 ether * initPrice, "SG"));
        }
    }
    
    // Purchase a pet
    // input petid to purchase, return true or false
    // reduce pet's quantity after purchase
    // emit purchase event
    function purchase(uint petId) payable public returns (bool) {
        // 
  

    }

    // sell back the pets to owner
    // get ether in return
    function sell(uint petId, uint quantity) public returns(bool) {
      
    }

    // add one mroe pet
    function addOnePet(uint petId, uint quantity, uint price, string location) public onlyOwner() returns(bool) {
      
    }

    // remove a pet from the lsi
    function removePet(uint petId) public onlyOwner() returns(bool) {
       

    }

    // change a pet's price
    function changePrice(uint petId, uint newPrice) public onlyOwner()  returns(bool) {
     
       
    }

    // withdraw eth from contract to owner
    function withdrawEth(uint amount) public onlyOwner() returns(bool) {
       
    }

}