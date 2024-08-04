// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, ERC20Burnable, Ownable {
    event Redeemed(address indexed user, uint256 itemId, uint256 quantity);

    struct Item {
        uint256 id;
        string name;
        uint256 quantity;
    }

    Item[] public items;

    mapping(address => mapping(uint256 => uint256)) public userItems; // Tracks user's redeemed items

    constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner) {}

    function addItem(uint256 id, string memory name, uint256 quantity) public onlyOwner {
        items.push(Item(id, name, quantity));
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeem(uint256 itemId, uint256 quantity) public {
        Item storage item = items[itemId];
        require(item.id > 0, "Invalid item ID");
        require(item.quantity >= quantity, "Insufficient quantity to redeem");
        
        uint256 requiredTokens = calculateTokenCost(itemId, quantity);
        require(balanceOf(msg.sender) >= requiredTokens, "Insufficient tokens to redeem");

        // Update item quantity and transfer item to the user
        item.quantity -= quantity;
        userItems[msg.sender][itemId] += quantity;

        // Burn the required amount of tokens
        burn(requiredTokens);

        emit Redeemed(msg.sender, itemId, quantity);
    }

 function calculateTokenCost(uint256 itemId, uint256 quantity) internal pure returns (uint256) {
    uint256 costPerItem = itemId * 10**18; // Assuming 1 token per item, scaled to 18 decimal places
    return quantity * costPerItem;
}


    function getBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burn(uint256 amount) public override {
        require(balanceOf(_msgSender()) >= amount, "ERC20: burn amount exceeds balance");
        _burn(_msgSender(), amount);
    }

    function burnFrom(address account, uint256 amount) public override {
        require(balanceOf(account) >= amount, "ERC20: burn amount exceeds balance");
        _burn(account, amount);
    }
}
