pragma solidity ^0.4.24;
import "../SafeMath.sol";
import "../Ownable.sol";
contract PetShopQuiz is Ownable {
    using SafeMath for uint;
    struct Pet {
        uint petId;
        uint quantity;
        uint price;
        string location;
    }

    modifier inShop(uint petId) {
        require(petsIndex[petId] > 0 && petsIndex[petId] <= pets.length);
        _;
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
    function purchase(uint petId) public inShop(petId) payable returns (bool) {
        // ensure pet in list
        uint petIndex = petsIndex[petId];
        require(pets[petIndex-1].quantity>0);
        require(msg.value>=pets[petIndex-1].price);
        pets[petIndex-1].quantity -= 1;
        records[msg.sender][petIndex-1] += 1;
        emit Purchase(petId, msg.sender, pets[petIndex].quantity);
        return true; 
    }    
    // sell back the pets to owner
    // get ether in return
    function sell(uint petId, uint quantity) public inShop(petId) returns(bool) {
        require(quantity>0);
        uint petIndex = petsIndex[petId];        
        require(records[msg.sender][petId]>=quantity);
        records[msg.sender][petId] -= quantity;
        pets[petIndex - 1].quantity += quantity;
        msg.sender.transfer(pets[petIndex - 1].price * quantity);
        return true;      
    }
    // add one mroe pet
    function addOnePet(uint petId, uint quantity, uint price, string location) public onlyOwner() returns(bool) {
 
        uint petIndex = petsIndex[petId];
        require(petIndex==0); // ensure pet not in list
        
        pets.push(Pet(petId,quantity,price,location));
        petIndex = pets.length;
        petsIndex[petId] = petIndex;
        
        return true;
    }
    // remove a pet from the lsi
    function removePet(uint petId) public onlyOwner() inShop(petId) returns(bool) {
        // remove pet
        uint petIndex = petsIndex[petId];
        pets[petIndex - 1] = pets[pets.length -1];
        delete pets[pets.length -1];
        pets.length--;
        petsIndex[petId] = 0;
        petsIndex[pets[pets.length -1].petId] = petIndex;
        return true;      
    }
    // change a pet's price
    function changePrice(uint petId, uint newPrice) public onlyOwner() inShop(petId)  returns(bool) {
            
        uint petIndex = petsIndex[petId];
        pets[petIndex - 1].price = newPrice;
        return true;       
    }
    // withdraw eth from contract to owner
    function withdrawEth(uint amount) public onlyOwner() returns(bool) {
        owner.transfer(amount);
        return true;
    }
       
    
}