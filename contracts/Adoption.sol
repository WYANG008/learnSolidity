pragma solidity ^0.4.24;

import './SafeMath.sol';
import './Ownable.sol';

contract Adoption is Ownable {
    using SafeMath for uint;

     struct Pet {
        uint age;
        uint price;
        string location;
    }
    address[] public pets;
    mapping(address => bool) public existingPets;

    event Adoption(uint petId, address adoptor);
    
    // Adopting a pet
    function adopt(uint petId) public returns (uint) {
        require(petId >= 0 && petId <= 15);

        pets[petId] = msg.sender;
        emit Adoption(petId, msg.sender);
        return petId;
    }

    // Retrieving the adopters
    function getAdopters() public view returns (address[16]) {
        return adopters;
    }

    // Retrieving the adopters



    /*****************HOME WORK***************** */
    /**Implement Below Functions */

    // 1. make adopt payable, can adopt with value more than price
    // 2. refound a pet
    // 3. add contract owner
    // 4. owner can remove a pet from the adopterList
    // 5. owner can register a pet into the adopterList
    // 6. owner can change a pet's price, location and age
    // 7. owner can withDraw deposited eth


    /** Add Test */
    

}