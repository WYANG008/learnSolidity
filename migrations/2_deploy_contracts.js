var PetShop = artifacts.require("PetShop");
var Ownable = artifacts.require("./Ownable.sol");
var SafeMath = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.deploy(SafeMath);
  deployer.link(Ownable, PetShop);
  deployer.link(SafeMath, PetShop);
  deployer.deploy(PetShop);
};