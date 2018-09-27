var Adoption = artifacts.require("Adoption");
var Ownable = artifacts.require("./Ownable.sol");
var SafeMath = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
  deployer.deploy(SafeMath);
  deployer.link(Ownable, Adoption);
  deployer.link(SafeMath, Adoption);
  deployer.deploy(Adoption);
};