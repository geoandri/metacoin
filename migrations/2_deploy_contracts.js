const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const RedHat = artifacts.require("RedHat");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.deploy(RedHat)
  deployer.link(ConvertLib, MetaCoin);
  deployer.link(RedHat, MetaCoin);
  deployer.deploy(MetaCoin);
};
