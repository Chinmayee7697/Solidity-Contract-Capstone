 # Decentralized Marketplace

- A decentralized marketplace is an online market platform where the sellers can sell their products directly to the buyers without any intermediary and buyers can directly pay them money in the form of ether or bitcoins.
- A decentralized marketplace operates on a blockchain, which is a distributed and immutable ledger. Smart contracts, and self-executing code, replace the need for intermediaries.


## Problem Statement
**Problem Statement : Decentralized Marketplace**

Objective: Develop a Decentralized Marketplace contract where users can list items for sale and others can purchase them using Ether.

•	Sellers should list items with a name and price.

•	Buyers can purchase items by sending Ether equal to the listed price.

•	Ensure that the Ether sent by buyers is transferred to the seller.

•	Implement functionality to mark items as sold upon purchase to prevent further sales.


## Code Overview

### 1. Struct : Product

  ```bash
     struct Product{
        uint256 productId;
         string name;
         uint256 price;
         address seller;
         bool sold;
         string details; 
         }
```


- productId: Unique identifier for each product
-	name: Name of the product
-	price: The listed price of the product in ether
-	seller: address of the seller
-	sold: tells whether the respective product is sold or not
-	details: gives the details of the product

### 2.Address of owner and mapping functions

```bash
    	address public owner;
	
	    //mapping productId with Product
	    mapping(uint256=>Product) public products;
	
	    //total number of products in a list
	    uint256 public productCount;
	
	    // Mapping to keep track of authorized sellers
	    mapping(address => bool) public authorizedSellers;
```


-	Declaring the address of the owner as a state variable and also making it public
-	Mapping the productId with Product. The uint256 indicates the ID of the product.
-	productCount keeps track of the total number of products listed.
-	authorizedSellers keep track of whether the given account is authorized or not.


### 3. Modifiers

```bash
modifier authOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier isAuthorizedSeller() {
        require(authorizedSellers[msg.sender], "Real ID se aao seller bhai");
        _;
    }

    modifier productAvailable(uint256 productId) {
         require(productId < productCount, "Product is Out of Stock");
        _;
    }

    modifier notSold(uint256 productId) {
        require(!products[productId].sold, "Sold out");
        _;
    }
```

-	authOwner(): Ensures that the caller is the owner of the contract.
-	isAuthorizedSeller(): Ensures that the caller is an authorized seller.
-	productAvailable(uint256 productId): Ensures that the product is available (within the product count).
-	notSold(uint256 productId): Ensures that the product is not sold.

### 4. Functions

**1.	authorizeSeller(address _seller)**

Purpose: Allows the owner to authorize addresses as sellers.

**2.	addProduct(string memory _name, uint256 _price, string memory _details)**

Purpose: Authorized sellers can add products to the marketplace.

**3.	buyProduct(uint256 productId)**

Purpose: Buyers can purchase products by sending Ether equal to the listed price.

**4.	isProductSold(uint256 productId) external view returns (bool)**

Purpose: Check if a product has been sold.

**5.	getProductIdByName(string memory productName) external view returns (uint256)**

Purpose: Retrieve the product ID by providing the name.

## CONCLUSION
The Decentralized Marketplace smart contract provides a secure and transparent platform for users to engage in decentralized buying and selling of products using the Ethereum blockchain. It incorporates authorization mechanisms, secure transaction handling, and additional features for enhanced functionality.


