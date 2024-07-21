# DegenToken Documentation

Welcome to the DegenToken, a custom ERC20 token that integrates burning capabilities and a unique system for redeeming in-game items. Built on the Ethereum blockchain, DegenToken ("DGN") is designed for use in decentralized applications (dApps) that require a token with both monetary and utility functions. This README provides an overview of the DegenToken, its functionalities, and guidance for interaction.
Features

    ERC20 Compliance: DegenToken adheres to the ERC20 standard, ensuring compatibility with the vast ecosystem of Ethereum wallets and dApps.
    Burnable: Incorporates ERC20Burnable for token burning, allowing users to permanently remove tokens from circulation.
    Ownable: Utilizes the Ownable contract to restrict certain actions (e.g., minting and adding items) to the contract owner.
    Item Redeeming: Unique feature allowing tokens to be used for redeeming in-game items, with item attributes and quantities managed on-chain.

# Contract Deployment

The DegenToken is deployed with an initial owner address, which is set during the contract creation. This owner has exclusive rights to mint new tokens and add new items for redemption.
Constructor

# solidity

```constructor(address initialOwner) ERC20("Degen", "DGN") Ownable(initialOwner)```

    initialOwner: The address that will be granted initial ownership of the contract, capable of minting tokens and managing items.

Key Functions

addItem

Allows the owner to add new items for redemption.

    Parameters:
        id: Unique identifier for the item.
        name: The name of the item.
        quantity: Available quantity for redemption.

mint

Enables the owner to mint new tokens and allocate them to a specified address.

    Parameters:
        to: Address to receive the minted tokens.
        amount: Amount of tokens to mint.

transfer

Overrides the ERC20 transfer function to include additional checks.

    Parameters:
        recipient: The address of the recipient.
        amount: The amount of tokens to transfer.

redeem

Allows users to redeem tokens for in-game items.

    Parameters:
        itemId: The ID of the item to redeem.
        quantity: The quantity of the item to redeem.

getBalance

Returns the token balance of the caller.
burn and burnFrom

Enable token holders and approved addresses to burn tokens, reducing the total supply.
Events
Redeemed

Emitted when an item is successfully redeemed.

    Parameters:
        user: The address of the user redeeming the item.
        itemId: The ID of the redeemed item.
        quantity: The quantity of the item redeemed.