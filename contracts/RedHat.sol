pragma solidity >=0.4.25 <0.7.0;

contract RedHat {
	mapping (address => uint) hats;
	
	event RedHatEarned(address indexed _to);

	constructor() public {
		hats[tx.origin] = 100;
	}
	
	function earnRedHat(address receiver) public returns(bool sufficient) {
		if (hats[receiver] == 1) return false;
		hats[receiver] += 1;
		emit RedHatEarned(receiver);
		return true;
	}
	
	function getHats(address addr) public view returns(uint) {
		return hats[addr];
	}
}