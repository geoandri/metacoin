pragma solidity >=0.4.25 <0.7.0;

import "./ConvertLib.sol";
import "./RedHat.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);
	event Donation(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[tx.origin] = 10000;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		if (balances[receiver] >= 100) {
			RedHat rd = RedHat(0xAd8e049ed83A9A6aE34FF0D6aDE826003dB909b5);
			rd.earnRedHat(receiver);
		}
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}
	
	function sendCoinWithDonation(address receiver, address donationReceiver, uint amount, uint percentage) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		uint donation;
		if (amount != 0 ) 
		{
			donation = amount*percentage/100;
			amount -= donation;
		}
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		balances[donationReceiver] += donation;
		emit Transfer(msg.sender, receiver, amount);
		emit Donation(msg.sender, donationReceiver, donation);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
