// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./BuyMePlzCoinInterface.sol";

contract BuyMePlzCoin is BuyMePlzCoinInterface {

    string  constant public NAME = "Buy Me Plz Coin";
    string  constant public SYMBOL = "BMP";
    uint8   constant public DECIMALS = 18;
    uint256 constant public TOTAL_SUPPLY = 1000000000000000000000000000000000;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowed;

    constructor() {
		balances[msg.sender] = TOTAL_SUPPLY;
        emit Transfer(address(0x0), msg.sender, TOTAL_SUPPLY);
	}

    function name() external pure override returns (string memory) { return NAME; }
    function symbol() external pure override returns (string memory) { return SYMBOL; }
    function decimals() external pure override returns (uint8) { return DECIMALS; }
    function totalSupply() external pure override returns (uint256) { return TOTAL_SUPPLY; }

    function balanceOf(address user) external view override returns (uint256 balance) {
        return balances[user];
    }

    function transfer(address to, uint256 amount) public override returns (bool success) {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external override returns (bool success) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address user, address spender) external view override returns (uint256 remaining) {
        return allowed[user][spender];
    }

    function transferFrom(address from, address to, uint256 amount) external override returns (bool success) {
        balances[from] -= amount;
        balances[to] += amount;
        allowed[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
}